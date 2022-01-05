import 'dart:io';

List<int> gzipDecode(List<int> compressed) {
  return GZipCodec().decode(compressed);
}
