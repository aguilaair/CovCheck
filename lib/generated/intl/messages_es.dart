// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  static String m0(type) => "Detalles de ${type}";

  static String m1(age) => "${age} Años";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Country": MessageLookupByLibrary.simpleMessage("País"),
        "age": MessageLookupByLibrary.simpleMessage("Edad"),
        "certType": MessageLookupByLibrary.simpleMessage("Tipo de Certificado"),
        "certid": MessageLookupByLibrary.simpleMessage("ID de Certificado"),
        "certinfo":
            MessageLookupByLibrary.simpleMessage("Información del certificado"),
        "certres": MessageLookupByLibrary.simpleMessage("Resultado"),
        "certtype":
            MessageLookupByLibrary.simpleMessage("Tipo de Certificatio"),
        "certver":
            MessageLookupByLibrary.simpleMessage("Versión del Certificado"),
        "country":
            MessageLookupByLibrary.simpleMessage("País de Administración"),
        "detected": MessageLookupByLibrary.simpleMessage("Detectado"),
        "detialtype": m0,
        "dob": MessageLookupByLibrary.simpleMessage("Fecha de Nacimiento"),
        "errordecoding":
            MessageLookupByLibrary.simpleMessage("Error en lectura de datos"),
        "errorinvaliddataformat":
            MessageLookupByLibrary.simpleMessage("Formato de datos inválido"),
        "errorinvalidformat":
            MessageLookupByLibrary.simpleMessage("Formato Inválido"),
        "errorinvalidheader": MessageLookupByLibrary.simpleMessage(
            "Formato de cabecera inválido"),
        "errorkeynotfound": MessageLookupByLibrary.simpleMessage(
            "Clave no encontrada, certificado no es de confianza"),
        "errorkidmismatch": MessageLookupByLibrary.simpleMessage(
            "Firma no coincide con certificado"),
        "errorunk": MessageLookupByLibrary.simpleMessage("Error Desconocido"),
        "errorunsopportedalgo":
            MessageLookupByLibrary.simpleMessage("Algoritmo no compatible"),
        "invalidcert":
            MessageLookupByLibrary.simpleMessage("Certificado Inválido"),
        "manname": MessageLookupByLibrary.simpleMessage("Fabricante"),
        "moredetails": MessageLookupByLibrary.simpleMessage("Mas Detalles"),
        "name": MessageLookupByLibrary.simpleMessage("Nombre"),
        "notdetected": MessageLookupByLibrary.simpleMessage("No Detectado"),
        "personaldetails":
            MessageLookupByLibrary.simpleMessage("Datos Personales"),
        "prodName": MessageLookupByLibrary.simpleMessage("Nombre del Producto"),
        "rawData": MessageLookupByLibrary.simpleMessage("Datos sin Procesar"),
        "recovered": MessageLookupByLibrary.simpleMessage("Recuperado"),
        "restartcamera":
            MessageLookupByLibrary.simpleMessage("Reiniciar Cámara"),
        "rotatecamera": MessageLookupByLibrary.simpleMessage("Cambiar Cámara"),
        "scanqrmessage":
            MessageLookupByLibrary.simpleMessage("Escanea un código QR"),
        "signingauth":
            MessageLookupByLibrary.simpleMessage("Autoridad de Firmado"),
        "surname": MessageLookupByLibrary.simpleMessage("Apellido(s)"),
        "targetdisease": MessageLookupByLibrary.simpleMessage("Emfermedad"),
        "test": MessageLookupByLibrary.simpleMessage("Prueba"),
        "testdate": MessageLookupByLibrary.simpleMessage("Fecha de Prueba"),
        "testloc":
            MessageLookupByLibrary.simpleMessage("Localización de Prueba"),
        "testtype": MessageLookupByLibrary.simpleMessage("Tipo de Test"),
        "toggleflash": MessageLookupByLibrary.simpleMessage("Flash"),
        "unk": MessageLookupByLibrary.simpleMessage("Desconocido"),
        "vaccination": MessageLookupByLibrary.simpleMessage("Vacunación"),
        "vaccproph": MessageLookupByLibrary.simpleMessage("Tipo de Vacuna"),
        "vacdate": MessageLookupByLibrary.simpleMessage("Fecha de Vacunación"),
        "vacdoses": MessageLookupByLibrary.simpleMessage("Dosis"),
        "validcert": MessageLookupByLibrary.simpleMessage("Certificado Válido"),
        "xageold": m1
      };
}
