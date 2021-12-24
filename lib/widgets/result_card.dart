import 'package:covid_checker/generated/l10n.dart';
import 'package:covid_checker/models/result.dart';
import 'package:covid_checker/utils/beautify_cose.dart';
import 'package:covid_checker/widgets/cert_spimplified_info.dart';
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
  final Result processedResult;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.down,
      key: const Key("Dismissable"),
      onDismissed: (direction) {
        dismiss();
      },
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: coseResult.verified
                    ? const Color(0xff1BCA4C)
                    : const Color(0xffCA451B),
                boxShadow: [
                  BoxShadow(
                    color: coseResult.verified
                        ? const Color(0xff1BCA4C)
                        : const Color(0xffCA451B),
                    blurRadius: 10,
                    //spreadRadius: 0,
                  )
                ],
              ),
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    coseResult.verified
                        ? S.of(context).validcert
                        : S.of(context).invalidcert,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (!coseResult.verified)
                    Text(
                      beautifyCose(coseResult.errorCode),
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white,
                            //fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
            Expanded(
              //height: 30,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: CertInfoViewer(
                  coseResult: coseResult,
                  processedResult: processedResult,
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
    );
  }
}
