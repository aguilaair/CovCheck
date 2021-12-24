import 'dart:convert';

class Nam {
  String surname;
  String stdSurname;
  String forename;
  String stdForename;

  Nam({
    required this.surname,
    required this.stdSurname,
    required this.forename,
    required this.stdForename,
  });

  Nam copyWith({
    String? surname,
    String? stdSurname,
    String? forename,
    String? stdForename,
  }) {
    return Nam(
      surname: surname ?? this.surname,
      stdSurname: stdSurname ?? this.stdSurname,
      forename: forename ?? this.forename,
      stdForename: stdForename ?? this.stdForename,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'surname': surname,
      'stdSurname': stdSurname,
      'forename': forename,
      'stdForename': stdForename,
    };
  }

  factory Nam.fromMap(Map<String, dynamic> map) {
    return Nam(
      surname: map['surname'],
      stdSurname: map['stdSurname'],
      forename: map['forename'],
      stdForename: map['stdForename'],
    );
  }

  static Nam? fromDGC(Map<dynamic, dynamic> map) {
    final Map<dynamic, dynamic> namMap;
    try {
      namMap = map[-260][1]["nam"];
    } catch (e) {
      return null;
    }
    try {
      return Nam(
        surname: namMap['fn'],
        stdSurname: namMap['fnt'],
        forename: namMap['gn'],
        stdForename: namMap['gnt'],
      );
    } on Exception {
      return null;
    }
  }

  String toJson() => json.encode(toMap());

  factory Nam.fromJson(String source) => Nam.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Nam(surname: $surname, stdSurname: $stdSurname, forename: $forename, stdForename: $stdForename)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Nam &&
        other.surname == surname &&
        other.stdSurname == stdSurname &&
        other.forename == forename &&
        other.stdForename == stdForename;
  }

  @override
  int get hashCode {
    return surname.hashCode ^
        stdSurname.hashCode ^
        forename.hashCode ^
        stdForename.hashCode;
  }
}
