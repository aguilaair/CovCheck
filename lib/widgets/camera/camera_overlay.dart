import 'package:covid_checker/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraOverlay extends StatelessWidget {
  const CameraOverlay({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      top: 10,
      child: Row(
        children: [
          /// Flash
          Tooltip(
            message: S.of(context).toggleflash,
            child: IconButton(
              onPressed: () {
                controller?.toggleFlash();
              },
              icon: const Icon(
                Icons.flash_on_rounded,
                color: Colors.white,
              ),
            ),
          ),

          /// Rotate/Change camera
          Tooltip(
            message: S.of(context).rotatecamera,
            child: IconButton(
              onPressed: () {
                controller?.flipCamera();
              },
              icon: const Icon(
                Icons.cameraswitch_rounded,
                color: Colors.white,
              ),
            ),
          ),

          /// Restart Camera
          Tooltip(
            message: S.of(context).restartcamera,
            child: IconButton(
              onPressed: () {
                controller?.pauseCamera();
                controller?.resumeCamera();
              },
              icon: const Icon(
                Icons.restart_alt_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
