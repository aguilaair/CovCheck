import 'dart:convert';

import 'package:covid_checker/models/nam.dart';
import 'package:covid_checker/models/recovey.dart';
import 'package:covid_checker/models/test.dart';
import 'package:covid_checker/models/vaccine.dart';

class Result {
  String? ver;
  DateTime? dob;
  Nam? nam;
  Vaccination? vaccination;
  Test? test;
  Recovery? recovery;
  Result({
    this.ver,
    this.dob,
    this.nam,
    this.vaccination,
    this.test,
    this.recovery,
  });

  Result? fromDGC(Map<dynamic, dynamic> map) {
    return Result(
        recovery: Recovery.fromDGC(map),
        dob: DateTime.tryParse(map["dob"]),
        nam: Nam.fromDGC(map),
        test: Test.fromDGC(map),
        vaccination: Vaccination.fromDGC(map),
        ver: map["dob"]);
  }

  Result copyWith({
    String? ver,
    DateTime? dob,
    Nam? nam,
    Vaccination? vaccination,
    Test? test,
    Recovery? recovery,
  }) {
    return Result(
      ver: ver ?? this.ver,
      dob: dob ?? this.dob,
      nam: nam ?? this.nam,
      vaccination: vaccination ?? this.vaccination,
      test: test ?? this.test,
      recovery: recovery ?? this.recovery,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ver': ver,
      'dob': dob?.millisecondsSinceEpoch,
      'nam': nam?.toMap(),
      'vaccination': vaccination?.toMap(),
      'test': test?.toMap(),
      'recovery': recovery?.toMap(),
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      ver: map['ver'],
      dob: map['dob'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dob'])
          : null,
      nam: map['nam'] != null ? Nam.fromMap(map['nam']) : null,
      vaccination: map['vaccination'] != null
          ? Vaccination.fromMap(map['vaccination'])
          : null,
      test: map['test'] != null ? Test.fromMap(map['test']) : null,
      recovery:
          map['recovery'] != null ? Recovery.fromMap(map['recovery']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(ver: $ver, dob: $dob, nam: $nam, vaccination: $vaccination, test: $test, recovery: $recovery)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Result &&
        other.ver == ver &&
        other.dob == dob &&
        other.nam == nam &&
        other.vaccination == vaccination &&
        other.test == test &&
        other.recovery == recovery;
  }

  @override
  int get hashCode {
    return ver.hashCode ^
        dob.hashCode ^
        nam.hashCode ^
        vaccination.hashCode ^
        test.hashCode ^
        recovery.hashCode;
  }
}
