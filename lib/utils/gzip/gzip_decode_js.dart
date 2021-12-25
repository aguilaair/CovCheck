import 'dart:js' as js;

List<int> gzipDecode(List<int> compressed) {
  var scanres = js.context["pako"].callMethod("inflate", [compressed]);
  return scanres;
}
