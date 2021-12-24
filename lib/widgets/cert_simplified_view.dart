import 'package:covid_checker/generated/l10n.dart';
import 'package:covid_checker/models/result.dart';
import 'package:covid_checker/widgets/result_card.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CertSimplifiedView extends StatelessWidget {
  const CertSimplifiedView({
    required this.coseResult,
    required this.barcodeResult,
    required this.dismiss,
    required this.processedResult,
    Key? key,
  }) : super(key: key);

  final CoseResult? coseResult;
  final Barcode? barcodeResult;
  final Function dismiss;
  final Result? processedResult;

  @override
  Widget build(BuildContext context) {
    if (coseResult != null &&
        barcodeResult != null &&
        //processedResult != null &&
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
            processedResult: processedResult,
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
            S.of(context).scanqrmessage,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
