import 'package:covid_checker/models/result.dart';
import 'package:covid_checker/widgets/certOverview/cert_spimplified_info.dart';
import 'package:covid_checker/widgets/molecules/overall_cer_result.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    required this.barcodeResult,
    required this.coseResult,
    required this.dismiss,
    required this.processedResult,
    Key? key,
  }) : super(key: key);

  final CoseResult coseResult;
  final Barcode barcodeResult;
  final Function dismiss;
  final Result? processedResult;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          const BoxConstraints(maxHeight: 800, maxWidth: 800, minHeight: 300),
      child: WillPopScope(
        onWillPop: () async {
          dismiss();
          return false;
        },
        child: Dismissible(
          direction: DismissDirection.down,
          key: const Key("Dismissable"),
          onDismissed: (direction) {
            dismiss();
          },
          child: Container(
            //width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OverallResult(
                  coseResult: coseResult,
                  processedResult: processedResult,
                ),
                if (processedResult != null)
                  Expanded(
                    //height: 30,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: CertInfoViewer(
                        coseResult: coseResult,
                        processedResult: processedResult!,
                      ),
                    ),
                  )
              ],
            ),
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey
                      : const Color(0xff27226A),
                  blurRadius: 15,
                  spreadRadius: -3,
                )
              ],
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
      ),
    );
  }
}
