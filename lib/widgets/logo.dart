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
          //if (settings != null && updateSettings != null)
          Positioned(
            right: (settings != null && updateSettings != null) ? 5 : null,
            left: (settings != null && updateSettings != null) ? null : 5,
            child: Tooltip(
              message: (settings != null && updateSettings != null)
                  ? "Back"
                  : "Settings",
              child: IconButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return SettingScreen(
                          updateSettings: updateSettings!,
                          settings: settings!,
                        );
                      },
                    ));
                  }
                },
                icon: !(settings != null && updateSettings != null)
                    ? const Icon(Icons.arrow_back_rounded)
                    : const Icon(Icons.settings),
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
