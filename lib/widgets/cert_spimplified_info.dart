import 'package:circle_flags/circle_flags.dart';
import 'package:covid_checker/generated/l10n.dart';
import 'package:covid_checker/models/result.dart';
import 'package:covid_checker/widgets/cert_detailed_view.dart';
import 'package:covid_checker/widgets/detail.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CertInfoViewer extends StatelessWidget {
  const CertInfoViewer({
    required this.coseResult,
    required this.processedResult,
    Key? key,
  }) : super(key: key);
  final CoseResult? coseResult;
  final Result processedResult;

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
            detail: processedResult.nam?.forename,
          ),
          const SizedBox(
            height: 5,
          ),
          Detail(
            title: S.of(context).surname,
            detail: processedResult.nam?.surname,
          ),
          const SizedBox(
            height: 5,
          ),
          Detail(
            title: S.of(context).dob,
            detail: DateFormat.yMd(Localizations.localeOf(context).countryCode)
                .format(processedResult.dob!),
          ),
          const SizedBox(
            height: 5,
          ),
          Detail(
            title: S.of(context).age,
            detail: S
                .of(context)
                .xageold((yearsOld(processedResult.dob)) ?? S.of(context).unk),
          ),
          const SizedBox(
            height: 10,
          ),
          Detail(
            title: S.of(context).country,
            detail: processedResult.country,
            trialing: processedResult.country == null
                ? null
                : CircleFlag(processedResult.country!),
          ),
          const SizedBox(
            height: 5,
          ),
          Detail(
            title: S.of(context).certType,
            detail: certType(processedResult),
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
              processedResult.vaccination?.issuer ??
                  processedResult.test?.issuer ??
                  processedResult.recovery?.issuer ??
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
                      return CertDetailedView(
                        processedResult: processedResult,
                      );
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

int? yearsOld(DateTime? birthDate) {
  // Parsed date to check

  if (birthDate == null) {
    return null;
  }

  // Date to check but moved 18 years ahead
  DateTime adultDate = DateTime.now();

  return ((adultDate.difference(birthDate).inDays) / 365).floor();
}
