import 'package:covid_checker/generated/l10n.dart';
import 'package:covid_checker/widgets/cert_detailed_view.dart';
import 'package:covid_checker/widgets/detail.dart';
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
          Detail(
            title: S.of(context).name,
            detail: (coseResult!.payload[-260][1]["nam"]["gn"] ??
                    coseResult!.payload[-260][1]["nam"]["gnt"]) ??
                S.of(context).unk,
          ),
          const SizedBox(
            height: 5,
          ),
          Detail(
            title: S.of(context).surname,
            detail: coseResult!.payload[-260][1]["nam"]["fn"],
          ),
          const SizedBox(
            height: 5,
          ),
          Detail(
            title: S.of(context).dob,
            detail: coseResult!.payload[-260][1]["dob"],
          ),
          const SizedBox(
            height: 5,
          ),
          Detail(
            title: S.of(context).age,
            detail: S.of(context).xageold(
                (yearsOld(coseResult!.payload[-260][1]["dob"])) ??
                    S.of(context).unk),
          ),
          const SizedBox(
            height: 10,
          ),
          Detail(
            title: S.of(context).country,
            detail: coseResult!.payload[1],
          ),
          const SizedBox(
            height: 5,
          ),
          Detail(
            title: S.of(context).certType,
            detail: certType(coseResult!),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    context: context,
                    barrierColor:
                        Theme.of(context).brightness == Brightness.light
                            ? null
                            : Colors.white30,
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
