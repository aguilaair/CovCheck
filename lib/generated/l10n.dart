// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Valid Certificate`
  String get validcert {
    return Intl.message(
      'Valid Certificate',
      name: 'validcert',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Certificate`
  String get invalidcert {
    return Intl.message(
      'Invalid Certificate',
      name: 'invalidcert',
      desc: '',
      args: [],
    );
  }

  /// `Scan a QR Code`
  String get scanqrmessage {
    return Intl.message(
      'Scan a QR Code',
      name: 'scanqrmessage',
      desc: '',
      args: [],
    );
  }

  /// `Flash`
  String get toggleflash {
    return Intl.message(
      'Flash',
      name: 'toggleflash',
      desc: '',
      args: [],
    );
  }

  /// `Change Camera`
  String get rotatecamera {
    return Intl.message(
      'Change Camera',
      name: 'rotatecamera',
      desc: '',
      args: [],
    );
  }

  /// `Restart Camera`
  String get restartcamera {
    return Intl.message(
      'Restart Camera',
      name: 'restartcamera',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get name {
    return Intl.message(
      'First Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get surname {
    return Intl.message(
      'Last Name',
      name: 'surname',
      desc: '',
      args: [],
    );
  }

  /// `Date of Brith`
  String get dob {
    return Intl.message(
      'Date of Brith',
      name: 'dob',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get Country {
    return Intl.message(
      'Country',
      name: 'Country',
      desc: '',
      args: [],
    );
  }

  /// `Type of certificate`
  String get certType {
    return Intl.message(
      'Type of certificate',
      name: 'certType',
      desc: '',
      args: [],
    );
  }

  /// `Signing Authority`
  String get signingauth {
    return Intl.message(
      'Signing Authority',
      name: 'signingauth',
      desc: '',
      args: [],
    );
  }

  /// `More Details`
  String get moredetails {
    return Intl.message(
      'More Details',
      name: 'moredetails',
      desc: '',
      args: [],
    );
  }

  /// `{age} Years`
  String xageold(Object age) {
    return Intl.message(
      '$age Years',
      name: 'xageold',
      desc: '',
      args: [age],
    );
  }

  /// `Manufacturer`
  String get manname {
    return Intl.message(
      'Manufacturer',
      name: 'manname',
      desc: '',
      args: [],
    );
  }

  /// `Disease`
  String get targetdisease {
    return Intl.message(
      'Disease',
      name: 'targetdisease',
      desc: '',
      args: [],
    );
  }

  /// `Vaccination Prophylaxis`
  String get vaccproph {
    return Intl.message(
      'Vaccination Prophylaxis',
      name: 'vaccproph',
      desc: '',
      args: [],
    );
  }

  /// `Name of Product`
  String get prodName {
    return Intl.message(
      'Name of Product',
      name: 'prodName',
      desc: '',
      args: [],
    );
  }

  /// `Doses`
  String get vacdoses {
    return Intl.message(
      'Doses',
      name: 'vacdoses',
      desc: '',
      args: [],
    );
  }

  /// `Vacciantion Date`
  String get vacdate {
    return Intl.message(
      'Vacciantion Date',
      name: 'vacdate',
      desc: '',
      args: [],
    );
  }

  /// `Vaccination country`
  String get country {
    return Intl.message(
      'Vaccination country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Type of certificate`
  String get certtype {
    return Intl.message(
      'Type of certificate',
      name: 'certtype',
      desc: '',
      args: [],
    );
  }

  /// `Certificate ID`
  String get certid {
    return Intl.message(
      'Certificate ID',
      name: 'certid',
      desc: '',
      args: [],
    );
  }

  /// `Certificate Version`
  String get certver {
    return Intl.message(
      'Certificate Version',
      name: 'certver',
      desc: '',
      args: [],
    );
  }

  /// `Raw Data`
  String get rawData {
    return Intl.message(
      'Raw Data',
      name: 'rawData',
      desc: '',
      args: [],
    );
  }

  /// `Test type`
  String get testtype {
    return Intl.message(
      'Test type',
      name: 'testtype',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get certres {
    return Intl.message(
      'Result',
      name: 'certres',
      desc: '',
      args: [],
    );
  }

  /// `Detected`
  String get detected {
    return Intl.message(
      'Detected',
      name: 'detected',
      desc: '',
      args: [],
    );
  }

  /// `Not Detected`
  String get notdetected {
    return Intl.message(
      'Not Detected',
      name: 'notdetected',
      desc: '',
      args: [],
    );
  }

  /// `Vacciantion`
  String get vaccination {
    return Intl.message(
      'Vacciantion',
      name: 'vaccination',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get test {
    return Intl.message(
      'Test',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `Test Date`
  String get testdate {
    return Intl.message(
      'Test Date',
      name: 'testdate',
      desc: '',
      args: [],
    );
  }

  /// `Location of Test`
  String get testloc {
    return Intl.message(
      'Location of Test',
      name: 'testloc',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unk {
    return Intl.message(
      'Unknown',
      name: 'unk',
      desc: '',
      args: [],
    );
  }

  /// `Recovered`
  String get recovered {
    return Intl.message(
      'Recovered',
      name: 'recovered',
      desc: '',
      args: [],
    );
  }

  /// `Key Not Found, cannot trust signing authority`
  String get errorkeynotfound {
    return Intl.message(
      'Key Not Found, cannot trust signing authority',
      name: 'errorkeynotfound',
      desc: '',
      args: [],
    );
  }

  /// `Data Read Error`
  String get errordecoding {
    return Intl.message(
      'Data Read Error',
      name: 'errordecoding',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Format`
  String get errorinvalidformat {
    return Intl.message(
      'Invalid Format',
      name: 'errorinvalidformat',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Header Format`
  String get errorinvalidheader {
    return Intl.message(
      'Invalid Header Format',
      name: 'errorinvalidheader',
      desc: '',
      args: [],
    );
  }

  /// `Data Format Error`
  String get errorinvaliddataformat {
    return Intl.message(
      'Data Format Error',
      name: 'errorinvaliddataformat',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported Algorithm`
  String get errorunsopportedalgo {
    return Intl.message(
      'Unsupported Algorithm',
      name: 'errorunsopportedalgo',
      desc: '',
      args: [],
    );
  }

  /// `Signing Mismatch`
  String get errorkidmismatch {
    return Intl.message(
      'Signing Mismatch',
      name: 'errorkidmismatch',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Error`
  String get errorunk {
    return Intl.message(
      'Unknown Error',
      name: 'errorunk',
      desc: '',
      args: [],
    );
  }

  /// `{type} Details`
  String detialtype(Object type) {
    return Intl.message(
      '$type Details',
      name: 'detialtype',
      desc: '',
      args: [type],
    );
  }

  /// `Personal Details`
  String get personaldetails {
    return Intl.message(
      'Personal Details',
      name: 'personaldetails',
      desc: '',
      args: [],
    );
  }

  /// `Certificate Info`
  String get certinfo {
    return Intl.message(
      'Certificate Info',
      name: 'certinfo',
      desc: '',
      args: [],
    );
  }

  /// `Vaccination Not Complete`
  String get nopassvac {
    return Intl.message(
      'Vaccination Not Complete',
      name: 'nopassvac',
      desc: '',
      args: [],
    );
  }

  /// `Test Detected Pathogen`
  String get nopasstest {
    return Intl.message(
      'Test Detected Pathogen',
      name: 'nopasstest',
      desc: '',
      args: [],
    );
  }

  /// `Outside of Valid Recovery Dates`
  String get nopassrecov {
    return Intl.message(
      'Outside of Valid Recovery Dates',
      name: 'nopassrecov',
      desc: '',
      args: [],
    );
  }

  /// `Validity`
  String get recovstate {
    return Intl.message(
      'Validity',
      name: 'recovstate',
      desc: '',
      args: [],
    );
  }

  /// `Valid`
  String get valid {
    return Intl.message(
      'Valid',
      name: 'valid',
      desc: '',
      args: [],
    );
  }

  /// `Invalid (Expired)`
  String get invalid {
    return Intl.message(
      'Invalid (Expired)',
      name: 'invalid',
      desc: '',
      args: [],
    );
  }

  /// `First Positive Test`
  String get firstpositivetest {
    return Intl.message(
      'First Positive Test',
      name: 'firstpositivetest',
      desc: '',
      args: [],
    );
  }

  /// `Valid From`
  String get validfrom {
    return Intl.message(
      'Valid From',
      name: 'validfrom',
      desc: '',
      args: [],
    );
  }

  /// `Valid Until`
  String get validuntil {
    return Intl.message(
      'Valid Until',
      name: 'validuntil',
      desc: '',
      args: [],
    );
  }

  /// `Warning: Web Experience may be limited`
  String get webwarntitle {
    return Intl.message(
      'Warning: Web Experience may be limited',
      name: 'webwarntitle',
      desc: '',
      args: [],
    );
  }

  /// `CovCheck on the web may not offer the best experience, with some features not working and performace being reduced. Please install the app on your phone.`
  String get webwarntext {
    return Intl.message(
      'CovCheck on the web may not offer the best experience, with some features not working and performace being reduced. Please install the app on your phone.',
      name: 'webwarntext',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
