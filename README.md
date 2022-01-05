# CovCheck - Check EU Vaccination Status
[Version en Español](https://github.com/aguilaair/covid-certificate-checker/blob/main/README-ES.md)
[![Codemagic build status](https://api.codemagic.io/apps/61ae30a600c5fee93a2b32db/61af835df16a5919d7c363fc/status_badge.svg)](https://codemagic.io/apps/61ae30a600c5fee93a2b32db/61af835df16a5919d7c363fc/latest_build) ![GitHub release (latest by date)](https://img.shields.io/github/v/release/aguilaair/covid-certificate-checker) ![GitHub](https://img.shields.io/github/license/aguilaair/covid-certificate-checker)
![Banner](https://raw.githubusercontent.com/aguilaair/covid-certificate-checker/main/assets/promo/banner-en.svg)Covcheck is a Flutter app designed to view and validate EU Digital COVID Certificates, including vaccination status, testing results and recovery status. It follows the [schema set out by the EU](https://ec.europa.eu/health/sites/health/files/ehealth/docs/covid-certificate_json_specification_en.pdf) to extract the data as well as verifying the signature of the QR code using the certificates and data provided by the [Swedish eHealth Agency](https://dgcg.covidbevis.se/tp/).

## CovCheck Features
- The first app designed with hoteliers and businesses in mind, fast, simple and suitable for sites with a high flow of people
- Simple to set up and use, with clear messages about the validity of the certificate
  - Green: All Ok
  - Orange: Valid certificate, but with a guideline that is not fulfilled (e.g. not all doses)
  - Red: Certificate could not be verified
- Additional data such as age promote the security for restricted access premises, fake IDs are of no use anymore.
- Compatible with any PDA for extremely fast and high volume scanning. Any PDA with 2D (QR) scanner works, we recommend Honeywell for the best experience.
- Available on all platforms, including Android, iOS, iPadOS, Windows (only PDA mode), Linux (only PDA mode) and MacOS (only PDA mode) in addition to [the web](https://covcheck.eduardom.dev)

The verification is done by [dart_cose](https://pub.dev/packages/dart_cose).
![Banner Screenshot](https://raw.githubusercontent.com/aguilaair/covid-certificate-checker/main/assets/promo/Banner%20Main.png)
<a href='https://play.google.com/store/apps/details?id=dev.eduardom.covcheck&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' height=100/></a>
### Coming Soon to the App Store
<a href='#'><img alt='Get it on the App Store' src='https://www.pngmart.com/files/10/Download-On-The-App-Store-PNG-Photos.png' height=75/></a> 

# Contributing
Due to the sensitive nature of the content in `lib\certs\` no PRs will be accepeted that modify any files in that directory. If you want to request an update please open a new issue.



