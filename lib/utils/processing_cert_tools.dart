import 'package:covid_checker/certs/disease_agent_targeted.dart';
import 'package:covid_checker/certs/test_manufacturer_name.dart';
import 'package:covid_checker/certs/test_results.dart';
import 'package:covid_checker/certs/test_types.dart';
import 'package:covid_checker/certs/vaccine_prophylaxis.dart';
import 'package:hive/hive.dart';

String? vaccinationManf(String? code) {
  try {
    return (Hive.box("certs")
            .get("vaccines-covid-19-auth-holders")["valueSetValues"]
        as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String? targetDisease(String? code) {
  try {
    return (diseaseAgentTargeted["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String? vaccineProh(String? code) {
  try {
    return (vaccineProphilaxis["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String? vaccineProdName(String? code) {
  try {
    return (Hive.box("certs").get("vaccine-medicinal-product")["valueSetValues"]
        as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String? testManf(String? code) {
  try {
    return Hive.box("certs").get("tests")[code]["display"];
  } catch (e) {
    return code;
  }
}

String? testType(String? code) {
  try {
    return (testTypes["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String? testName(String? code) {
  try {
    return (testManfName["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String? testResult(String? code) {
  try {
    return (testResults["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}
