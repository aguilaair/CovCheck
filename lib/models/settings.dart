import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';

class Settings {
  bool isPda;
  bool isPdaModeEnabled;
  bool isDarkMode;
  String locale;

  Settings({
    required this.isPda,
    required this.isPdaModeEnabled,
    required this.isDarkMode,
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

  Settings copyWith({
    bool? isPda,
    bool? isPdaModeEnabled,
    bool? isDarkMode,
    String? locale,
  }) {
    return Settings(
      isPda: isPda ?? this.isPda,
      isPdaModeEnabled: isPdaModeEnabled ?? this.isPdaModeEnabled,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      locale: locale ?? this.locale,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isPda': isPda,
      'isPdaModeEnabled': isPdaModeEnabled,
      'isDarkMode': isDarkMode,
      'locale': locale,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      isPda: map['isPda'] ?? false,
      isPdaModeEnabled: map['isPdaModeEnabled'] ?? false,
      isDarkMode: map['isDarkMode'] ?? false,
      locale: map['locale'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Settings(isPda: $isPda, isPdaModeEnabled: $isPdaModeEnabled, isDarkMode: $isDarkMode, locale: $locale)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Settings &&
        other.isPda == isPda &&
        other.isPdaModeEnabled == isPdaModeEnabled &&
        other.isDarkMode == isDarkMode &&
        other.locale == locale;
  }

  @override
  int get hashCode {
    return isPda.hashCode ^
        isPdaModeEnabled.hashCode ^
        isDarkMode.hashCode ^
        locale.hashCode;
  }
}
