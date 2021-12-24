import 'package:covid_checker/certs/certs.dart';
import 'package:covid_checker/certs/test_manufacturer_name.dart';
import 'package:covid_checker/certs/test_results.dart';
import 'package:covid_checker/certs/test_types.dart';
import 'package:covid_checker/certs/vaccine_manufacturer_name.dart';
import 'package:covid_checker/certs/vaccine_product_name.dart';
import 'package:covid_checker/certs/vaccine_prophylaxis.dart';

String? vaccinationManf(String? code) {
  try {
    return (vaccineManfName["valueSetValues"] as Map)[code]["display"];
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
    return (vaccineMedicinalProduct["valueSetValues"] as Map)[code]["display"];
  } catch (e) {
    return code;
  }
}

String? testManf(String? code) {
  try {
    return (testManfName["valueSetValues"] as Map)[code]["display"];
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
