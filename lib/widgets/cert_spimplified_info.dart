import 'package:covid_checker/generated/l10n.dart';
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
                S.of(context).name,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                (coseResult!.payload[-260][1]["nam"]["gn"] ??
                        coseResult!.payload[-260][1]["nam"]["gnt"]) ??
                    S.of(context).unk,
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
                S.of(context).surname,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                coseResult!.payload[-260][1]["nam"]["fn"] ?? S.of(context).unk,
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
                S.of(context).dob,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(coseResult!.payload[-260][1]["dob"] ?? S.of(context).unk
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
                S.of(context).age,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                S.of(context).xageold(
                    (yearsOld(coseResult!.payload[-260][1]["dob"])) ??
                        S.of(context).unk),
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
                S.of(context).country,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                coseResult!.payload[1] ?? S.of(context).unk,
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
                S.of(context).certType,
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
            S.of(context).signingauth,
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
                  S.of(context).unk,
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
                label: Text(S.of(context).moredetails)),
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
    return S.current.vaccination;
  } else if (type == "r") {
    return S.current.recovered;
  } else if (type == "t") {
    return S.current.test;
  }
  return type;
}
