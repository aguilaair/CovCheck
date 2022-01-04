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
  final Settings? settings;

  @override
  Widget build(BuildContext context) {
    if (coseResult != null &&
        barcodeResult != null &&
        //processedResult != null &&
        barcodeResult!.format == BarcodeFormat.qrcode) {
      // Verified
      return Expanded(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            EmptyResult(
              isPda: isPda,
              toggleCamPda: toggleCamPda,
              setSettings: setSettings,
              settings: settings,
            ),
            TweenAnimationBuilder(
              tween: Tween<Offset>(
                  begin: const Offset(0, 1), end: const Offset(0, 0)),
              duration: const Duration(milliseconds: 50),
              curve: Curves.easeIn,
              builder: (context, Offset value, child) {
                return FractionalTranslation(
                  translation: value,
                  child: child!,
                );
              },
              child: ResultCard(
                barcodeResult: barcodeResult!,
                coseResult: coseResult!,
                dismiss: dismiss,
                processedResult: processedResult,
              ),
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
  final Settings? settings;

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
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).splashColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      (settings?.isPdaModeEnabled ?? false)
                          ? S.of(context).pdamodeon
                          : S.of(context).pdamodeoff,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.w300),
                    ),
                  ),
                if (isPda)
                  const SizedBox(
                    height: 10,
                  ),
                if (isPda && (settings?.isCameraSupported ?? true))
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
