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
    required this.toggleCamPda,
    required this.isPda,
    Key? key,
  }) : super(key: key);

  final CoseResult? coseResult;
  final Barcode? barcodeResult;
  final Function dismiss;
  final Result? processedResult;
  final bool isPda;
  final Function toggleCamPda;

  @override
  Widget build(BuildContext context) {
    if (coseResult != null &&
        barcodeResult != null &&
        //processedResult != null &&
        barcodeResult!.format == BarcodeFormat.qrcode) {
      // Verified
      return Expanded(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            EmptyResult(
              isPda: isPda,
              toggleCamPda: toggleCamPda,
            ),
            ResultCard(
              barcodeResult: barcodeResult!,
              coseResult: coseResult!,
              dismiss: dismiss,
              processedResult: processedResult,
            ),
          ],
        ),
      );
    }
    // No Result
    return EmptyResult(
      isPda: isPda,
      toggleCamPda: toggleCamPda,
    );
  }
}

class EmptyResult extends StatelessWidget {
  const EmptyResult({
    Key? key,
    required this.isPda,
    required this.toggleCamPda,
  }) : super(key: key);

  final bool isPda;
  final Function toggleCamPda;

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
          const SizedBox(
            height: 5,
          ),
          if (isPda)
            Text(
              S.of(context).pdadetected,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontWeight: FontWeight.w100),
            ),
          if (isPda)
            const SizedBox(
              height: 10,
            ),
          if (isPda)
            TextButton.icon(
              onPressed: () {
                toggleCamPda();
              },
              icon: const Icon(Icons.cameraswitch_sharp),
              label: Text(S.of(context).pdaswitch),
            )
        ],
      ),
    );
  }
}
