import 'dart:convert';

import 'package:covid_checker/utils/processing_cert_tools.dart' as processers;

class Recovery {
  String targetDisease;
  String? targetDiseaseProcessed;
  DateTime? firstPositiveNAATTest;
  DateTime? validFrom;
  DateTime? validUntil;
  bool valid;
  String country;
  String issuer;
  String certId;

  Recovery({
    required this.targetDisease,
    this.targetDiseaseProcessed,
    this.firstPositiveNAATTest,
    this.validFrom,
    this.validUntil,
    required this.valid,
    required this.country,
    required this.issuer,
    required this.certId,
  });

  Recovery? fromDGC(Map<dynamic, dynamic> map) {
    final Map<dynamic, dynamic> recovMap;

    try {
      recovMap = map[-260][1]["r"];
    } catch (e) {
      return null;
    }
    return Recovery(
        targetDisease: recovMap['tg'] ?? '',
        targetDiseaseProcessed: processers.targetDisease(recovMap['tg']),
        firstPositiveNAATTest: DateTime.tryParse(recovMap['fr']),
        validFrom: DateTime.tryParse(recovMap['df']),
        validUntil: DateTime.tryParse(recovMap['du']),
        country: recovMap['co'] ?? '',
        issuer: recovMap['is'] ?? '',
        certId: recovMap['ci'] ?? '',
        valid: (DateTime.tryParse(recovMap['df'])?.isAfter(DateTime.now()) ??
                false) &&
            (DateTime.tryParse(recovMap['df'])?.isBefore(DateTime.now()) ??
                false));
  }

  Recovery copyWith({
    String? targetDisease,
    String? targetDiseaseProcessed,
    DateTime? firstPositiveNAATTest,
    DateTime? validFrom,
    DateTime? validUntil,
    bool? valid,
    String? country,
    String? issuer,
    String? certId,
  }) {
    return Recovery(
      targetDisease: targetDisease ?? this.targetDisease,
      targetDiseaseProcessed:
          targetDiseaseProcessed ?? this.targetDiseaseProcessed,
      firstPositiveNAATTest:
          firstPositiveNAATTest ?? this.firstPositiveNAATTest,
      validFrom: validFrom ?? this.validFrom,
      validUntil: validUntil ?? this.validUntil,
      valid: valid ?? this.valid,
      country: country ?? this.country,
      issuer: issuer ?? this.issuer,
      certId: certId ?? this.certId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'targetDisease': targetDisease,
      'targetDiseaseProcessed': targetDiseaseProcessed,
      'firstPositiveNAATTest': firstPositiveNAATTest?.millisecondsSinceEpoch,
      'validFrom': validFrom?.millisecondsSinceEpoch,
      'validUntil': validUntil?.millisecondsSinceEpoch,
      'valid': valid,
      'country': country,
      'issuer': issuer,
      'certId': certId,
    };
  }

  factory Recovery.fromMap(Map<String, dynamic> map) {
    return Recovery(
      targetDisease: map['targetDisease'] ?? '',
      targetDiseaseProcessed: map['targetDiseaseProcessed'],
      firstPositiveNAATTest: map['firstPositiveNAATTest'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['firstPositiveNAATTest'])
          : null,
      validFrom: map['validFrom'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['validFrom'])
          : null,
      validUntil: map['validUntil'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['validUntil'])
          : null,
      valid: map['valid'] ?? false,
      country: map['country'] ?? '',
      issuer: map['issuer'] ?? '',
      certId: map['certId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Recovery.fromJson(String source) =>
      Recovery.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Recovery(targetDisease: $targetDisease, targetDiseaseProcessed: $targetDiseaseProcessed, firstPositiveNAATTest: $firstPositiveNAATTest, validFrom: $validFrom, validUntil: $validUntil, valid: $valid, country: $country, issuer: $issuer, certId: $certId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Recovery &&
        other.targetDisease == targetDisease &&
        other.targetDiseaseProcessed == targetDiseaseProcessed &&
        other.firstPositiveNAATTest == firstPositiveNAATTest &&
        other.validFrom == validFrom &&
        other.validUntil == validUntil &&
        other.valid == valid &&
        other.country == country &&
        other.issuer == issuer &&
        other.certId == certId;
  }

  @override
  int get hashCode {
    return targetDisease.hashCode ^
        targetDiseaseProcessed.hashCode ^
        firstPositiveNAATTest.hashCode ^
        validFrom.hashCode ^
        validUntil.hashCode ^
        valid.hashCode ^
        country.hashCode ^
        issuer.hashCode ^
        certId.hashCode;
  }
}
