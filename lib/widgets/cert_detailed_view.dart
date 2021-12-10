import 'package:covid_checker/generated/l10n.dart';
import 'package:covid_checker/utils/certs.dart';
import 'package:covid_checker/utils/processingCertTootls.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/material.dart';

import 'detail.dart';

class CertDetailedView extends StatelessWidget {
  const CertDetailedView({required this.coseResult, Key? key})
      : super(key: key);

  final CoseResult coseResult;

  @override
  Widget build(BuildContext context) {
    final res = coseResult.payload[-260][1] as Map<dynamic, dynamic>;

    List<Widget> detailedInfo = [];

    final personalDataInfo = [
      Detail(
        title: S.of(context).name,
        detail: res["nam"]["gn"],
      ),
      const SizedBox(
        height: 5,
      ),
      Detail(
        title: S.of(context).surname,
        detail: res["nam"]["fn"],
      ),
      const SizedBox(
        height: 5,
      ),
      Detail(
        title: S.of(context).dob,
        detail: res["dob"],
      ),
      const SizedBox(
        height: 5,
      ),
      Detail(
        title: S.of(context).age,
        detail: S.of(context).xageold(
            (yearsOld(coseResult.payload[-260][1]["dob"])) ??
                S.of(context).unk),
      ),
      const SizedBox(
        height: 5,
      ),
      Detail(
        title: S.of(context).country,
        detail: coseResult.payload[1],
      ),
      const SizedBox(
        height: 10,
      ),
    ];

    if (certType(coseResult) == S.current.vaccination) {
      detailedInfo = [
        Detail(
          title: S.of(context).manname,
          detail: vaccinationManf((res).values.first[0]["ma"]),
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).targetdisease,
          detail: targetDisease((res).values.first[0]["tg"]),
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).vaccproph,
          detail: vaccineProh((res).values.first[0]["vp"]),
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).prodName,
          detail: vaccineProdName((res).values.first[0]["mp"]),
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).vacdoses,
          detail:
              "${(res).values.first[0]["dn"] ?? S.of(context).unk} / ${(res).values.first[0]["sd"] ?? S.of(context).unk}",
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).vacdate,
          detail: (res).values.first[0]["dt"],
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).country,
          detail: (res).values.first[0]["co"],
        ),
        const SizedBox(
          height: 5,
        ),
      ];
    } else if (certType(coseResult) == S.current.test) {
      detailedInfo = [
        Detail(
          title: S.of(context).manname,
          detail: (res).values.first[0]["nm"],
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).targetdisease,
          detail: targetDisease((res).values.first[0]["tg"]),
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).testtype,
          detail: testType((res).values.first[0]["tt"]),
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).certres,
          detail: testResult((res).values.first[0]["tr"]),
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).testdate,
          detail: DateTime.tryParse((res).values.first[0]["sc"])!
              .toLocal()
              .toString(),
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).testloc,
          detail: (res).values.first[0]["dt"],
        ),
        const SizedBox(
          height: 5,
        ),
        Detail(
          title: S.of(context).country,
          detail: (res).values.first[0]["co"],
        ),
        const SizedBox(
          height: 5,
        ),
      ];
    }

    final certInfo = [
      Detail(
        title: S.of(context).certid,
        detail: (res).values.first[0]["ci"],
      ),
      const SizedBox(
        height: 5,
      ),
      Detail(
        title: S.of(context).certver,
        detail: res["ver"],
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
          (res).values.first[0]["is"] ?? S.of(context).unk,
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
                S.of(context).detialtype(certType(coseResult)),
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
                  detail: certType(coseResult),
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
                  child: SelectableText(coseResult.payload.toString()),
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