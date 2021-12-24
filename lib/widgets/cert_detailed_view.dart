import 'package:covid_checker/generated/l10n.dart';
import 'package:covid_checker/models/result.dart';
import 'package:covid_checker/utils/years_old.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'detail.dart';

class CertDetailedView extends StatelessWidget {
  const CertDetailedView({
    required this.processedResult,
    Key? key,
  }) : super(key: key);

  final Result processedResult;

  @override
  Widget build(BuildContext context) {
    List<Widget> detailedInfo = [];

    final personalDataInfo = [
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
        height: 5,
      ),
      Detail(
        title: S.of(context).country,
        detail: processedResult.country,
      ),
      const SizedBox(
        height: 10,
      ),
    ];

    if (processedResult.vaccination != null) {
      detailedInfo = [
        Detail(
          title: S.of(context).manname,
          detail: processedResult.vaccination?.marketingHolderProcessed ??
              processedResult.vaccination?.marketingHolder,
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).targetdisease,
          detail: processedResult.vaccination?.targetDiseaseProcessed,
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).vaccproph,
          detail: processedResult.vaccination?.vaccineOrProphylaxisProcessed,
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).prodName,
          detail: processedResult.vaccination?.medicinalProductProcessed,
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).vacdoses,
          detail:
              "${processedResult.vaccination?.dosesGiven ?? S.of(context).unk} / ${processedResult.vaccination?.dosesRequired ?? S.of(context).unk}",
          trialing: CircleAvatar(
            //radius: 40,
            backgroundColor: (processedResult.vaccination?.complete ?? false)
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
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).vacdate,
          detail: processedResult.vaccination!.dateOfVaccination != null
              ? DateFormat.yMd(Localizations.localeOf(context).countryCode)
                  .format(processedResult.vaccination!.dateOfVaccination!)
              : null,
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).country,
          detail: processedResult.vaccination?.country,
        ),
        const SizedBox(
          height: 5,
        ),
      ];
    } else if (processedResult.test != null) {
      detailedInfo = [
        Detail(
          title: S.of(context).manname,
          detail: processedResult.test!.testName ??
              processedResult.test!.testDeviceIDProcessed,
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).targetdisease,
          detail: processedResult.test!.targetDiseaseProcessed,
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).testtype,
          detail: processedResult.test!.testTypeProcessed,
        ),
        const SizedBox(
          height: 5,
        ),
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
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).testdate,
          detail: processedResult.test!.dateOfSampleCollection != null
              ? DateFormat.yMd(Localizations.localeOf(context).countryCode)
                  .add_Hm()
                  .format(processedResult.test!.dateOfSampleCollection!)
              : null,
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).testloc,
          detail: processedResult.test!.testFacility,
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).country,
          detail: processedResult.test!.country,
        ),
        const SizedBox(
          height: 5,
        ),
      ];
    }

    final certInfo = [
      Detail(
        title: S.of(context).certid,
        detail: processedResult.vaccination?.certId ??
            processedResult.test?.certId ??
            processedResult.recovery?.certId,
      ),
      const SizedBox(
        height: 5,
      ),
      Detail(
        title: S.of(context).certver,
        detail: processedResult.ver,
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
          (processedResult.vaccination?.issuer ??
              processedResult.test?.issuer ??
              processedResult.recovery?.issuer ??
              S.of(context).unk),
          textAlign: TextAlign.center,
        ),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Theme.of(context).cardColor,
      ),
      padding: const EdgeInsets.all(8.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ExpansionTile(
              title: Text(
                S.of(context).personaldetails,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              childrenPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              children: personalDataInfo,
            ),
            //...,
            ExpansionTile(
              title: Text(
                S.of(context).detialtype(certType(processedResult)),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              childrenPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              children: detailedInfo,
            ),
            ExpansionTile(
              title: Text(
                S.of(context).certinfo,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              childrenPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              children: [
                Detail(
                  title: S.of(context).certType,
                  detail: certType(processedResult),
                ),
                const SizedBox(
                  height: 5,
                ),
                ...certInfo,
              ],
            ),
            ExpansionTile(
              title: Text(
                S.of(context).rawData,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              childrenPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              children: [
                Container(
                  child:
                      SelectableText(processedResult.raw ?? S.of(context).unk),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).backgroundColor,
                    border: Border.all(
                        color: Colors.blueAccent.withAlpha(200), width: 1.5),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

String certType(Result res) {
  if (res.vaccination != null) {
    return S.current.vaccination;
  } else if (res.recovery != null) {
    return S.current.recovered;
  } else if (res.test != null) {
    return S.current.test;
  }
  return S.current.unk;
}
