import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/home_page_localizations.dart';

class I18n {
  static final all = [
    const Locale('en'),
    const Locale('th'),
  ];
}

class AppLocalizations {
  final BuildContext context;
  static List<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        HomePageLocalizations.delegate,
      ];
  AppLocalizations(this.context);

  // Get HomePageLocalizations
  HomePageLocalizations get homePage => HomePageLocalizations.of(context)!;
}
