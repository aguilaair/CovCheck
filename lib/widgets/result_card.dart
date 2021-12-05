import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ResultCard extends StatelessWidget {
  ResultCard({
    required this.barcodeResult,
    required this.coseResult,
    required this.dismiss,
    Key? key,
  }) : super(key: key);

  CoseResult coseResult;
  Barcode barcodeResult;
  Function dismiss;

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
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: coseResult.verified
                    ? const Color(0xff1BCA4C)
                    : const Color(0xffCA451B),
              ),
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                coseResult.verified
                    ? "Valid Certificate"
                    : "Invalid Certificate",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
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
