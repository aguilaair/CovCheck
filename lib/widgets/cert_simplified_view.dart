import 'package:covid_checker/widgets/result_card.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CertSimplifiedView extends StatelessWidget {
  CertSimplifiedView({
    required this.coseResult,
    required this.barcodeResult,
    required this.dismiss,
    Key? key,
  }) : super(key: key);

  CoseResult? coseResult;
  Barcode? barcodeResult;
  Function dismiss;

  @override
  Widget build(BuildContext context) {
    if (coseResult != null &&
        barcodeResult != null &&
        barcodeResult!.format == BarcodeFormat.qrcode) {
      // Verified
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const EmptyResult(),
          ResultCard(
            barcodeResult: barcodeResult!,
            coseResult: coseResult!,
            dismiss: dismiss,
          ),
        ],
      );
    }
    // No Result
    return const EmptyResult();
  }
}

class EmptyResult extends StatelessWidget {
  const EmptyResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.qr_code_rounded,
            size: 70,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Scan a QR Code",
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
