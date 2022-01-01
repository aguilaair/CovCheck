import 'package:circle_flags/circle_flags.dart';
import 'package:covid_checker/generated/l10n.dart';
import 'package:covid_checker/models/result.dart';
import 'package:covid_checker/utils/years_old.dart';
import 'package:covid_checker/widgets/moreDetails/cert_detailed_view.dart';
import 'package:covid_checker/widgets/molecules/detail.dart';
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
            height: 5,
          ),
          if (processedResult.vaccination != null)
            Detail(
              title: S.of(context).vacdoses,
              detail:
                  "${processedResult.vaccination?.dosesGiven ?? S.of(context).unk} / ${processedResult.vaccination?.dosesRequired ?? S.of(context).unk}",
              trialing: CircleAvatar(
                //radius: 40,
                backgroundColor:
                    (processedResult.vaccination?.complete ?? false)
                        ? Colors.green
                        : Theme.of(context).errorColor,
                child: Icon(
                  (processedResult.vaccination?.complete ?? false)
                      ? Icons.check_circle_outline_rounded
                      : Icons.warning_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          if (processedResult.test != null)
            Detail(
              title: S.of(context).certres,
              detail: processedResult.test!.testResultProcessed,
              trialing: CircleAvatar(
                //radius: 40,
                backgroundColor: (processedResult.test!.passed ?? false)
                    ? Colors.green
                    : Theme.of(context).errorColor,
                child: Icon(
                  (processedResult.test!.passed ?? false)
                      ? Icons.check_circle_outline_rounded
                      : Icons.warning_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          if (processedResult.recovery != null)
            Detail(
              title: S.of(context).recovstate,
              detail: processedResult.recovery!.valid
                  ? S.of(context).valid
                  : S.of(context).invalid,
              trialing: CircleAvatar(
                //radius: 40,
                backgroundColor: (processedResult.recovery!.valid)
                    ? Colors.green
                    : Theme.of(context).errorColor,
                child: Icon(
                  (processedResult.recovery!.valid)
                      ? Icons.check_circle_outline_rounded
                      : Icons.warning_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
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
