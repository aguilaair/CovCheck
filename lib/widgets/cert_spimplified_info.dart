import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/material.dart';

class CertInfoViewer extends StatelessWidget {
  CertInfoViewer({
    required this.coseResult,
    Key? key,
  }) : super(key: key);
  CoseResult? coseResult;

  @override
  Widget build(BuildContext context) {
    print(coseResult!.payload);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "First Name",
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                coseResult!.payload[-260][1]["nam"]["gn"] ??
                    coseResult!.payload[-260][1]["nam"]["gnt"],
                //style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Last Name",
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                coseResult!.payload[-260][1]["nam"]["fn"],
                //style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Date of Birth",
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(coseResult!.payload[-260][1]["dob"]
                  //style: Theme.of(context).textTheme.headline6,
                  )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Age",
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                "${yearsOld(coseResult!.payload[-260][1]["dob"]).toString()} Years",
                //style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Country",
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                coseResult!.payload[1],
                //style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Signing Authority",
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              coseResult!.payload[-260][1]["v"][0]["is"],
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

int yearsOld(String time) {
  DateTime today = DateTime.now();

  // Parsed date to check
  DateTime? birthDate = DateTime.tryParse(time);

  if (birthDate == null) {
    return 0;
  }

  // Date to check but moved 18 years ahead
  DateTime adultDate = DateTime.now();

  return ((adultDate.difference(birthDate).inDays) / 365).floor();
}
