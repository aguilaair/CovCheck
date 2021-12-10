import 'dart:convert';

class Nam {
  String? surname;
  String? stdSurname;
  String? forename;
  String? stdForename;
  DateTime? dob;

  Nam({
    this.surname,
    this.stdSurname,
    this.forename,
    this.stdForename,
    this.dob,
  });

  Nam copyWith({
    String? surname,
    String? stdSurname,
    String? forename,
    String? stdForename,
    DateTime? dob,
  }) {
    return Nam(
      surname: surname ?? this.surname,
      stdSurname: stdSurname ?? this.stdSurname,
      forename: forename ?? this.forename,
      stdForename: stdForename ?? this.stdForename,
      dob: dob ?? this.dob,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'surname': surname,
      'stdSurname': stdSurname,
      'forename': forename,
      'stdForename': stdForename,
      'dob': dob?.toIso8601String(),
    };
  }

  factory Nam.fromMap(Map<String, dynamic> map) {
    return Nam(
      surname: map['fn'],
      stdSurname: map['fnt'],
      forename: map['gn'],
      stdForename: map['gnt'],
      dob: DateTime.tryParse(map['dob']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Nam.fromJson(String source) => Nam.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Nam(surname: $surname, stdSurname: $stdSurname, forename: $forename, stdForename: $stdForename, dob: $dob)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Nam &&
        other.surname == surname &&
        other.stdSurname == stdSurname &&
        other.forename == forename &&
        other.stdForename == stdForename &&
        other.dob == dob;
  }

  @override
  int get hashCode {
    return surname.hashCode ^
        stdSurname.hashCode ^
        forename.hashCode ^
        stdForename.hashCode ^
        dob.hashCode;
  }
}
