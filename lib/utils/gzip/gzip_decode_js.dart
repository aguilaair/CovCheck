// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js' as js;

List<int> gzipDecode(List<int> compressed) {
  var scanres = js.context["pako"].callMethod("inflate", [compressed]);
  return scanres;
}
