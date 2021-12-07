// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(type) => "${type} Details";

  static String m1(age) => "${age} Years";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Country": MessageLookupByLibrary.simpleMessage("Country"),
        "age": MessageLookupByLibrary.simpleMessage("Age"),
        "certType": MessageLookupByLibrary.simpleMessage("Type of certificate"),
        "certid": MessageLookupByLibrary.simpleMessage("Certificate ID"),
        "certinfo": MessageLookupByLibrary.simpleMessage("Certificate Info"),
        "certres": MessageLookupByLibrary.simpleMessage("Result"),
        "certtype": MessageLookupByLibrary.simpleMessage("Type of certificate"),
        "certver": MessageLookupByLibrary.simpleMessage("Certificate Version"),
        "country": MessageLookupByLibrary.simpleMessage("Vaccination country"),
        "detected": MessageLookupByLibrary.simpleMessage("Detected"),
        "detialtype": m0,
        "dob": MessageLookupByLibrary.simpleMessage("Date of Brith"),
        "errordecoding":
            MessageLookupByLibrary.simpleMessage("Data Read Error"),
        "errorinvaliddataformat":
            MessageLookupByLibrary.simpleMessage("Data Format Error"),
        "errorinvalidformat":
            MessageLookupByLibrary.simpleMessage("Invalid Format"),
        "errorinvalidheader":
            MessageLookupByLibrary.simpleMessage("Invalid Header Format"),
        "errorkeynotfound": MessageLookupByLibrary.simpleMessage(
            "Key Not Found, cannot trust signing authority"),
        "errorkidmismatch":
            MessageLookupByLibrary.simpleMessage("Signing Mismatch"),
        "errorunk": MessageLookupByLibrary.simpleMessage("Unknown Error"),
        "errorunsopportedalgo":
            MessageLookupByLibrary.simpleMessage("Unsupported Algorithm"),
        "invalidcert":
            MessageLookupByLibrary.simpleMessage("Invalid Certificate"),
        "manname": MessageLookupByLibrary.simpleMessage("Manufacturer"),
        "moredetails": MessageLookupByLibrary.simpleMessage("More Details"),
        "name": MessageLookupByLibrary.simpleMessage("First Name"),
        "notdetected": MessageLookupByLibrary.simpleMessage("Not Detected"),
        "personaldetails":
            MessageLookupByLibrary.simpleMessage("Personal Details"),
        "prodName": MessageLookupByLibrary.simpleMessage("Name of Product"),
        "rawData": MessageLookupByLibrary.simpleMessage("Raw Data"),
        "recovered": MessageLookupByLibrary.simpleMessage("Recovered"),
        "restartcamera": MessageLookupByLibrary.simpleMessage("Restart Camera"),
        "rotatecamera": MessageLookupByLibrary.simpleMessage("Change Camera"),
        "scanqrmessage": MessageLookupByLibrary.simpleMessage("Scan a QR Code"),
        "signingauth":
            MessageLookupByLibrary.simpleMessage("Signing Authority"),
        "surname": MessageLookupByLibrary.simpleMessage("Last Name"),
        "targetdisease": MessageLookupByLibrary.simpleMessage("Disease"),
        "test": MessageLookupByLibrary.simpleMessage("Test"),
        "testdate": MessageLookupByLibrary.simpleMessage("Test Date"),
        "testloc": MessageLookupByLibrary.simpleMessage("Location of Test"),
        "testtype": MessageLookupByLibrary.simpleMessage("Test type"),
        "toggleflash": MessageLookupByLibrary.simpleMessage("Flash"),
        "unk": MessageLookupByLibrary.simpleMessage("Unknown"),
        "vaccination": MessageLookupByLibrary.simpleMessage("Vacciantion"),
        "vaccproph":
            MessageLookupByLibrary.simpleMessage("Vaccination Prophylaxis"),
        "vacdate": MessageLookupByLibrary.simpleMessage("Vacciantion Date"),
        "vacdoses": MessageLookupByLibrary.simpleMessage("Doses"),
        "validcert": MessageLookupByLibrary.simpleMessage("Valid Certificate"),
        "xageold": m1
      };
}
