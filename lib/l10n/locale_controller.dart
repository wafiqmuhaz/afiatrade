import 'package:flutter/material.dart';

import '../services/session_service.dart';

class LocaleController extends ChangeNotifier {
  LocaleController({required SessionService sessionService})
    : _sessionService = sessionService;

  final SessionService _sessionService;

  Locale? _locale;
  Locale? get locale => _locale;

  Future<void> loadPreferredLocale() async {
    final String? storedLocale = await _sessionService.getLocaleCode();
    if (storedLocale == null || storedLocale.isEmpty) {
      return;
    }

    _locale = Locale(storedLocale);
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale?.languageCode == locale.languageCode) {
      return;
    }

    _locale = locale;
    await _sessionService.setLocaleCode(locale.languageCode);
    notifyListeners();
  }
}
