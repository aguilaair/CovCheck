import 'package:covid_checker/generated/l10n.dart';
import 'package:covid_checker/models/result.dart';
import 'package:covid_checker/models/settings.dart';
import 'package:covid_checker/widgets/certOverview/result_card.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../molecules/logo.dart';

class CertSimplifiedView extends StatelessWidget {
  const CertSimplifiedView({
    required this.coseResult,
    required this.barcodeResult,
    required this.dismiss,
    required this.processedResult,
    required this.toggleCamPda,
    required this.isPda,
    required this.setSettings,
    required this.settings,
    Key? key,
  }) : super(key: key);

  final CoseResult? coseResult;
  final Barcode? barcodeResult;
  final Function dismiss;
  final Result? processedResult;
  final bool isPda;
  final Function toggleCamPda;
  final void Function(Settings)? setSettings;
  final Settings settings;

  @override
  Widget build(BuildContext context) {
    if (coseResult != null &&
        barcodeResult != null &&
        //processedResult != null &&
        barcodeResult!.format == BarcodeFormat.qrcode) {
      // Verified
      return Expanded(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            EmptyResult(
              isPda: isPda,
              toggleCamPda: toggleCamPda,
              setSettings: setSettings,
              settings: settings,
            ),
            ResultCard(
              barcodeResult: barcodeResult!,
              coseResult: coseResult!,
              dismiss: dismiss,
              processedResult: processedResult,
            ),
          ],
        ),
      );
    }
    // No Result
    return Expanded(
      child: EmptyResult(
        isPda: isPda,
        toggleCamPda: toggleCamPda,
        setSettings: setSettings,
        settings: settings,
      ),
    );
  }
}

class EmptyResult extends StatelessWidget {
  const EmptyResult({
    Key? key,
    required this.isPda,
    required this.toggleCamPda,
    required this.setSettings,
    required this.settings,
  }) : super(key: key);

  final bool isPda;
  final Function toggleCamPda;
  final void Function(Settings)? setSettings;
  final Settings settings;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (MediaQuery.of(context).orientation == Orientation.landscape)
            Logo(
              settings: settings,
              updateSettings: setSettings,
              height: 45,
            ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.qr_code_rounded,
                  size: 70,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  S.of(context).scanqrmessage,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 5,
                ),
                if (isPda)
                  Text(
                    S.of(context).pdadetected,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w100),
                  ),
                if (isPda)
                  const SizedBox(
                    height: 10,
                  ),
                if (isPda)
                  TextButton.icon(
                    onPressed: () {
                      toggleCamPda();
                    },
                    icon: const Icon(Icons.cameraswitch_sharp),
                    label: Text(S.of(context).pdaswitch),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
