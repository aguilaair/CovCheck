import 'dart:convert';
import 'dart:io';

import 'package:covid_checker/certs/certs.dart';
import 'package:covid_checker/models/result.dart';
import 'package:covid_checker/utils/base45.dart';
import 'package:covid_checker/utils/gen_swatch.dart';
import 'package:covid_checker/widgets/camera/camera_overlay.dart';
import 'package:covid_checker/widgets/camera/camera_view.dart';
import 'package:covid_checker/widgets/cert_simplified_view.dart';
import 'package:covid_checker/widgets/logo.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

import 'package:honeywell_scanner/honeywell_scanner.dart';

import "package:covid_checker/utils/gzip/gzip_decode_stub.dart" // Version which just throws UnsupportedError
    if (dart.library.io) "package:covid_checker/utils/gzip/gzip_decode_io.dart"
    if (dart.library.js) "package:covid_checker/utils/gzip/gzip_decode_js.dart";

void main() {
  runApp(const CovCheckApp());
}

class CovCheckApp extends StatelessWidget {
  const CovCheckApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'CovCheck',
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xFF262DC9)),
        primaryColor: const Color(0xFF262DC9),
        backgroundColor: const Color(0xffECEEFF),
      ),
      darkTheme: ThemeData.dark().copyWith(
        backgroundColor: const Color(0xff080B27),
        cardColor: const Color(0xff050612),
        primaryColor: const Color(0xFF262DC9),
        primaryColorDark: const Color(0xFF262DC9),
      ),
      home: const MyHomePage(title: 'CovCheck'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with WidgetsBindingObserver
    implements ScannerCallBack {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  /// Barcode Result will store the raw data and type of Barcode which has been scanned
  /// We are expecting a QR code, which starts with HC1
  Barcode? result;

  /// QR Controller controls the reader and its state
  QRViewController? controller;

  /// After successfull decoding, COSE Result will be populated with a valid certificate
  /// and the payload contained in the QR Code, processed and ready for the data
  /// to be extracted.
  CoseResult? coseResult;

  /// On InitState we need to convert the raw ceritificates into a map where the keys are
  /// KIDs and the x5c certificates are the value, will be used to verify ceritificate authenticity
  Map<String, String> certMap = {};

  /// Processed Result will store all of the data in a easy-to-use model, ready for viewing within the app
  Result? processedResult;

  /// Store if we should show the snackbar, only on web
  bool isWarningDismissed = false;

  HoneywellScanner? honeywellScanner;

  bool? isPda = true;

  @override
  void initState() {
    /// Cycle through all of the certificates and extract the KID and X5C values, mapping them into certMap.
    /// This is a relatively expensive process so should be run as little as possible.
    (certs["dsc_trust_list"] as Map).forEach((key, value) {
      for (var element in (value["keys"] as List)) {
        certMap[element["kid"]] = element["x5c"][0];
      }
    });
    initPda();
    super.initState();
  }

  void initPda() async {
    // PDA Checking
    if ((isPda ?? true)) {
      if ((kIsWeb || !Platform.isAndroid) && mounted) {
        // If on web or not Android there is no way it can support PDA.
        setState(() {
          isPda = false;
        });
      } else if (!kIsWeb && Platform.isAndroid) {
        if (isPda == null || (isPda = true && honeywellScanner == null)) {
          // Instantiate honeywell scanner
          honeywellScanner = HoneywellScanner();

          // Check PDA availability
          if (isPda == null) {
            isPda = await honeywellScanner!.isSupported();
            if (!isPda!) {
              setState(() {
                honeywellScanner = null;
              });
              return;
            }
          }
        }

        // Check if it is supported and that the widget is still available
        if (isPda!) {
          // Supported, so set up the scanner with QR code scanning capabilities
          honeywellScanner?.setScannerCallBack(this);
          honeywellScanner?.setProperties({
            ...CodeFormatUtils.getAsPropertiesComplement([CodeFormat.QR_CODE]),
            'DEC_CODABAR_START_STOP_TRANSMIT': true,
            'DEC_EAN13_CHECK_DIGIT_TRANSMIT': true,
          });
          setState(() {
            honeywellScanner?.startScanner();
            controller?.stopCamera();
            controller?.dispose();
            controller = null;
          });
        }
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        controller?.resumeCamera();
        honeywellScanner?.resumeScanner();
        break;
      case AppLifecycleState.inactive:
        controller?.pauseCamera();
        honeywellScanner?.pauseScanner();
        break;
      case AppLifecycleState
          .paused: //AppLifecycleState.paused is used as stopped state because deactivate() works more as a pause for lifecycle
        honeywellScanner?.pauseScanner();
        controller?.pauseCamera();
        break;
      case AppLifecycleState.detached:
        honeywellScanner?.pauseScanner();
        controller?.pauseCamera();
        break;
      default:
        break;
    }
  }

  @override
  void reassemble() {
    /// In some cases we need to restart the camera when rotating and in development, this will do it for us
    try {
      controller?.pauseCamera();
      controller?.resumeCamera();
    } catch (e) {
      controller?.dispose();
      controller = null;
    }

    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    /// Get MediaQuery for size & orientation. Used for layout
    MediaQueryData mq = MediaQuery.of(context);

    /// Oriantetion from mediaquery
    Orientation orientation = mq.orientation;

    /// Size from mediaquery
    Size size = mq.size;

    if (kIsWeb && !isWarningDismissed) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              S.of(context).webwarntext,
            ),
            title: Text(S.of(context).webwarntitle),
            actions: [
              TextButton(
                  onPressed: () {
                    isWarningDismissed = true;
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok"))
            ],
          );
        },
      );
    }

    /// Main widget Stack, it is in a separtate varialble to make lasyouts much easier
    final widgetList = <Widget>[
      /// Logo will only be shown if in portrait, dunno whe it can go in landsacpe
      if (orientation == Orientation.portrait) const Logo(),

      /// Camera Stack
      if (honeywellScanner == null)
        Expanded(
          flex: 1,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              /// Camera View
              CameraView(
                  onQRViewCreated: _onQRViewCreated, qrKey: qrKey, size: size),

              /// Utility buttons for changing camera, flash and restarting the camera if it crashes.
              if (!kIsWeb) CameraOverlay(controller: controller),
            ],
          ),
        ),

      /// Details Section
      Expanded(
        flex: 1,
        child: Padding(
          padding: orientation == Orientation.portrait
              ? EdgeInsets.zero
              : const EdgeInsets.only(right: 10),
          child: CertSimplifiedView(
            isPda: isPda ?? false,
            toggleCamPda: togglePdaMode,
            coseResult: coseResult,
            barcodeResult: result,
            dismiss: dismissResults,
            processedResult: processedResult,
          ),
        ),
      ),
    ];

    /// UI declaration
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: MediaQuery.of(context).orientation == Orientation.landscape

            /// If landscape then set out in a Row (Camera) (Details)
            ? Row(
                children: widgetList,
              )

            /// If porrtait set out in column
            /// (Camera)
            /// (Details)
            : Column(
                children: widgetList,
              ),
      ),
    );
  }

  /// When the QR view becomes available this fuction will be invoked
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    /// We listen to QR codes that might be sannned
    controller.scannedDataStream.listen(
      (scanData) {
        scanDataProcessing(scanData);
      },
    );
    setState(() {});
  }

  @override
  void onDecoded(String? hwDecodedQR) {
    final scanData = Barcode(hwDecodedQR, BarcodeFormat.qrcode,
        hwDecodedQR != null ? utf8.encode(hwDecodedQR) : null);
    scanDataProcessing(scanData);
  }

  @override
  void onError(Exception error) {
    // Do Nothing
  }

  void togglePdaMode() {
    if (isPda! && honeywellScanner == null) {
      initPda();
    } else {
      setState(() {
        honeywellScanner = null;
      });
    }
  }

  /// Utility function so that the dismissal clears the card
  void dismissResults() {
    setState(() {
      coseResult = null;
      result = null;
      processedResult = null;
    });
  }

  /// When disposing, get rid of the QR Code controller too.
  @override
  void dispose() {
    controller?.dispose();
    honeywellScanner?.stopScanner();
    super.dispose();
  }

  void scanDataProcessing(Barcode scanData) {
    if (scanData.code != null &&
        scanData.code!.startsWith("HC1:") &&
        scanData.code! != (result?.code)) {
      /// Create variable to store gzip and base45 decoded data
      List<int> scanres;
      try {
        /// Decode the base 45 data after removing the HC1: prefix
        scanres = Base45.decode(scanData.code!.replaceAll("HC1:", ""));

        /// Decode the gzip data which was decoded from the base45 string
        scanres = gzipDecode(scanres);

        /// Pass the data onto the Cose decoder where it will match it to a certificate (if valid)
        var cose = Cose.decodeAndVerify(scanres, certMap);

        /// Vibrate as we're done
        HapticFeedback.lightImpact();

        setState(() {
          /// Update the state and set cose and scanData
          coseResult = cose;
          result = scanData;

          /// Process payload from cose and extract the data
          processedResult = Result.fromDGC(cose.payload);
        });
      } catch (e) {
        /// If there are any issues assume QR was corrupted, set as invalid format.
        HapticFeedback.lightImpact();
        setState(() {
          coseResult = CoseResult(
              payload: {},
              verified: false,
              errorCode: CoseErrorCode.invalid_format,
              certificate: null);
          result = scanData;
          processedResult = null;
        });
      }
    }
  }
}
