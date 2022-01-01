import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';

class Settings {
  bool isPda;
  bool isPdaModeEnabled;
  String locale;

  Settings({
    required this.isPda,
    required this.isPdaModeEnabled,
    required this.locale,
  });

  static Future<Settings> getNewSettings(BuildContext ctx) async {
    final isPda = (Platform.isAndroid && !kIsWeb)
        ? await HoneywellScanner().isSupported()
        : false;
    final isPdaModeEnabled = isPda;
    final locale = Localizations.localeOf(ctx);
    final newInstance = Settings(
      isPda: isPda,
      isPdaModeEnabled: isPdaModeEnabled,
      locale: locale.languageCode,
    );
    return newInstance;
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
      locale: locale ?? this.locale,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isPda': isPda,
      'isPdaModeEnabled': isPdaModeEnabled,
      'locale': locale,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      isPda: map['isPda'] ?? false,
      isPdaModeEnabled: map['isPdaModeEnabled'] ?? false,
      locale: map['locale'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Settings(isPda: $isPda, isPdaModeEnabled: $isPdaModeEnabled, locale: $locale)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Settings &&
        other.isPda == isPda &&
        other.isPdaModeEnabled == isPdaModeEnabled &&
        other.locale == locale;
  }

  @override
  int get hashCode {
    return isPda.hashCode ^ isPdaModeEnabled.hashCode ^ locale.hashCode;
  }
}
