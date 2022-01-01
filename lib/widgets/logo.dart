import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({this.height = 45, Key? key}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            right: 5,
            child: Tooltip(
              message: "Settings",
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
                color: Theme.of(context).iconTheme.color!.withOpacity(0.8),
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                brightness == Brightness.light
                    ? "assets/logo-light.svg"
                    : "assets/logo-dark.svg",
                height: height,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
