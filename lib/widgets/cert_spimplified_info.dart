import 'package:covid_checker/widgets/cert_detailed_view.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/material.dart';

class CertInfoViewer extends StatelessWidget {
  const CertInfoViewer({
    required this.coseResult,
    Key? key,
  }) : super(key: key);
  final CoseResult? coseResult;

  @override
  Widget build(BuildContext context) {
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
                (coseResult!.payload[-260][1]["nam"]["gn"] ??
                        coseResult!.payload[-260][1]["nam"]["gnt"]) ??
                    "Not Found",
                //style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          const SizedBox(
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
                coseResult!.payload[-260][1]["nam"]["fn"] ?? "Not Found",
                //style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          const SizedBox(
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
              Text(coseResult!.payload[-260][1]["dob"] ?? "Not Found"
                  //style: Theme.of(context).textTheme.headline6,
                  )
            ],
          ),
          const SizedBox(
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
                "${yearsOld(coseResult!.payload[-260][1]["dob"]) ?? "Unknown"} Years",
                //style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          const SizedBox(
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
                coseResult!.payload[1] ?? "Unknown",
                //style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Type of Certificate",
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                certType(coseResult!),
                //style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Signing Authority",
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              (coseResult!.payload[-260][1] as Map<dynamic, dynamic>)
                      .values
                      .first[0]["is"] ??
                  "Unknown",
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          Center(
            child: OutlinedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return CertDetailedView(coseResult: coseResult!);
                    },
                  );
                },
                icon: const Icon(Icons.info_outline_rounded),
                label: const Text("More Details")),
          )
        ],
      ),
    );
  }
}

int? yearsOld(String time) {
  // Parsed date to check
  DateTime? birthDate = DateTime.tryParse(time);

  if (birthDate == null) {
    return null;
  }

  // Date to check but moved 18 years ahead
  DateTime adultDate = DateTime.now();

  return ((adultDate.difference(birthDate).inDays) / 365).floor();
}

String certType(CoseResult res) {
  var type = (res.payload[-260][1] as Map<dynamic, dynamic>).keys.first;
  if (type == "v") {
    return "Vaccination";
  } else if (type == "r") {
    return "Recovered";
  } else if (type == "t") {
    return "Test";
  }
  return "Unknown";
}
