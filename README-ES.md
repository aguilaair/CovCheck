# CovCheck - Check EU Vaccination Status
[English Version](https://github.com/aguilaair/covid-certificate-checker#readme)
[![Codemagic build status](https://api.codemagic.io/apps/61ae30a600c5fee93a2b32db/61af835df16a5919d7c363fc/status_badge.svg)](https://codemagic.io/apps/61ae30a600c5fee93a2b32db/61af835df16a5919d7c363fc/latest_build) ![GitHub release (latest by date)](https://img.shields.io/github/v/release/aguilaair/covid-certificate-checker) ![GitHub](https://img.shields.io/github/license/aguilaair/covid-certificate-checker)
![Banner](https://raw.githubusercontent.com/aguilaair/covid-certificate-checker/main/assets/promo/banner-es.svg)Covcheck es una app hacha con Flutter diseñada para ver y validar Certificados Digitales COVID-19 emitidos por la UE, incluyendo vacunación, resultado de tests y estado de recuperación. Sigue la [estructura indicada por la UE](https://ec.europa.eu/health/sites/health/files/ehealth/docs/covid-certificate_json_specification_en.pdf) para extraer los daos además de verificar la firma electrónica del código QR utlizando la base de datos y certificados proporcinada por la [Agencia de Salud Elctrónica de Suecia](https://dgcg.covidbevis.se/tp/).

## Funcionalidades de CovCheck
- La primera app diseñada con hosteleros y empresas en mente, rápida, sencilla y adecuada para sitios con mucho flujo de gente
- Sencilla de configurar y utilizar, con mensajes claros sobre la validez del certificado
  - Verde: Todo Ok
  - Naranja: Certificado válido pero con una pauta que no se cumple (e.g. no todas las dosis)
  - Rojo: No se ha podido verificar el certificado
- Datos adicionales como la edad promueven la seguridad de los locales de acceso restringido, los DNIs falsos yo no sirven
- Compatible con cualquier PDA para un escaneo extremadamente rápido y de alto volumen. Cualquier PDA con escaner 2D (QR) funciona, recomendamos Honeywell para la mejor experiencia.
- Disponible en todas las plataformas, incluyendo Android, iOS, iPadOS, Windows (Sólo modo PDA), Linux (Sólo modo PDA) y MacOS (Sólo modo PDA) además de en [la web](https://covcheck.eduardom.dev)

La validación de certificados es hecha por [dart_cose](https://pub.dev/packages/dart_cose).
![Banner Screenshot](https://raw.githubusercontent.com/aguilaair/covid-certificate-checker/main/assets/promo/Banner%20Main%20ES.png)
<a href='https://play.google.com/store/apps/details?id=dev.eduardom.covcheck&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' height=100/></a>
### Pronto en la App Store
<a href='#'><img alt='Get it on the App Store' src='https://www.pngmart.com/files/10/Download-On-The-App-Store-PNG-Photos.png' height=75/></a> 

# Contributing
¿Quieres contribuir? [Compureba esto](https://github.com/aguilaair/covid-certificate-checker#contributing)



