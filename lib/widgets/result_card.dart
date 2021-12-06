import 'package:covid_checker/widgets/cert_spimplified_info.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    required this.barcodeResult,
    required this.coseResult,
    required this.dismiss,
    Key? key,
  }) : super(key: key);

  final CoseResult coseResult;
  final Barcode barcodeResult;
  final Function dismiss;

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
              ),
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    coseResult.verified
                        ? "Valid Certificate"
                        : "Invalid Certificate",
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
                child: CertInfoViewer(coseResult: coseResult),
              ),
            )
          ],
        ),
        margin: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 15,
              spreadRadius: -3,
            )
          ],
          color: Colors.white,
        ),
      ),
    );
  }
}

String beautifyCose(CoseErrorCode error) {
  if (error == CoseErrorCode.cbor_decoding_error) {
    return "Data read error";
  } else if (error == CoseErrorCode.invalid_format ||
      error == CoseErrorCode.payload_format_error ||
      error == CoseErrorCode.unsupported_format) {
    return "Invaild Format";
  } else if (error == CoseErrorCode.invalid_header_format ||
      error == CoseErrorCode.unsupported_header_format) {
    return "Invaild Header Format";
  } else if (error == CoseErrorCode.key_not_found) {
    return "Key Not Found, certificate may still be valid";
  } else if (error == CoseErrorCode.kid_mismatch) {
    return "Signing mismatch, certificate may still be valid";
  } else if (error == CoseErrorCode.payload_format_error) {
    return "Data format error";
  } else if (error == CoseErrorCode.unsupported_algorithm) {
    return "Unsopported Algorithm";
  }
  return "Unknown Error";
}
