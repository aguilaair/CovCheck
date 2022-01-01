import 'package:covid_checker/models/settings.dart';
import 'package:covid_checker/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({this.height = 45, this.settings, this.updateSettings, Key? key})
      : super(key: key);
  final double height;
  final void Function(Settings)? updateSettings;
  final Settings? settings;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: Stack(
        children: [
          if (settings != null && updateSettings != null)
            Positioned(
              right: 5,
              child: Tooltip(
                message: "Settings",
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return SettingScreen(
                          updateSettings: updateSettings!,
                          settings: settings!,
                        );
                      },
                    ));
                  },
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
