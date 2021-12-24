import 'dart:io';
import 'dart:math';

import 'package:covid_checker/certs/certs.dart';
import 'package:covid_checker/models/result.dart';
import 'package:covid_checker/utils/base45.dart';
import 'package:covid_checker/utils/gen_swatch.dart';
import 'package:covid_checker/widgets/cert_simplified_view.dart';
import 'package:covid_checker/widgets/logo.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
      home: const MyHomePage(title: 'CovCheck Main Page'),
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
  Barcode? result;
  String? decodedResult;
  QRViewController? controller;
  CoseResult? coseResult;
  Map<String, String> certMap = {};
  Result? processedResult;

  @override
  void initState() {
    (certs["dsc_trust_list"] as Map).forEach((key, value) {
      for (var element in (value["keys"] as List)) {
        certMap[element["kid"]] = element["x5c"][0];
      }
    });
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    Orientation orientation = mq.orientation;
    Size size = mq.size;

    final widgetList = <Widget>[
      if (orientation == Orientation.portrait) const Logo(),
      Expanded(
        flex: 1,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
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
            Positioned(
              right: 20,
              top: 10,
              child: Row(
                children: [
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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: MediaQuery.of(context).orientation == Orientation.landscape
            ? Row(
                children: widgetList,
              )
            : Column(
                children: widgetList,
              ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null &&
          scanData.code!.startsWith("HC1:") &&
          scanData.code! != (result?.code)) {
        List<int> scanres;
        try {
          scanres = Base45.decode(scanData.code!.replaceAll("HC1:", ""));
          scanres = gzip.decode(scanres.toList());
          var cose = Cose.decodeAndVerify(scanres, certMap);
          HapticFeedback.lightImpact();
          setState(() {
            coseResult = cose;
            result = scanData;
            processedResult = Result.fromDGC(cose.payload);
          });
        } catch (e) {
          HapticFeedback.lightImpact();
          setState(() {
            coseResult = CoseResult(
                payload: {},
                verified: false,
                errorCode: CoseErrorCode.invalid_format,
                certificate: null);
            result = scanData;
          });
        }
      }
    });
  }

  void dismissResults() {
    setState(() {
      coseResult = null;
      result = null;
      processedResult = null;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
