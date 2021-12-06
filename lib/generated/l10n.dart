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

  /// `Certificado Válido`
  String get validcert {
    return Intl.message(
      'Certificado Válido',
      name: 'validcert',
      desc: '',
      args: [],
    );
  }

  /// `Certificado Inválido`
  String get invalidcert {
    return Intl.message(
      'Certificado Inválido',
      name: 'invalidcert',
      desc: '',
      args: [],
    );
  }

  /// `Escanea un código QR`
  String get scanqrmessage {
    return Intl.message(
      'Escanea un código QR',
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

  /// `Cambiar Cámara`
  String get rotatecamera {
    return Intl.message(
      'Cambiar Cámara',
      name: 'rotatecamera',
      desc: '',
      args: [],
    );
  }

  /// `Reiniciar Cámara`
  String get restartcamera {
    return Intl.message(
      'Reiniciar Cámara',
      name: 'restartcamera',
      desc: '',
      args: [],
    );
  }

  /// `Nombre`
  String get name {
    return Intl.message(
      'Nombre',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Apellido(s)`
  String get surname {
    return Intl.message(
      'Apellido(s)',
      name: 'surname',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de Nacimiento`
  String get dob {
    return Intl.message(
      'Fecha de Nacimiento',
      name: 'dob',
      desc: '',
      args: [],
    );
  }

  /// `Edad`
  String get age {
    return Intl.message(
      'Edad',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `País`
  String get Country {
    return Intl.message(
      'País',
      name: 'Country',
      desc: '',
      args: [],
    );
  }

  /// `Tipo de Certificado`
  String get certType {
    return Intl.message(
      'Tipo de Certificado',
      name: 'certType',
      desc: '',
      args: [],
    );
  }

  /// `Autoridad de Firmado`
  String get signingauth {
    return Intl.message(
      'Autoridad de Firmado',
      name: 'signingauth',
      desc: '',
      args: [],
    );
  }

  /// `Mas Detalles`
  String get moredetails {
    return Intl.message(
      'Mas Detalles',
      name: 'moredetails',
      desc: '',
      args: [],
    );
  }

  /// `{age} Años`
  String xageold(Object age) {
    return Intl.message(
      '$age Años',
      name: 'xageold',
      desc: '',
      args: [age],
    );
  }

  /// `Fabricante`
  String get manname {
    return Intl.message(
      'Fabricante',
      name: 'manname',
      desc: '',
      args: [],
    );
  }

  /// `Emfermedad`
  String get targetdisease {
    return Intl.message(
      'Emfermedad',
      name: 'targetdisease',
      desc: '',
      args: [],
    );
  }

  /// `Tipo de Vacuna`
  String get vaccproph {
    return Intl.message(
      'Tipo de Vacuna',
      name: 'vaccproph',
      desc: '',
      args: [],
    );
  }

  /// `Nombre del Producto`
  String get prodName {
    return Intl.message(
      'Nombre del Producto',
      name: 'prodName',
      desc: '',
      args: [],
    );
  }

  /// `Dosis`
  String get vacdoses {
    return Intl.message(
      'Dosis',
      name: 'vacdoses',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de Vacunación`
  String get vacdate {
    return Intl.message(
      'Fecha de Vacunación',
      name: 'vacdate',
      desc: '',
      args: [],
    );
  }

  /// `País de Administración`
  String get country {
    return Intl.message(
      'País de Administración',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Tipo de Certificatio`
  String get certtype {
    return Intl.message(
      'Tipo de Certificatio',
      name: 'certtype',
      desc: '',
      args: [],
    );
  }

  /// `ID de Certificado`
  String get certid {
    return Intl.message(
      'ID de Certificado',
      name: 'certid',
      desc: '',
      args: [],
    );
  }

  /// `Versión del Certificado`
  String get certver {
    return Intl.message(
      'Versión del Certificado',
      name: 'certver',
      desc: '',
      args: [],
    );
  }

  /// `Datos sin Procesar`
  String get rawData {
    return Intl.message(
      'Datos sin Procesar',
      name: 'rawData',
      desc: '',
      args: [],
    );
  }

  /// `Tipo de Test`
  String get testtype {
    return Intl.message(
      'Tipo de Test',
      name: 'testtype',
      desc: '',
      args: [],
    );
  }

  /// `Resultado`
  String get certres {
    return Intl.message(
      'Resultado',
      name: 'certres',
      desc: '',
      args: [],
    );
  }

  /// `Detectado`
  String get detected {
    return Intl.message(
      'Detectado',
      name: 'detected',
      desc: '',
      args: [],
    );
  }

  /// `No Detectado`
  String get notdetected {
    return Intl.message(
      'No Detectado',
      name: 'notdetected',
      desc: '',
      args: [],
    );
  }

  /// `Vacunación`
  String get vaccination {
    return Intl.message(
      'Vacunación',
      name: 'vaccination',
      desc: '',
      args: [],
    );
  }

  /// `Prueba`
  String get test {
    return Intl.message(
      'Prueba',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de Prueba`
  String get testdate {
    return Intl.message(
      'Fecha de Prueba',
      name: 'testdate',
      desc: '',
      args: [],
    );
  }

  /// `Desconocido`
  String get unk {
    return Intl.message(
      'Desconocido',
      name: 'unk',
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
