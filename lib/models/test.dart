import 'dart:convert';

import 'package:covid_checker/utils/processing_cert_tools.dart' as processers;

class Test {
  String targetDisease;
  String? targetDiseaseProcessed;
  String testType;
  String? testTypeProcessed;
  String? testName; //nucleic acid amplification tests only
  String? testDeviceID; // rapid antigen tests only
  String? testDeviceIDProcessed; // rapid antigen tests only
  DateTime? dateOfSampleCollection;
  String testResult;
  String? testResultProcessed;
  String? testFacility; //RAT tests optional field, required for NAAT tests
  String country;
  String issuer;
  String certId;

  Test({
    required this.targetDisease,
    this.targetDiseaseProcessed,
    required this.testType,
    this.testTypeProcessed,
    this.testName,
    this.testDeviceID,
    this.testDeviceIDProcessed,
    required this.dateOfSampleCollection,
    required this.testResult,
    this.testResultProcessed,
    this.testFacility,
    required this.country,
    required this.issuer,
    required this.certId,
  });

  Test copyWith({
    String? targetDisease,
    String? targetDiseaseProcessed,
    String? testType,
    String? testTypeProcessed,
    String? testName,
    String? testDeviceID,
    String? testDeviceIDProcessed,
    DateTime? dateOfSampleCollection,
    String? testResult,
    String? testResultProcessed,
    String? testFacility,
    String? country,
    String? issuer,
    String? certId,
  }) {
    return Test(
      targetDisease: targetDisease ?? this.targetDisease,
      targetDiseaseProcessed:
          targetDiseaseProcessed ?? this.targetDiseaseProcessed,
      testType: testType ?? this.testType,
      testTypeProcessed: testTypeProcessed ?? this.testTypeProcessed,
      testName: testName ?? this.testName,
      testDeviceID: testDeviceID ?? this.testDeviceID,
      testDeviceIDProcessed:
          testDeviceIDProcessed ?? this.testDeviceIDProcessed,
      dateOfSampleCollection:
          dateOfSampleCollection ?? this.dateOfSampleCollection,
      testResult: testResult ?? this.testResult,
      testResultProcessed: testResultProcessed ?? this.testResultProcessed,
      testFacility: testFacility ?? this.testFacility,
      country: country ?? this.country,
      issuer: issuer ?? this.issuer,
      certId: certId ?? this.certId,
    );
  }

  Test? fromDGC(Map<dynamic, dynamic> map) {
    final Map<dynamic, dynamic> testMap;

    try {
      testMap = map[-260][1]["t"];
    } catch (e) {
      return null;
    }
    return Test(
      targetDisease: testMap['tg'] ?? '',
      targetDiseaseProcessed: processers.targetDisease(testMap['tg']),
      testType: testMap['tt'],
      testTypeProcessed: processers.testType(testMap['tt']),
      testName: testMap['nm'],
      testDeviceID: testMap['ma'],
      testDeviceIDProcessed: processers.testManf(testMap['ma']),
      dateOfSampleCollection: DateTime.tryParse(testMap['sc']),
      testResult: testMap['tr'],
      testResultProcessed: processers.testResult(testMap['tr']),
      testFacility: testMap['tc'],
      country: testMap['co'] ?? '',
      issuer: testMap['is'] ?? '',
      certId: testMap['ci'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'targetDisease': targetDisease,
      'targetDiseaseProcessed': targetDiseaseProcessed,
      'testType': testType,
      'testTypeProcessed': testTypeProcessed,
      'testName': testName,
      'testDeviceID': testDeviceID,
      'testDeviceIDProcessed': testDeviceIDProcessed,
      'dateOfSampleCollection': dateOfSampleCollection?.millisecondsSinceEpoch,
      'testResult': testResult,
      'testResultProcessed': testResultProcessed,
      'testFacility': testFacility,
      'country': country,
      'issuer': issuer,
      'certId': certId,
    };
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      targetDisease: map['targetDisease'] ?? '',
      targetDiseaseProcessed: map['targetDiseaseProcessed'],
      testType: map['testType'] ?? '',
      testTypeProcessed: map['testTypeProcessed'],
      testName: map['testName'],
      testDeviceID: map['testDeviceID'],
      testDeviceIDProcessed: map['testDeviceIDProcessed'],
      dateOfSampleCollection:
          DateTime.fromMillisecondsSinceEpoch(map['dateOfSampleCollection']),
      testResult: map['testResult'] ?? '',
      testResultProcessed: map['testResultProcessed'],
      testFacility: map['testFacility'],
      country: map['country'] ?? '',
      issuer: map['issuer'] ?? '',
      certId: map['certId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Test.fromJson(String source) => Test.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Test(targetDisease: $targetDisease, targetDiseaseProcessed: $targetDiseaseProcessed, testType: $testType, testTypeProcessed: $testTypeProcessed, testName: $testName, testDeviceID: $testDeviceID, testDeviceIDProcessed: $testDeviceIDProcessed, dateOfSampleCollection: $dateOfSampleCollection, testResult: $testResult, testResultProcessed: $testResultProcessed, testFacility: $testFacility, country: $country, issuer: $issuer, certId: $certId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Test &&
        other.targetDisease == targetDisease &&
        other.targetDiseaseProcessed == targetDiseaseProcessed &&
        other.testType == testType &&
        other.testTypeProcessed == testTypeProcessed &&
        other.testName == testName &&
        other.testDeviceID == testDeviceID &&
        other.testDeviceIDProcessed == testDeviceIDProcessed &&
        other.dateOfSampleCollection == dateOfSampleCollection &&
        other.testResult == testResult &&
        other.testResultProcessed == testResultProcessed &&
        other.testFacility == testFacility &&
        other.country == country &&
        other.issuer == issuer &&
        other.certId == certId;
  }

  @override
  int get hashCode {
    return targetDisease.hashCode ^
        targetDiseaseProcessed.hashCode ^
        testType.hashCode ^
        testTypeProcessed.hashCode ^
        testName.hashCode ^
        testDeviceID.hashCode ^
        testDeviceIDProcessed.hashCode ^
        dateOfSampleCollection.hashCode ^
        testResult.hashCode ^
        testResultProcessed.hashCode ^
        testFacility.hashCode ^
        country.hashCode ^
        issuer.hashCode ^
        certId.hashCode;
  }
}
