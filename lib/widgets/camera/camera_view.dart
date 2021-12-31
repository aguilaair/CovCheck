import 'dart:math';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraView extends StatelessWidget {
  const CameraView({
    required this.onQRViewCreated,
    required this.qrKey,
    required this.size,
    Key? key,
  }) : super(key: key);

  final Key qrKey;
  final Size size;
  final void Function(QRViewController) onQRViewCreated;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: QRView(
          key: qrKey,
          overlay: !kIsWeb
              ? QrScannerOverlayShape(
                  cutOutWidth: min(size.width * 0.65, size.height * 0.65),
                  cutOutHeight: min(size.width * 0.65, size.height * 0.65),
                  borderRadius: 15,
                  overlayColor: Colors.black.withAlpha(100))
              : null,
          onQRViewCreated: onQRViewCreated,
        ),
      ),
    );
  }
}
