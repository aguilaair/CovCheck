import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({this.height = 45, Key? key}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SvgPicture.asset(
        brightness == Brightness.light
            ? "assets/logo-light.svg"
            : "assets/logo-dark.svg",
        height: height,
      ),
    );
  }
}
