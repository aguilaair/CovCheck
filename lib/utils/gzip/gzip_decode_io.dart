import 'dart:io';

List<int> gzipDecode(List<int> compressed) {
  var scanres = GZipCodec().decode(compressed);
  return scanres;
}
