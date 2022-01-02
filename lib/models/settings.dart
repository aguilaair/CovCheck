import 'dart:convert';

import 'package:covid_checker/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';
import 'package:universal_io/io.dart';

class Settings {
  bool isPda;
  bool isPdaModeEnabled;
  bool isHoneywellPda;
  String locale;

  Settings({
    required this.isPda,
    required this.isPdaModeEnabled,
    required this.isHoneywellPda,
    required this.locale,
  });

  static Future<Settings> getNewSettings(BuildContext ctx) async {
    final isHoneywellPda = (Platform.isAndroid && !kIsWeb)
        ? await HoneywellScanner().isSupported()
        : false;
    final isPda =
        isHoneywellPda; // We can only autodetect Honeywell PDAs, so we will assume.
    final isPdaModeEnabled = isPda;
    final langCode = Locale(Platform.localeName.split("-").first);
    final locale =
        S.delegate.isSupported(langCode) ? langCode : const Locale('en');
    final newInstance = Settings(
      isPda: isPda,
      isPdaModeEnabled: isPdaModeEnabled,
      isHoneywellPda: isHoneywellPda,
      locale: locale.languageCode,
    );
    return newInstance;
  }

  Settings copyWith({
    bool? isPda,
    bool? isPdaModeEnabled,
    bool? isHoneywellPda,
    String? locale,
  }) {
    return Settings(
      isPda: isPda ?? this.isPda,
      isPdaModeEnabled: isPdaModeEnabled ?? this.isPdaModeEnabled,
      isHoneywellPda: isHoneywellPda ?? this.isHoneywellPda,
      locale: locale ?? this.locale,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isPda': isPda,
      'isPdaModeEnabled': isPdaModeEnabled,
      'isHoneywellPda': isHoneywellPda,
      'locale': locale,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      isPda: map['isPda'] ?? false,
      isPdaModeEnabled: map['isPdaModeEnabled'] ?? false,
      isHoneywellPda: map['isHoneywellPda'] ?? false,
      locale: map['locale'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Settings(isPda: $isPda, isPdaModeEnabled: $isPdaModeEnabled, isHoneywellPda: $isHoneywellPda, locale: $locale)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Settings &&
        other.isPda == isPda &&
        other.isPdaModeEnabled == isPdaModeEnabled &&
        other.isHoneywellPda == isHoneywellPda &&
        other.locale == locale;
  }

  @override
  int get hashCode {
    return isPda.hashCode ^
        isPdaModeEnabled.hashCode ^
        isHoneywellPda.hashCode ^
        locale.hashCode;
  }
}
