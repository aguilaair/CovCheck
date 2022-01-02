import 'dart:convert';

import 'package:covid_checker/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';
import 'package:universal_io/io.dart';

class Settings {
  bool isPda;
  bool isPdaModeEnabled;
  bool isHoneywellSupported;
  bool isCameraSupported;
  String locale;

  Settings({
    required this.isPda,
    required this.isPdaModeEnabled,
    required this.isHoneywellSupported,
    required this.isCameraSupported,
    required this.locale,
  });

  static Future<Settings> getNewSettings(BuildContext ctx) async {
    final isHoneywellSupported = (Platform.isAndroid && !kIsWeb)
        ? await HoneywellScanner().isSupported()
        : false;
    final isPda =
        isHoneywellSupported; // We can only autodetect Honeywell PDAs, so we will assume.
    final langCode = Locale(Platform.localeName.split("-").first);
    final locale =
        S.delegate.isSupported(langCode) ? langCode : const Locale('en');
    final isCameraSupported = (Platform.isAndroid || Platform.isIOS || kIsWeb);
    final isPdaModeEnabled = !isCameraSupported;
    final newInstance = Settings(
      isPda: isPda,
      isPdaModeEnabled: isPdaModeEnabled,
      isHoneywellSupported: isHoneywellSupported,
      isCameraSupported: isCameraSupported,
      locale: locale.languageCode,
    );
    return newInstance;
  }

  Settings copyWith({
    bool? isPda,
    bool? isPdaModeEnabled,
    bool? isHoneywellSupported,
    bool? isCameraSupported,
    String? locale,
  }) {
    return Settings(
      isPda: isPda ?? this.isPda,
      isPdaModeEnabled: isPdaModeEnabled ?? this.isPdaModeEnabled,
      isHoneywellSupported: isHoneywellSupported ?? this.isHoneywellSupported,
      isCameraSupported: isCameraSupported ?? this.isCameraSupported,
      locale: locale ?? this.locale,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isPda': isPda,
      'isPdaModeEnabled': isPdaModeEnabled,
      'isHoneywellSupported': isHoneywellSupported,
      'isCameraSupported': isCameraSupported,
      'locale': locale,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      isPda: map['isPda'] ?? false,
      isPdaModeEnabled: map['isPdaModeEnabled'] ??
          !(Platform.isAndroid || Platform.isIOS || kIsWeb),
      isHoneywellSupported: map['isHoneywellSupported'] ?? false,
      isCameraSupported: map['isCameraSupported'] ??
          (Platform.isAndroid || Platform.isIOS || kIsWeb),
      locale: map['locale'] ?? 'en',
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Settings(isPda: $isPda, isPdaModeEnabled: $isPdaModeEnabled, isHoneywellSupported: $isHoneywellSupported, isCameraSupported: $isCameraSupported, locale: $locale)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Settings &&
        other.isPda == isPda &&
        other.isPdaModeEnabled == isPdaModeEnabled &&
        other.isHoneywellSupported == isHoneywellSupported &&
        other.isCameraSupported == isCameraSupported &&
        other.locale == locale;
  }

  @override
  int get hashCode {
    return isPda.hashCode ^
        isPdaModeEnabled.hashCode ^
        isHoneywellSupported.hashCode ^
        isCameraSupported.hashCode ^
        locale.hashCode;
  }
}
