// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Afiatrade';

  @override
  String get splashTagline => 'Market insight in motion';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageIndonesian => 'Bahasa Indonesia';

  @override
  String get languageSelectorTooltip => 'Change language';

  @override
  String get loginWelcomeTitle => 'Welcome back';

  @override
  String get loginDescription => 'Sign in with the assessment credentials to view the latest forex analysis.';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get signInButton => 'Sign in';

  @override
  String get loginCredentialsHint => 'Use user@test.com / password123';

  @override
  String get authRequiredFields => 'Email and password are required.';

  @override
  String get authInvalidCredentials => 'Invalid email or password.';

  @override
  String get authGeneric => 'Unable to complete login right now.';

  @override
  String get dashboardTitle => 'Afiatrade Pulse';

  @override
  String dashboardSubtitleUpdated(Object time, Object count) {
    return 'Updated $time • $count markets tracked';
  }

  @override
  String get dashboardSubtitleInterrupted => 'Feed interrupted • tap refresh to retry';

  @override
  String get dashboardSubtitleSyncing => 'Syncing live market signals';

  @override
  String get dashboardSubtitleDefault => 'Market dashboard';

  @override
  String get tooltipRefresh => 'Refresh';

  @override
  String get tooltipLogout => 'Logout';

  @override
  String get marketSnapshotTitle => 'Market snapshot';

  @override
  String marketSnapshotSummary(Object activeSignals, Object pairsCount) {
    return '$activeSignals active directional signals across $pairsCount pairs';
  }

  @override
  String get avgRsiLabel => 'Avg RSI';

  @override
  String get strongestSideLabel => 'Strongest side';

  @override
  String get lastUpdateLabel => 'Last update';

  @override
  String get dominantBuyBias => 'BUY bias';

  @override
  String get dominantSellBias => 'SELL bias';

  @override
  String get dominantMixedHold => 'Mixed / hold';

  @override
  String get signalBoardTitle => 'Signal board';

  @override
  String get signalBoardDescription => 'A quick breakdown of the signals already present in the current dashboard snapshot.';

  @override
  String get buySignal => 'Buy';

  @override
  String get sellSignal => 'Sell';

  @override
  String get holdSignal => 'Hold';

  @override
  String get pairsLabel => 'Pairs';

  @override
  String get dashboardLoadingMessage => 'Syncing the latest forex signals...';

  @override
  String get dashboardErrorTitle => 'Feed temporarily unavailable';

  @override
  String get dashboardRetryButton => 'Retry dashboard sync';

  @override
  String get dashboardEmptyTitle => 'No live analysis yet';

  @override
  String get dashboardEmptyDescription => 'Pull to refresh or tap below to check whether the feed has resumed.';

  @override
  String get dashboardCheckAgain => 'Check again';

  @override
  String get dashboardNetwork => 'Check your internet connection and try again.';

  @override
  String get dashboardApi => 'The analysis server is unavailable right now.';

  @override
  String get dashboardParsing => 'Received an unreadable analysis response.';

  @override
  String get dashboardGeneric => 'Something went wrong while loading data.';

  @override
  String get signalDistributionTitle => 'Signal distribution';

  @override
  String get signalDistributionDescription => 'Computed from the current dashboard snapshot.';

  @override
  String get pairsShortLabel => 'pairs';

  @override
  String analysisHeader(Object timeframe, Object updatedAt) {
    return 'Timeframe $timeframe • updated $updatedAt';
  }

  @override
  String get bidLabel => 'Bid';

  @override
  String get askLabel => 'Ask';

  @override
  String get spreadLabel => 'Spread';

  @override
  String get rsiLabel => 'RSI';

  @override
  String get macdHistLabel => 'MACD Hist';

  @override
  String get sma50DriftLabel => 'SMA50 Drift';

  @override
  String get bollingerPosLabel => 'Bollinger Pos';

  @override
  String get positiveMomentum => 'Positive momentum';

  @override
  String get negativeMomentum => 'Negative momentum';

  @override
  String get priceAboveSma50 => 'Price above SMA50';

  @override
  String get priceBelowSma50 => 'Price below SMA50';

  @override
  String get bandPressure => 'Band pressure';

  @override
  String get rsiPulseLabel => 'RSI pulse';

  @override
  String get bollingerPositionLabel => 'Bollinger position';

  @override
  String get signalMatrixTitle => 'Signal matrix';

  @override
  String get signalMaCrossLabel => 'MA Cross';

  @override
  String get signalMaTrendLabel => 'MA Trend';

  @override
  String get signalRsiLabel => 'RSI';

  @override
  String get signalMacdLabel => 'MACD';

  @override
  String get signalBollingerLabel => 'Bollinger';

  @override
  String get tradingSuggestionsTitle => 'Trading suggestions';

  @override
  String get stopLossLabel => 'Stop loss';

  @override
  String get atrTargetLabel => 'ATR target';

  @override
  String get keyLevelLabel => 'Key level';

  @override
  String get dailyRangeLabel => 'Daily range';

  @override
  String get rsiCaptionOverbought => 'Overbought edge';

  @override
  String get rsiCaptionOversold => 'Oversold edge';

  @override
  String get rsiCaptionBalanced => 'Balanced momentum';

  @override
  String get neutralSignal => 'Neutral';

  @override
  String get bullishSignal => 'Bullish';

  @override
  String get bearishSignal => 'Bearish';

  @override
  String get overboughtSignal => 'Overbought';

  @override
  String get oversoldSignal => 'Oversold';
}
