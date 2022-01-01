import 'package:covid_checker/utils/gen_swatch.dart';
import 'package:covid_checker/widgets/main_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
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
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xFF262DC9)),
        primaryColor: const Color(0xFF262DC9),
        backgroundColor: const Color(0xffECEEFF),
      ),
      darkTheme: ThemeData.dark().copyWith(
        backgroundColor: const Color(0xff080B27),
        cardColor: const Color(0xff050612),
        primaryColor: const Color(0xFF262DC9),
        primaryColorDark: const Color(0xFF262DC9),
      ),
      home: MyHomePage(setLocale: setLocale),
    );
  }

  void setLocale(Locale newLocale) {
    setState(() {
      locale = newLocale;
    });
  }
}
