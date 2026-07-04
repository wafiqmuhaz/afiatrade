import 'package:flutter/widgets.dart';

class L10n {
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  static Locale fallbackLocale(Locale? locale) {
    if (locale != null) {
      for (final Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return supportedLocale;
        }
      }
    }

    return const Locale('en');
  }
}
