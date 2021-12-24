import 'package:covid_checker/generated/l10n.dart';
import 'package:dart_cose/dart_cose.dart';

String beautifyCose(CoseErrorCode error) {
  if (error == CoseErrorCode.cbor_decoding_error) {
    return S.current.errordecoding;
  } else if (error == CoseErrorCode.invalid_format ||
      error == CoseErrorCode.payload_format_error ||
      error == CoseErrorCode.unsupported_format) {
    return S.current.errorinvalidformat;
  } else if (error == CoseErrorCode.invalid_header_format ||
      error == CoseErrorCode.unsupported_header_format) {
    return S.current.errorinvalidheader;
  } else if (error == CoseErrorCode.key_not_found) {
    return S.current.errorkeynotfound;
  } else if (error == CoseErrorCode.kid_mismatch) {
    return S.current.errorkidmismatch;
  } else if (error == CoseErrorCode.payload_format_error) {
    return S.current.errorinvaliddataformat;
  } else if (error == CoseErrorCode.unsupported_algorithm) {
    return S.current.errorunsopportedalgo;
  }
  return S.current.errorunk;
}
