import 'package:flutter/widgets.dart';

import '../models/enums.dart';
import 'app_localizations.dart';
import 'app_message_keys.dart';

extension AppLocalizationsContextX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension AppLocalizationsX on AppLocalizations {
  String errorForKey(String key) {
    return switch (key) {
      AppMessageKeys.authRequiredFields => authRequiredFields,
      AppMessageKeys.authInvalidCredentials => authInvalidCredentials,
      AppMessageKeys.authGeneric => authGeneric,
      AppMessageKeys.dashboardNetwork => dashboardNetwork,
      AppMessageKeys.dashboardApi => dashboardApi,
      AppMessageKeys.dashboardParsing => dashboardParsing,
      AppMessageKeys.dashboardGeneric => dashboardGeneric,
      _ => key,
    };
  }

  String recommendationLabel(Recommendation recommendation) {
    return switch (recommendation) {
      Recommendation.buy => buySignal,
      Recommendation.sell => sellSignal,
      Recommendation.neutral => holdSignal,
    };
  }

  String signalValueLabel(String rawValue) {
    return switch (rawValue.toLowerCase()) {
      'buy' => buySignal,
      'sell' => sellSignal,
      'neutral' => neutralSignal,
      'bullish' => bullishSignal,
      'bearish' => bearishSignal,
      'overbought' => overboughtSignal,
      'oversold' => oversoldSignal,
      _ => rawValue.toUpperCase(),
    };
  }
}
