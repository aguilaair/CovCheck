import 'dart:convert';

import 'package:covid_checker/certs/certs.dart';
import 'package:covid_checker/generated/l10n.dart';
import 'package:covid_checker/models/result.dart';
import 'package:covid_checker/models/settings.dart';
import 'package:covid_checker/utils/base45.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:universal_io/io.dart';

import '../widgets/camera/camera_overlay.dart';
import '../widgets/camera/camera_view.dart';
import '../widgets/certOverview/result_card_overview.dart';
import '../widgets/molecules/logo.dart';

import "package:covid_checker/utils/gzip/gzip_decode_stub.dart" // Version which just throws UnsupportedError
    if (dart.library.io) "package:covid_checker/utils/gzip/gzip_decode_io.dart"
    if (dart.library.js) "package:covid_checker/utils/gzip/gzip_decode_js.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.setLocale}) : super(key: key);

  final void Function(Locale, {bool shouldSetState}) setLocale;

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

  Settings? settings;

  FocusNode? universalPdaFocusNode;
  TextEditingController? universalPdaTextEditingController;

  @override
  void initState() {
    /// Cycle through all of the certificates and extract the KID and X5C values, mapping them into certMap.
    /// This is a relatively expensive process so should be run as little as possible.
    (certs["dsc_trust_list"] as Map).forEach((key, value) {
      for (var element in (value["keys"] as List)) {
        certMap[element["kid"]] = element["x5c"][0];
      }
    });
    loadSettings();
    super.initState();
  }

  void loadSettings() async {
    final settingsLoaded = Hive.box('settings').get(
      "settings",
    );

    if (settingsLoaded == null) {
      settings = (await Settings.getNewSettings(context));
      Hive.box('settings').put("settings", settings!.toJson());
    } else {
      settings = Settings.fromJson(settingsLoaded);
    }

    if (settings!.isPdaModeEnabled && settings!.isPda) initPda();
    widget.setLocale(Locale(settings!.locale), shouldSetState: false);

    if (mounted) setState(() {});
  }

  void initPda() {
    // PDA Checking

    universalPdaFocusNode ??= FocusNode();
    universalPdaTextEditingController ??= TextEditingController();

    universalPdaFocusNode!.requestFocus();
    print("Getting focus");

    universalPdaFocusNode!.addListener(() {
      if (!universalPdaFocusNode!.hasFocus) {
        print("Getting focus");
        universalPdaFocusNode!.requestFocus();
      }
    });

    if (Platform.isAndroid) {
      honeywellScanner ??= HoneywellScanner();

      honeywellScanner!.setScannerCallBack(this);
      honeywellScanner!.setProperties({
        ...CodeFormatUtils.getAsPropertiesComplement([CodeFormat.QR_CODE]),
        'DEC_CODABAR_START_STOP_TRANSMIT': true,
        'DEC_EAN13_CHECK_DIGIT_TRANSMIT': true,
      });
      honeywellScanner!.startScanner();
    }
    try {
      controller?.stopCamera();
    } catch (e) {
      print("Cannot stop camera");
    }
    controller?.dispose();
    controller = null;
    Hive.box('settings')
        .put("settings", settings!.copyWith(isPdaModeEnabled: true).toJson());
    settings = settings!.copyWith(isPdaModeEnabled: true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        controller?.resumeCamera();
        honeywellScanner?.resumeScanner();
        if (!(universalPdaFocusNode?.hasFocus ?? false)) {
          universalPdaFocusNode!.requestFocus();
          print("Getting focus");
        }
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

    if (kIsWeb && isWarningDismissed) {
      WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog(
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
          ));
    }

    /// Main widget Stack, it is in a separtate varialble to make lasyouts much easier
    final widgetList = <Widget>[
      /// Logo will only be shown if in portrait, dunno whe it can go in landsacpe
      if (orientation == Orientation.portrait)
        Logo(
          settings: settings,
          updateSettings: setSettings,
        ),

      /// Camera Stack
      if (!(settings?.isPdaModeEnabled ?? true))
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (universalPdaFocusNode != null &&
                  universalPdaTextEditingController != null)
                SizedBox(
                  width: 1,
                  height: 1,
                  child: Visibility(
                    child: TextField(
                      focusNode: universalPdaFocusNode,
                      keyboardType: TextInputType.none,
                      onSubmitted: (value) {
                        onDecoded(value);
                        universalPdaTextEditingController?.clear();
                      },
                      controller: universalPdaTextEditingController,
                    ),
                    visible: false,
                    maintainSize: true,
                    maintainInteractivity: true,
                    maintainState: true,
                    maintainAnimation: true,
                  ),
                ),
              CertSimplifiedView(
                isPda: settings?.isPda ?? false,
                toggleCamPda: togglePdaMode,
                coseResult: coseResult,
                barcodeResult: result,
                dismiss: dismissResults,
                processedResult: processedResult,
                setSettings: setSettings,
                settings: settings,
              ),
            ],
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

            /// If portrait set out in column
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
  }

  @override
  void onDecoded(String? hwDecodedQR) {
    final scanData = Barcode(hwDecodedQR, BarcodeFormat.qrcode,
        hwDecodedQR != null ? utf8.encode(hwDecodedQR) : null);
    scanDataProcessing(scanData);
  }

  @override
  void onError(Exception error) {}

  void togglePdaMode() {
    if (!settings!.isPdaModeEnabled) {
      setState(() {
        initPda();
      });
    } else {
      setState(() {
        honeywellScanner?.stopScanner();
        honeywellScanner = null;
        universalPdaFocusNode?.unfocus();
        universalPdaFocusNode?.dispose();
        universalPdaTextEditingController?.dispose();
        universalPdaFocusNode = null;
        universalPdaTextEditingController = null;
        Hive.box('settings').put(
            "settings", settings!.copyWith(isPdaModeEnabled: false).toJson());
        settings = settings!.copyWith(isPdaModeEnabled: false);
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
    universalPdaFocusNode?.dispose();
    universalPdaTextEditingController?.dispose();
    universalPdaFocusNode = null;
    universalPdaTextEditingController = null;
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

  void setSettings(Settings newSettings) {
    if (newSettings != settings) {
      if (settings!.locale != newSettings.locale) {
        widget.setLocale(Locale(newSettings.locale));
      }
      if ((newSettings.isPda == false) &&
          (settings!.isPdaModeEnabled == true)) {
        togglePdaMode();
        newSettings = newSettings.copyWith(isPdaModeEnabled: false);
      }
      Hive.box('settings').put('settings', newSettings.toJson());
      settings = newSettings;
      if (mounted) setState(() {});
    }
  }
}
