import 'package:covid_checker/utils/certs.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/material.dart';

class CertDetailedView extends StatelessWidget {
  const CertDetailedView({required this.coseResult, Key? key})
      : super(key: key);

  final CoseResult coseResult;

  @override
  Widget build(BuildContext context) {
    final res = coseResult.payload[-260][1] as Map<dynamic, dynamic>;

    List<Widget> detailedInfo = [];

    final personalDataInfo = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "First Name",
            style: Theme.of(context).textTheme.headline6,
          ),
          Expanded(
            child: Text(
              res["nam"]["gn"] ?? "Not Found",
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
            "Last Name",
            style: Theme.of(context).textTheme.headline6,
          ),
          Expanded(
            child: Text(
              res["nam"]["fn"] ?? "Not Found",
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
            "Date of Birth",
            style: Theme.of(context).textTheme.headline6,
          ),
          Expanded(
            child: Text(
              res["dob"] ?? "Not Found",
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
            "Age",
            style: Theme.of(context).textTheme.headline6,
          ),
          Expanded(
            child: Text(
              "${yearsOld(res["dob"]) ?? "Unknown"} Years",
              maxLines: 3,
              textAlign: TextAlign.end,
            ),
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
          Expanded(
            child: Text(
              coseResult.payload[1] ?? "Unknown",
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

    if (certType(coseResult) == "Vaccination") {
      detailedInfo = [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Manufacturer Name",
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                vaccinationManf((res).values.first[0]["ma"]),
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
              "Targeted Disease",
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
              "Vaccine or Prohylaxis",
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                vaccineProh((res).values.first[0]["vp"]),
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
              "Product name",
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                vaccineProdName((res).values.first[0]["mp"]),
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
              "Doses",
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                "${(res).values.first[0]["dn"] ?? "Unknown"} / ${(res).values.first[0]["sd"] ?? "Unknown"}",
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
              "Date of Vaccination",
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                (res).values.first[0]["dt"] ?? "Unknown",
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
              "Administartion Contry",
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                (res).values.first[0]["co"] ?? "Unknown",
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
    } else if (certType(coseResult) == "Test") {
      detailedInfo = [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Manufacturer Name",
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
              "Targeted Disease",
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
              "Test Type",
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
              "Test Result",
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
              "Date of Collection",
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
              "Testing Centre",
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                (res).values.first[0]["dt"] ?? "Unknown",
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
              "Administartion Contry",
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                (res).values.first[0]["co"] ?? "Unknown",
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
            "Certificate ID",
            style: Theme.of(context).textTheme.headline6,
          ),
          Expanded(
            child: Text(
              (res).values.first[0]["ci"] ?? "Unknown",
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
            "Certificate Version",
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
        "Signing Authority",
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.left,
      ),
      const SizedBox(
        height: 5,
      ),
      Center(
        child: Text(
          (res).values.first[0]["is"] ?? "Unknown",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Type of Certificate",
                style: Theme.of(context).textTheme.headline6,
              ),
              Expanded(
                child: Text(
                  certType(coseResult),
                  maxLines: 3,
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          ...certInfo,
          const Divider(),
          Text(
            "Raw Data",
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
    return "Vaccination";
  } else if (type == "r") {
    return "Recovered";
  } else if (type == "t") {
    return "Test";
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
