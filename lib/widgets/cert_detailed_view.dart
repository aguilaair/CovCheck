import 'package:covid_checker/generated/l10n.dart';
import 'package:covid_checker/utils/certs.dart';
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
        detail: res["nam"]["gn"],
      ),
      Detail(
        title: S.of(context).age,
        detail: S.of(context).xageold(
            (yearsOld(coseResult.payload[-260][1]["dob"])) ??
                S.of(context).unk),
      ),
      const SizedBox(
        height: 10,
      ),
      Detail(
        title: S.of(context).country,
        detail: coseResult.payload[1],
      ),
      const SizedBox(
        height: 5,
      ),
    ];

    if (certType(coseResult) == S.current.vaccination) {
      detailedInfo = [
        const Divider(),
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
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).manname,
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                (res).values.first[0]["nm"],
                maxLines: 3,
                textAlign: TextAlign.end,
              ),
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
              S.of(context).targetdisease,
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                targetDisease((res).values.first[0]["tg"]),
                maxLines: 3,
                textAlign: TextAlign.end,
              ),
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
              S.of(context).testtype,
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                testType((res).values.first[0]["tt"]),
                maxLines: 3,
                textAlign: TextAlign.end,
              ),
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
              S.of(context).certres,
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                testResult((res).values.first[0]["tr"]),
                maxLines: 3,
                textAlign: TextAlign.end,
              ),
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
              S.of(context).testdate,
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                DateTime.tryParse((res).values.first[0]["sc"])!
                    .toLocal()
                    .toString(),
                maxLines: 3,
                textAlign: TextAlign.end,
              ),
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
              S.of(context).testloc,
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                (res).values.first[0]["dt"] ?? S.of(context).unk,
                maxLines: 3,
                textAlign: TextAlign.end,
              ),
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
              S.of(context).country,
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                (res).values.first[0]["co"] ?? S.of(context).unk,
                maxLines: 3,
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
      ];
    }

    final certInfo = [
      const Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).certid,
            style: Theme.of(context).textTheme.headline6,
          ),
          Expanded(
            child: Text(
              (res).values.first[0]["ci"] ?? S.of(context).unk,
              maxLines: 3,
              textAlign: TextAlign.end,
            ),
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
            S.of(context).certver,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            res["ver"],
            maxLines: 3,
            textAlign: TextAlign.end,
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
          (res).values.first[0]["is"] ?? S.of(context).unk,
          textAlign: TextAlign.center,
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          ...personalDataInfo,
          ...detailedInfo,
          Detail(
            title: S.of(context).certType,
            detail: certType(coseResult),
          ),
          const SizedBox(
            height: 5,
          ),
          ...certInfo,
          const Divider(),
          Text(
            S.of(context).rawData,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(coseResult.payload.toString()),
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

String vaccinationManf(String code) {
  try {
    return (vaccineManfName["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String targetDisease(String code) {
  try {
    return (diseaseAgentTargeted["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String vaccineProh(String code) {
  try {
    return (vaccineProphilaxis["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String vaccineProdName(String code) {
  try {
    return (vaccineMedicinalProduct["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String testManf(String code) {
  try {
    return (testManfName["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String testType(String code) {
  try {
    return (testTypes["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String testName(String code) {
  try {
    return (testManfName["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String testResult(String code) {
  try {
    return (testResults["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}
