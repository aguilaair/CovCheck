import 'dart:math';

import 'package:covid_checker/certs/certs.dart';
import 'package:covid_checker/models/result.dart';
import 'package:covid_checker/utils/base45.dart';
import 'package:covid_checker/utils/gen_swatch.dart';
import 'package:covid_checker/widgets/cert_simplified_view.dart';
import 'package:covid_checker/widgets/logo.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  @override
  void initState() {
    /// Cycle through all of the certificates and extract the KID and X5C values, mapping them into certMap.
    /// This is a relatively expensive process so should be run as little as possible.
    (certs["dsc_trust_list"] as Map).forEach((key, value) {
      for (var element in (value["keys"] as List)) {
        certMap[element["kid"]] = element["x5c"][0];
      }
    });
    super.initState();
  }

  @override
  void reassemble() {
    /// In some cases we need to restart the camera when rotating and in development, thsi will do it for us
    controller!.pauseCamera();
    controller!.resumeCamera();
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
              "The Web Experience should is intended for test use, please install the mobile app for the best experience",
            ),
            title: Text("Web Experience"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"))
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
      Expanded(
        flex: 1,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            /// Camera View
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: QRView(
                  key: qrKey,
                  overlay: QrScannerOverlayShape(
                      cutOutWidth: min(size.width * 0.65, size.height * 0.65),
                      cutOutHeight: min(size.width * 0.65, size.height * 0.65),
                      borderRadius: 15,
                      overlayColor: Colors.black.withAlpha(100)),
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
            ),

            /// Utility buttons for changing camera, flash and restarting the camera if it crashes.
            Positioned(
              right: 20,
              top: 10,
              child: Row(
                children: [
                  /// Flash
                  Tooltip(
                    message: S.of(context).toggleflash,
                    child: IconButton(
                      onPressed: () {
                        controller!.toggleFlash();
                      },
                      icon: const Icon(
                        Icons.flash_on_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  /// Rotate/Change camera
                  Tooltip(
                    message: S.of(context).rotatecamera,
                    child: IconButton(
                      onPressed: () {
                        controller!.flipCamera();
                      },
                      icon: const Icon(
                        Icons.cameraswitch_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  /// Restart Camera
                  Tooltip(
                    message: S.of(context).restartcamera,
                    child: IconButton(
                      onPressed: () {
                        controller!.pauseCamera();
                        controller!.resumeCamera();
                      },
                      icon: const Icon(
                        Icons.restart_alt_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
              coseResult: coseResult,
              barcodeResult: result,
              dismiss: dismissResults,
              processedResult: processedResult,
            ),
          )),
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
    controller.scannedDataStream.listen((scanData) {
      /// Ignore all QR codes with are empty, do not start with HC1:, or are the same as the last scanned code.
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
    });
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
    super.dispose();
  }
}
