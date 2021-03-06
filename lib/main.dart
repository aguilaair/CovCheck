import 'package:covid_checker/utils/gen_swatch.dart';
import 'package:covid_checker/screens/main_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('certs');
  runApp(const CovCheckApp());
}

class CovCheckApp extends StatefulWidget {
  const CovCheckApp({Key? key}) : super(key: key);

  @override
  State<CovCheckApp> createState() => _CovCheckAppState();
}

class _CovCheckAppState extends State<CovCheckApp> {
  Locale? locale;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData(
          primarySwatch: createMaterialColor(const Color(0xFF262DC9)),
          primaryColor: const Color(0xFF262DC9),
          backgroundColor: const Color(0xffECEEFF),
        ),
        dark: ThemeData.dark().copyWith(
          backgroundColor: const Color(0xff080B27),
          cardColor: const Color(0xff050612),
          primaryColor: const Color(0xFF262DC9),
          primaryColorDark: const Color(0xFF262DC9),
        ),
        initial: AdaptiveThemeMode.system,
        builder: (theme, darkTheme) {
          return MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: locale,
            title: 'CovCheck',
            theme: theme,
            darkTheme: darkTheme,
            home: MyHomePage(setLocale: setLocale),
          );
        });
  }

  void setLocale(Locale newLocale, {bool shouldSetState = true}) {
    locale = newLocale;
    if (shouldSetState && mounted) setState(() {});
  }
}
