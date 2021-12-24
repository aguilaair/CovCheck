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
}
