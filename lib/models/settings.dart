import 'package:covid_checker/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';

class Settings {
  bool isPda;
  bool isPdaModeEnabled;
  bool isDarkMode;
  String locale;

  Settings({
    required this.isPda,
    required this.isDarkMode,
    required this.isPdaModeEnabled,
    required this.locale,
  });

  static Future<Settings> getNewSettings(BuildContext ctx) async {
    final isPda = await HoneywellScanner().isSupported();
    final isDarkMode = (Theme.of(ctx).brightness == Brightness.dark);
    final isPdaModeEnabled = isPda;
    final locale = Localizations.localeOf(ctx);
    return Settings(
      isPda: isPda,
      isDarkMode: isDarkMode,
      isPdaModeEnabled: isPdaModeEnabled,
      locale: locale.languageCode,
    );
  }
}
