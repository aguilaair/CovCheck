# CovCheck - Check EU Vaccination Status
![Banner](https://raw.githubusercontent.com/aguilaair/covid-certificate-checker/main/assets/promo/banner-en.svg)Covcheck is a Flutter app designed to view and validate EU EU Digital COVID Certificates, including vaccination status, testing results and recovery status. It follows the [schema set out by the EU](https://ec.europa.eu/health/sites/health/files/ehealth/docs/covid-certificate_json_specification_en.pdf) to extract the data as well as verifying the signature of the QR code using the certificates and data provided by the [Swedish eHealth Agency](https://dgcg.covidbevis.se/tp/).

The verification is done by [dart_cose](https://pub.dev/packages/dart_cose).
![Banner Screenshot](https://raw.githubusercontent.com/aguilaair/covid-certificate-checker/main/assets/promo/Banner%20Main.png)
<a href='https://play.google.com/store/apps/details?id=dev.eduardom.covcheck&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' width=300/></a>

# Contributing
Due to the sensitive nature of the content in `lib\utils\certs.dart` no PRs will be accepeted that modify the file. If you want to request an update please open a new issue.



