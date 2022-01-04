
import 'package:covid_checker/certs/certs.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jose/jose.dart';

Future<Map<String, dynamic>> getNewCerts() async {
  final keyStore = JsonWebKeyStore();
  keyStore.addKey(JsonWebKey.fromPem("""-----BEGIN CERTIFICATE-----
MIIB6jCCAY+gAwIBAgIUZVUDZ9xmLgGkjoqXhMizIaqko4AwCgYIKoZIzj0EAwIw
TTELMAkGA1UEBhMCU0UxHzAdBgNVBAoMFlN3ZWRpc2ggZUhlYWx0aCBBZ2VuY3kx
HTAbBgNVBAMMFERDQyBOYXRpb25hbCBCYWNrZW5kMB4XDTIxMDYxMTE0NDA0N1oX
DTIzMDYxMTE0NDA0N1owTTELMAkGA1UEBhMCU0UxHzAdBgNVBAoMFlN3ZWRpc2gg
ZUhlYWx0aCBBZ2VuY3kxHTAbBgNVBAMMFERDQyBOYXRpb25hbCBCYWNrZW5kMFkw
EwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEbQS1Rt6niozeBzaB8ypNqson5psIc8+G
eeGGgDKajD3xFNqzTXJELwLX8dMihl1jy5LMNmzN89jDTq3Vz5uPeaNNMEswDAYD
VR0TAQH/BAIwADAOBgNVHQ8BAf8EBAMCB4AwKwYDVR0RBCQwIoEgcmVnaXN0cmF0
b3JAZWhhbHNvbXluZGlnaGV0ZW4uc2UwCgYIKoZIzj0EAwIDSQAwRgIhAL02Iy2x
if3oTSivwKg+fZDwquoTgTMJnCUJzyltYExjAiEAsT3U7icfdH3FtrZ/NZ2LlC5r
sSSXWtDUTXhmclnJFnU=
-----END CERTIFICATE-----"""));
  Map<String, String> certs = {};
  DateTime? iat;
  final newCertsReq = await http.get(
    Uri(scheme: "https", host: "dgcg.covidbevis.se", path: "tp/trust-list"),
  );
  if (newCertsReq.statusCode == 200) {
    final decodedjwt =
        JsonWebSignature.fromCompactSerialization(newCertsReq.body);

    final content = (await decodedjwt.getPayload(keyStore)).jsonContent;
    (content["dsc_trust_list"] as Map).forEach((key, value) {
      for (var element in (value["keys"] as List)) {
        certs[element["kid"]] = (element["x5c"][0] as String);
      }
    });

    Hive.box("certs").put("certs", certs);

    iat = DateTime.fromMillisecondsSinceEpoch(
      (content['iat'] as int) * 1000,
    );

    Hive.box("certs").put("certs_iat", iat);
  }
  return {"certs": certs, "iat": iat};
}

Map<String, String> initCerts(Function setCerts) {
  final certsLoaded = Hive.box('certs').get(
    "certs",
  );
  Map<String, String> certMap = {};
  if (certsLoaded == null) {
    (certs["dsc_trust_list"] as Map).forEach((key, value) {
      for (var element in (value["keys"] as List)) {
        certMap[element["kid"]] = (element["x5c"][0] as String);
      }
    });
    Hive.box('certs').put('certs', certMap);
    Hive.box('certs').put(
        'certs',
        DateTime.fromMillisecondsSinceEpoch(
          (certs['iat'] as int) * 1000,
        ));
  } else {
    certMap = Map<String, String>.from(certsLoaded);
  }

  Hive.box("certs").listenable(keys: ["certs"]).addListener(() {
    setCerts(Map<String, String>.from(Hive.box('certs').get("certs")));
  });

  return certMap;
}
