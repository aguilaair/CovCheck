int? yearsOld(DateTime? birthDate) {
  if (birthDate == null) {
    return null;
  }
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int monthCurrent = currentDate.month;
  int monthBirth = birthDate.month;
  if (monthBirth > monthCurrent) {
    age--;
  } else if (monthCurrent == monthBirth) {
    int dayCurrent = currentDate.day;
    int dayBirth = birthDate.day;
    if (dayBirth > dayCurrent) {
      age--;
    }
  }
  return age;
}
