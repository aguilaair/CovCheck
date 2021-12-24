import 'package:covid_checker/generated/l10n.dart';
import 'package:covid_checker/models/result.dart';
import 'package:covid_checker/utils/beautify_cose.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/material.dart';

class OverallResult extends StatelessWidget {
  const OverallResult({
    required this.coseResult,
    required this.processedResult,
    Key? key,
  }) : super(key: key);

  final CoseResult coseResult;
  final Result? processedResult;

  @override
  Widget build(BuildContext context) {
    final bgColor = getColor(coseResult, processedResult);
    bool validCert = ((processedResult?.vaccination?.complete ?? false) ||
        (processedResult?.recovery?.valid ?? false) ||
        (processedResult?.test?.passed ?? false));
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: bgColor,
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
          if (coseResult.verified && !validCert)
            Text(
              getErrorfromRes(processedResult!),
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                    //fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
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
    );
  }
}

Color getColor(CoseResult result, Result? processedResult) {
  if (result.verified &&
      ((processedResult?.vaccination?.complete ?? false) ||
          (processedResult?.recovery?.valid ?? false) ||
          (processedResult?.test?.passed ?? false))) {
    // Valid Cert and state
    return const Color(0xff1BCA4C);
  } else if (result.verified &&
      !((processedResult?.vaccination?.complete ?? false) ||
          (processedResult?.recovery?.valid ?? false) ||
          (processedResult?.test?.passed ?? false))) {
    return const Color(0xfffcbe03);
  }
  return const Color(0xffCA451B);
}

String getErrorfromRes(Result processedResult) {
  if (processedResult.vaccination != null &&
      !processedResult.vaccination!.complete!) {
    return S.current.nopassvac;
  } else if (processedResult.test != null && !processedResult.test!.passed!) {
    return S.current.nopasstest;
  } else if (processedResult.recovery != null &&
      !processedResult.recovery!.valid) {
    return S.current.nopassrecov;
  }
  return S.current.unk;
}
