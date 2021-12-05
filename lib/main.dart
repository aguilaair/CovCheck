import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:cbor/cbor.dart';
import 'package:covid_checker/utils/base45.dart';
import 'package:covid_checker/utils/certs.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:typed_data/typed_buffers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final inst = Cbor();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                clipBehavior: Clip.antiAlias,
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: QRView(
                    key: qrKey,
                    overlay: QrScannerOverlayShape(
                        borderRadius: 15,
                        overlayColor: Colors.black.withAlpha(100)),
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result != null)
                    ? Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: $decodedResult')
                    : const Text('Scan a code'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null && scanData.code!.startsWith("HC1:")) {
        List<int> scanres;
        scanres = Base45.decode(scanData.code!.replaceAll("HC1:", ""));
        scanres = gzip.decode(scanres.toList());
        Map<String, String> certMap = {};
        (certs["dsc_trust_list"] as Map).forEach((key, value) {
          for (var element in (value["keys"] as List)) {
            certMap[element["kid"]] = element["x5c"][0];
          }
        });
        var cose = Cose.decodeAndVerify(scanres, certMap);
        setState(() {
          decodedResult = cose.payload.toString();
          result = scanData;
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
