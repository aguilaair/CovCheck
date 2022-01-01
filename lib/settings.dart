import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:covid_checker/widgets/logo.dart';
import 'package:flutter/material.dart';

import 'package:settings_ui/settings_ui.dart';

import 'models/settings.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    required this.settings,
    required this.updateSettings,
    Key? key,
  }) : super(key: key);

  final Settings settings;
  final void Function(Settings) updateSettings;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Logo(
              height: 50,
            ),
            Expanded(
              child: SettingsList(
                backgroundColor: Theme.of(context).backgroundColor,
                sections: [
                  SettingsSection(
                    tiles: [
                      SettingsTile(
                        title: 'Back',
                        leading: const Icon(Icons.arrow_back_rounded),
                        onPressed: (BuildContext context) {
                          Navigator.of(context).maybePop();
                        },
                      ),
                      SettingsTile(
                        title: 'Language',
                        subtitle: widget.settings.locale,
                        leading: const Icon(Icons.language),
                        onPressed: (BuildContext context) {},
                      ),
                      SettingsTile(
                        title: 'Theme',
                        leading: Icon(AdaptiveTheme.of(context).mode ==
                                AdaptiveThemeMode.light
                            ? Icons.light_mode_rounded
                            : AdaptiveTheme.of(context).mode ==
                                    AdaptiveThemeMode.system
                                ? Icons.auto_awesome
                                : Icons.dark_mode_rounded),
                        trailing: DropdownButton(
                          items: const [
                            DropdownMenuItem(
                              child: Text("Light"),
                              value: AdaptiveThemeMode.light,
                            ),
                            DropdownMenuItem(
                              child: Text("Dark"),
                              value: AdaptiveThemeMode.dark,
                            ),
                            DropdownMenuItem(
                              child: Text("System"),
                              value: AdaptiveThemeMode.system,
                            ),
                          ],
                          value: AdaptiveTheme.of(context).mode,
                          onChanged: (value) {
                            if (value == AdaptiveThemeMode.system) {
                              AdaptiveTheme.of(context).setSystem();
                            } else if (value == AdaptiveThemeMode.dark) {
                              AdaptiveTheme.of(context).setDark();
                            } else {
                              AdaptiveTheme.of(context).setLight();
                            }
                          },
                        ),
                      ),
                      SettingsTile.switchTile(
                        title: 'PDA Mode',
                        leading: const Icon(Icons.qr_code_scanner_rounded),
                        subtitle: 'Honeywell PDAs only',
                        switchValue: true,
                        onToggle: (bool value) {},
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: "App Info",
                    tiles: [
                      SettingsTile(
                        title: 'App Info',
                        leading: const Icon(Icons.info_outline_rounded),
                        onPressed: (BuildContext context) {
                          showAboutDialog(
                              context: context,
                              applicationLegalese: "Licensed under AGPL 3.0",
                              applicationVersion:
                                  "By Eduardo Moreno | eduardom.dev");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
