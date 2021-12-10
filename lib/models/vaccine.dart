import 'dart:convert';

import 'package:covid_checker/utils/processingCertTootls.dart' as processers;

class Vaccination {
  String targetDisease;
  String? targetDiseaseProcessed;
  String vaccineOrProphylaxis;
  String? vaccineOrProphylaxisProcessed;
  String medicinalProduct;
  String? medicinalProductProcessed;
  String marketingHolder;
  String? marketingHolderProcessed;
  int dosesGiven;
  int dosesRequired;
  bool? complete;
  DateTime? dateOfVaccination;
  String country;
  String issuer;
  String certId;

  Vaccination({
    required this.targetDisease,
    this.targetDiseaseProcessed,
    required this.vaccineOrProphylaxis,
    this.vaccineOrProphylaxisProcessed,
    required this.medicinalProduct,
    this.medicinalProductProcessed,
    required this.marketingHolder,
    this.marketingHolderProcessed,
    required this.dosesGiven,
    required this.dosesRequired,
    this.complete,
    required this.dateOfVaccination,
    required this.country,
    required this.issuer,
    required this.certId,
  });

  Vaccination copyWith({
    String? targetDisease,
    String? targetDiseaseProcessed,
    String? vaccineOrProphylaxis,
    String? vaccineOrProphylaxisProcessed,
    String? medicinalProduct,
    String? medicinalProductProcessed,
    String? marketingHolder,
    String? marketingHolderProcessed,
    int? dosesGiven,
    int? dosesRequired,
    bool? complete,
    DateTime? dateOfVaccination,
    String? country,
    String? issuer,
    String? certId,
  }) {
    return Vaccination(
      targetDisease: targetDisease ?? this.targetDisease,
      targetDiseaseProcessed:
          targetDiseaseProcessed ?? this.targetDiseaseProcessed,
      vaccineOrProphylaxis: vaccineOrProphylaxis ?? this.vaccineOrProphylaxis,
      vaccineOrProphylaxisProcessed:
          vaccineOrProphylaxisProcessed ?? this.vaccineOrProphylaxisProcessed,
      medicinalProduct: medicinalProduct ?? this.medicinalProduct,
      medicinalProductProcessed:
          medicinalProductProcessed ?? this.medicinalProductProcessed,
      marketingHolder: marketingHolder ?? this.marketingHolder,
      marketingHolderProcessed:
          marketingHolderProcessed ?? this.marketingHolderProcessed,
      dosesGiven: dosesGiven ?? this.dosesGiven,
      dosesRequired: dosesRequired ?? this.dosesRequired,
      complete: complete ?? this.complete,
      dateOfVaccination: dateOfVaccination ?? this.dateOfVaccination,
      country: country ?? this.country,
      issuer: issuer ?? this.issuer,
      certId: certId ?? this.certId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'targetDisease': targetDisease,
      'targetDiseaseProcessed': targetDiseaseProcessed,
      'vaccineOrProphylaxis': vaccineOrProphylaxis,
      'vaccineOrProphylaxisProcessed': vaccineOrProphylaxisProcessed,
      'medicinalProduct': medicinalProduct,
      'medicinalProductProcessed': medicinalProductProcessed,
      'marketingHolder': marketingHolder,
      'marketingHolderProcessed': marketingHolderProcessed,
      'dosesGiven': dosesGiven,
      'dosesRequired': dosesRequired,
      'complete': complete,
      'dateOfVaccination': dateOfVaccination?.toIso8601String(),
      'country': country,
      'issuer': issuer,
      'certId': certId,
    };
  }

  factory Vaccination.fromMap(Map<String, dynamic> map) {
    return Vaccination(
      targetDisease: map['targetDisease'] ?? '',
      targetDiseaseProcessed: map['targetDiseaseProcessed'],
      vaccineOrProphylaxis: map['vaccineOrProphylaxis'] ?? '',
      vaccineOrProphylaxisProcessed: map['vaccineOrProphylaxisProcessed'],
      medicinalProduct: map['medicinalProduct'] ?? '',
      medicinalProductProcessed: map['medicinalProductProcessed'],
      marketingHolder: map['marketingHolder'] ?? '',
      marketingHolderProcessed: map['marketingHolderProcessed'],
      dosesGiven: map['dosesGiven']?.toInt() ?? 0,
      dosesRequired: map['dosesRequired']?.toInt() ?? 0,
      complete: map['complete'],
      dateOfVaccination: DateTime.tryParse(map['dateOfVaccination']),
      country: map['country'] ?? '',
      issuer: map['issuer'] ?? '',
      certId: map['certId'] ?? '',
    );
  }

  Vaccination? fromDGC(Map<dynamic, dynamic> map) {
    final Map<dynamic, dynamic> vaccineMap;

    try {
      vaccineMap = map[-260][1]["v"];
    } catch (e) {
      return null;
    }
    return Vaccination(
      targetDisease: vaccineMap['tg'] ?? '',
      targetDiseaseProcessed: processers.targetDisease(vaccineMap['tg']),
      vaccineOrProphylaxis: vaccineMap['vp'] ?? '',
      vaccineOrProphylaxisProcessed: processers.vaccineProh(vaccineMap['vp']),
      medicinalProduct: vaccineMap['mp'] ?? '',
      medicinalProductProcessed: processers.vaccineProdName(vaccineMap['mp']),
      marketingHolder: vaccineMap['marketingHolder'] ?? '',
      marketingHolderProcessed: processers.vaccinationManf(vaccineMap['mp']),
      dosesGiven: vaccineMap['dosesGiven']?.toInt() ?? 0,
      dosesRequired: vaccineMap['dosesRequired']?.toInt() ?? 0,
      complete:
          (vaccineMap['dn']?.toInt() ?? -1 >= vaccineMap['sd']?.toInt() ?? 0),
      dateOfVaccination: DateTime.tryParse(vaccineMap['dt']),
      country: vaccineMap['co'] ?? '',
      issuer: vaccineMap['is'] ?? '',
      certId: vaccineMap['ci'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Vaccination.fromJson(String source) =>
      Vaccination.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vaccination(targetDisease: $targetDisease, targetDiseaseProcessed: $targetDiseaseProcessed, vaccineOrProphylaxis: $vaccineOrProphylaxis, vaccineOrProphylaxisProcessed: $vaccineOrProphylaxisProcessed, medicinalProduct: $medicinalProduct, medicinalProductProcessed: $medicinalProductProcessed, marketingHolder: $marketingHolder, marketingHolderProcessed: $marketingHolderProcessed, dosesGiven: $dosesGiven, dosesRequired: $dosesRequired, complete: $complete, dateOfVaccination: $dateOfVaccination, country: $country, issuer: $issuer, certId: $certId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vaccination &&
        other.targetDisease == targetDisease &&
        other.targetDiseaseProcessed == targetDiseaseProcessed &&
        other.vaccineOrProphylaxis == vaccineOrProphylaxis &&
        other.vaccineOrProphylaxisProcessed == vaccineOrProphylaxisProcessed &&
        other.medicinalProduct == medicinalProduct &&
        other.medicinalProductProcessed == medicinalProductProcessed &&
        other.marketingHolder == marketingHolder &&
        other.marketingHolderProcessed == marketingHolderProcessed &&
        other.dosesGiven == dosesGiven &&
        other.dosesRequired == dosesRequired &&
        other.complete == complete &&
        other.dateOfVaccination == dateOfVaccination &&
        other.country == country &&
        other.issuer == issuer &&
        other.certId == certId;
  }

  @override
  int get hashCode {
    return targetDisease.hashCode ^
        targetDiseaseProcessed.hashCode ^
        vaccineOrProphylaxis.hashCode ^
        vaccineOrProphylaxisProcessed.hashCode ^
        medicinalProduct.hashCode ^
        medicinalProductProcessed.hashCode ^
        marketingHolder.hashCode ^
        marketingHolderProcessed.hashCode ^
        dosesGiven.hashCode ^
        dosesRequired.hashCode ^
        complete.hashCode ^
        dateOfVaccination.hashCode ^
        country.hashCode ^
        issuer.hashCode ^
        certId.hashCode;
  }
}
