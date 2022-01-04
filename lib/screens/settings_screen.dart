import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:covid_checker/generated/l10n.dart';
import 'package:covid_checker/utils/get_new_certs.dart';
import 'package:covid_checker/widgets/molecules/logo.dart';
import 'package:covid_checker/widgets/molecules/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:intl/intl.dart';

import '../models/settings.dart';

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
  Settings? newSettings;
  bool downloading = false;
  @override
  Widget build(BuildContext context) {
    newSettings ??= widget.settings;
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
                physics: const BouncingScrollPhysics(),
                backgroundColor: Theme.of(context).backgroundColor,
                sections: [
                  SettingsSection(
                    platform: TargetPlatform.android,
                    title: S.of(context).appsettings,
                    tiles: [
                      SettingsTile(
                        title: S.of(context).language,
                        leading: const Icon(Icons.language_rounded),
                        trailing: DropdownButton(
                          items: S.delegate.supportedLocales.map((element) {
                            return DropdownMenuItem(
                              child: Text(element.languageCode),
                              value: element.languageCode,
                            );
                          }).toList(),
                          value: newSettings!.locale,
                          onChanged: (String? value) {
                            if (S.delegate.isSupported(Locale(value!))) {
                              newSettings =
                                  newSettings!.copyWith(locale: value);
                              widget.updateSettings(
                                newSettings!.copyWith(locale: value),
                              );
                            }
                          },
                        ),
                      ),
                      SettingsTile(
                        title: S.of(context).theme,
                        leading: Icon(AdaptiveTheme.of(context).mode ==
                                AdaptiveThemeMode.light
                            ? Icons.light_mode_rounded
                            : AdaptiveTheme.of(context).mode ==
                                    AdaptiveThemeMode.system
                                ? Icons.auto_awesome
                                : Icons.dark_mode_rounded),
                        trailing: DropdownButton(
                          items: [
                            DropdownMenuItem(
                              child: Text(S.of(context).light),
                              value: AdaptiveThemeMode.light,
                            ),
                            DropdownMenuItem(
                              child: Text(S.of(context).dark),
                              value: AdaptiveThemeMode.dark,
                            ),
                            DropdownMenuItem(
                              child: Text(S.of(context).system),
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
                        title: S.of(context).pdamode,
                        leading: const Icon(Icons.qr_code_scanner_rounded),
                        subtitle: S.of(context).pdamodedesc,
                        switchValue: newSettings!.isPda,
                        onToggle: (bool value) {
                          if (!(newSettings?.isCameraSupported ?? false)) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(S.of(context).notsupported),
                            ));
                          } else {
                            setState(() {
                              newSettings = newSettings!.copyWith(isPda: value);
                              widget.updateSettings(
                                newSettings!.copyWith(isPda: value),
                              );
                            });
                          }
                        },
                      ),
                      SettingsTile(
                        title: S.of(context).honeywellpda,
                        leading: const Icon(Icons.h_plus_mobiledata_rounded),
                        subtitle: (newSettings?.isHoneywellSupported ?? false)
                            ? S.of(context).supported
                            : S.of(context).notsupported,
                      ),
                      SettingsTile(
                        title: S.of(context).camerasupport,
                        leading: const Icon(Icons.camera_alt_rounded),
                        subtitle: (newSettings?.isCameraSupported ?? false)
                            ? S.of(context).supported
                            : S.of(context).notsupported,
                      ),
                      SettingsTile(
                        title: S.of(context).appinfo,
                        leading: const Icon(Icons.info_outline_rounded),
                        onPressed: (BuildContext context) {
                          showAboutDialog(
                            context: context,
                            applicationLegalese: "Licensed under AGPL 3.0",
                            applicationVersion:
                                "By Eduardo Moreno | eduardom.dev",
                          );
                        },
                      ),
                      SettingsTile(
                        title: S.of(context).resetsettings,
                        leading: const Icon(Icons.restore_rounded),
                        trailing: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      S.of(context).areyousurereset,
                                    ),
                                    title: Text(S.of(context).resetsettings),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(S.of(context).cancel),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          AdaptiveTheme.of(context).setSystem();
                                          newSettings =
                                              await Settings.getNewSettings(
                                                  context);
                                          widget.updateSettings(newSettings!);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(S.of(context).reset),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(S.of(context).reset)),
                      ),
                    ],
                  ),
                  SettingsSection(
                    titlePadding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    subtitlePadding: const EdgeInsets.only(left: 15, right: 15),
                    platform: TargetPlatform.android,
                    title: S.of(context).infocertssection,
                    subtitle: Row(
                      children: [
                        Flexible(
                          child: Text(
                            S.of(context).certsettingssubtitle,
                            maxLines: 20,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 13),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: !downloading
                              ? () async {
                                  setState(() {
                                    downloading = true;
                                  });
                                  try {
                                    progressSnackbar(context, 0, 4);
                                    await getNewCerts();
                                    progressSnackbar(context, 1, 4);
                                    await getNewTests();
                                    progressSnackbar(context, 2, 4);
                                    await getNewVaccineAuthHolders();
                                    progressSnackbar(context, 3, 4);
                                    await getNewVaccines();
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    successSnackbar(context);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    successSnackbar(context);
                                    errorSnackbar(context);
                                  }
                                  setState(() {
                                    downloading = false;
                                  });
                                }
                              : null,
                          child: Text(S.of(context).updateall),
                        ),
                      ],
                    ),
                    tiles: [
                      SettingsTile(
                        title: S.of(context).lastcertupdate,
                        leading: const Icon(Icons.shield_rounded),
                        subtitleMaxLines: 10,
                        subtitle: DateFormat.yMMMMd(
                                Localizations.localeOf(context).countryCode)
                            .add_jms()
                            .format(
                              Hive.box("certs").get(
                                "certs_iat",
                                defaultValue: DateTime(2000),
                              ),
                            ),
                        trailing: TextButton(
                          child: Text(S.of(context).update),
                          onPressed: !downloading
                              ? () async {
                                  setState(() {
                                    downloading = true;
                                  });
                                  try {
                                    await getNewCerts();
                                    successSnackbar(context);
                                  } catch (e) {
                                    errorSnackbar(context);
                                  }
                                  setState(() {
                                    downloading = false;
                                  });
                                }
                              : null,
                        ),
                      ),
                      SettingsTile(
                        title: S.of(context).lasttestupdate,
                        leading: const Icon(Icons.animation_rounded),
                        subtitleMaxLines: 10,
                        subtitle: DateFormat.yMMMMd(
                                Localizations.localeOf(context).countryCode)
                            .format(
                          DateTime.parse(Hive.box("certs")
                              .get("tests")['valueSetDate'] as String),
                        ),
                        trailing: TextButton(
                            child: Text(S.of(context).update),
                            onPressed: !downloading
                                ? () async {
                                    setState(() {
                                      downloading = true;
                                    });
                                    try {
                                      await getNewTests();
                                      successSnackbar(context);
                                    } catch (e) {
                                      errorSnackbar(context);
                                    }
                                    setState(() {
                                      downloading = false;
                                    });
                                  }
                                : null),
                      ),
                      SettingsTile(
                        title: S.of(context).lastvaxupdate,
                        leading: const Icon(Icons.business_center_rounded),
                        subtitleMaxLines: 10,
                        subtitle: DateFormat.yMMMMd(
                                Localizations.localeOf(context).countryCode)
                            .format(
                          DateTime.parse(Hive.box("certs").get(
                                  "vaccine-medicinal-product")['valueSetDate']
                              as String),
                        ),
                        trailing: TextButton(
                          child: Text(S.of(context).update),
                          onPressed: !downloading
                              ? () async {
                                  setState(() {
                                    downloading = true;
                                  });
                                  try {
                                    await getNewVaccines();
                                    successSnackbar(context);
                                  } catch (e) {
                                    errorSnackbar(context);
                                  }
                                  setState(() {
                                    downloading = false;
                                  });
                                }
                              : null,
                        ),
                      ),
                      SettingsTile(
                        title: S.of(context).lastauthholderupdate,
                        leading: const Icon(Icons.business_rounded),
                        subtitleMaxLines: 10,
                        subtitle: DateFormat.yMMMMd(
                                Localizations.localeOf(context).countryCode)
                            .format(
                          DateTime.parse(Hive.box("certs")
                                  .get("vaccines-covid-19-auth-holders")[
                              'valueSetDate'] as String),
                        ),
                        trailing: TextButton(
                          child: Text(S.of(context).update),
                          onPressed: !downloading
                              ? () async {
                                  setState(() {
                                    downloading = true;
                                  });
                                  try {
                                    await getNewVaccineAuthHolders();
                                    successSnackbar(context);
                                  } catch (e) {
                                    errorSnackbar(context);
                                  }
                                  setState(() {
                                    downloading = false;
                                  });
                                }
                              : null,
                        ),
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
