import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Afiatrade'**
  String get appTitle;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Market insight in motion'**
  String get splashTagline;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageIndonesian.
  ///
  /// In en, this message translates to:
  /// **'Bahasa Indonesia'**
  String get languageIndonesian;

  /// No description provided for @languageSelectorTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get languageSelectorTooltip;

  /// No description provided for @loginWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginWelcomeTitle;

  /// No description provided for @loginDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign in with the assessment credentials to view the latest forex analysis.'**
  String get loginDescription;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInButton;

  /// No description provided for @loginCredentialsHint.
  ///
  /// In en, this message translates to:
  /// **'Use user@test.com / password123'**
  String get loginCredentialsHint;

  /// No description provided for @authRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Email and password are required.'**
  String get authRequiredFields;

  /// No description provided for @authInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get authInvalidCredentials;

  /// No description provided for @authGeneric.
  ///
  /// In en, this message translates to:
  /// **'Unable to complete login right now.'**
  String get authGeneric;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Afiatrade Pulse'**
  String get dashboardTitle;

  /// No description provided for @dashboardSubtitleUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated {time} • {count} markets tracked'**
  String dashboardSubtitleUpdated(Object time, Object count);

  /// No description provided for @dashboardSubtitleInterrupted.
  ///
  /// In en, this message translates to:
  /// **'Feed interrupted • tap refresh to retry'**
  String get dashboardSubtitleInterrupted;

  /// No description provided for @dashboardSubtitleSyncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing live market signals'**
  String get dashboardSubtitleSyncing;

  /// No description provided for @dashboardSubtitleDefault.
  ///
  /// In en, this message translates to:
  /// **'Market dashboard'**
  String get dashboardSubtitleDefault;

  /// No description provided for @tooltipRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get tooltipRefresh;

  /// No description provided for @tooltipLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get tooltipLogout;

  /// No description provided for @marketSnapshotTitle.
  ///
  /// In en, this message translates to:
  /// **'Market snapshot'**
  String get marketSnapshotTitle;

  /// No description provided for @marketSnapshotSummary.
  ///
  /// In en, this message translates to:
  /// **'{activeSignals} active directional signals across {pairsCount} pairs'**
  String marketSnapshotSummary(Object activeSignals, Object pairsCount);

  /// No description provided for @avgRsiLabel.
  ///
  /// In en, this message translates to:
  /// **'Avg RSI'**
  String get avgRsiLabel;

  /// No description provided for @strongestSideLabel.
  ///
  /// In en, this message translates to:
  /// **'Strongest side'**
  String get strongestSideLabel;

  /// No description provided for @lastUpdateLabel.
  ///
  /// In en, this message translates to:
  /// **'Last update'**
  String get lastUpdateLabel;

  /// No description provided for @dominantBuyBias.
  ///
  /// In en, this message translates to:
  /// **'BUY bias'**
  String get dominantBuyBias;

  /// No description provided for @dominantSellBias.
  ///
  /// In en, this message translates to:
  /// **'SELL bias'**
  String get dominantSellBias;

  /// No description provided for @dominantMixedHold.
  ///
  /// In en, this message translates to:
  /// **'Mixed / hold'**
  String get dominantMixedHold;

  /// No description provided for @signalBoardTitle.
  ///
  /// In en, this message translates to:
  /// **'Signal board'**
  String get signalBoardTitle;

  /// No description provided for @signalBoardDescription.
  ///
  /// In en, this message translates to:
  /// **'A quick breakdown of the signals already present in the current dashboard snapshot.'**
  String get signalBoardDescription;

  /// No description provided for @buySignal.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buySignal;

  /// No description provided for @sellSignal.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get sellSignal;

  /// No description provided for @holdSignal.
  ///
  /// In en, this message translates to:
  /// **'Hold'**
  String get holdSignal;

  /// No description provided for @pairsLabel.
  ///
  /// In en, this message translates to:
  /// **'Pairs'**
  String get pairsLabel;

  /// No description provided for @dashboardLoadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Syncing the latest forex signals...'**
  String get dashboardLoadingMessage;

  /// No description provided for @dashboardErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Feed temporarily unavailable'**
  String get dashboardErrorTitle;

  /// No description provided for @dashboardRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry dashboard sync'**
  String get dashboardRetryButton;

  /// No description provided for @dashboardEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No live analysis yet'**
  String get dashboardEmptyTitle;

  /// No description provided for @dashboardEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh or tap below to check whether the feed has resumed.'**
  String get dashboardEmptyDescription;

  /// No description provided for @dashboardCheckAgain.
  ///
  /// In en, this message translates to:
  /// **'Check again'**
  String get dashboardCheckAgain;

  /// No description provided for @dashboardNetwork.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection and try again.'**
  String get dashboardNetwork;

  /// No description provided for @dashboardApi.
  ///
  /// In en, this message translates to:
  /// **'The analysis server is unavailable right now.'**
  String get dashboardApi;

  /// No description provided for @dashboardParsing.
  ///
  /// In en, this message translates to:
  /// **'Received an unreadable analysis response.'**
  String get dashboardParsing;

  /// No description provided for @dashboardGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while loading data.'**
  String get dashboardGeneric;

  /// No description provided for @signalDistributionTitle.
  ///
  /// In en, this message translates to:
  /// **'Signal distribution'**
  String get signalDistributionTitle;

  /// No description provided for @signalDistributionDescription.
  ///
  /// In en, this message translates to:
  /// **'Computed from the current dashboard snapshot.'**
  String get signalDistributionDescription;

  /// No description provided for @pairsShortLabel.
  ///
  /// In en, this message translates to:
  /// **'pairs'**
  String get pairsShortLabel;

  /// No description provided for @analysisHeader.
  ///
  /// In en, this message translates to:
  /// **'Timeframe {timeframe} • updated {updatedAt}'**
  String analysisHeader(Object timeframe, Object updatedAt);

  /// No description provided for @bidLabel.
  ///
  /// In en, this message translates to:
  /// **'Bid'**
  String get bidLabel;

  /// No description provided for @askLabel.
  ///
  /// In en, this message translates to:
  /// **'Ask'**
  String get askLabel;

  /// No description provided for @spreadLabel.
  ///
  /// In en, this message translates to:
  /// **'Spread'**
  String get spreadLabel;

  /// No description provided for @rsiLabel.
  ///
  /// In en, this message translates to:
  /// **'RSI'**
  String get rsiLabel;

  /// No description provided for @macdHistLabel.
  ///
  /// In en, this message translates to:
  /// **'MACD Hist'**
  String get macdHistLabel;

  /// No description provided for @sma50DriftLabel.
  ///
  /// In en, this message translates to:
  /// **'SMA50 Drift'**
  String get sma50DriftLabel;

  /// No description provided for @bollingerPosLabel.
  ///
  /// In en, this message translates to:
  /// **'Bollinger Pos'**
  String get bollingerPosLabel;

  /// No description provided for @positiveMomentum.
  ///
  /// In en, this message translates to:
  /// **'Positive momentum'**
  String get positiveMomentum;

  /// No description provided for @negativeMomentum.
  ///
  /// In en, this message translates to:
  /// **'Negative momentum'**
  String get negativeMomentum;

  /// No description provided for @priceAboveSma50.
  ///
  /// In en, this message translates to:
  /// **'Price above SMA50'**
  String get priceAboveSma50;

  /// No description provided for @priceBelowSma50.
  ///
  /// In en, this message translates to:
  /// **'Price below SMA50'**
  String get priceBelowSma50;

  /// No description provided for @bandPressure.
  ///
  /// In en, this message translates to:
  /// **'Band pressure'**
  String get bandPressure;

  /// No description provided for @rsiPulseLabel.
  ///
  /// In en, this message translates to:
  /// **'RSI pulse'**
  String get rsiPulseLabel;

  /// No description provided for @bollingerPositionLabel.
  ///
  /// In en, this message translates to:
  /// **'Bollinger position'**
  String get bollingerPositionLabel;

  /// No description provided for @signalMatrixTitle.
  ///
  /// In en, this message translates to:
  /// **'Signal matrix'**
  String get signalMatrixTitle;

  /// No description provided for @signalMaCrossLabel.
  ///
  /// In en, this message translates to:
  /// **'MA Cross'**
  String get signalMaCrossLabel;

  /// No description provided for @signalMaTrendLabel.
  ///
  /// In en, this message translates to:
  /// **'MA Trend'**
  String get signalMaTrendLabel;

  /// No description provided for @signalRsiLabel.
  ///
  /// In en, this message translates to:
  /// **'RSI'**
  String get signalRsiLabel;

  /// No description provided for @signalMacdLabel.
  ///
  /// In en, this message translates to:
  /// **'MACD'**
  String get signalMacdLabel;

  /// No description provided for @signalBollingerLabel.
  ///
  /// In en, this message translates to:
  /// **'Bollinger'**
  String get signalBollingerLabel;

  /// No description provided for @tradingSuggestionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Trading suggestions'**
  String get tradingSuggestionsTitle;

  /// No description provided for @stopLossLabel.
  ///
  /// In en, this message translates to:
  /// **'Stop loss'**
  String get stopLossLabel;

  /// No description provided for @atrTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'ATR target'**
  String get atrTargetLabel;

  /// No description provided for @keyLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Key level'**
  String get keyLevelLabel;

  /// No description provided for @dailyRangeLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily range'**
  String get dailyRangeLabel;

  /// No description provided for @rsiCaptionOverbought.
  ///
  /// In en, this message translates to:
  /// **'Overbought edge'**
  String get rsiCaptionOverbought;

  /// No description provided for @rsiCaptionOversold.
  ///
  /// In en, this message translates to:
  /// **'Oversold edge'**
  String get rsiCaptionOversold;

  /// No description provided for @rsiCaptionBalanced.
  ///
  /// In en, this message translates to:
  /// **'Balanced momentum'**
  String get rsiCaptionBalanced;

  /// No description provided for @neutralSignal.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get neutralSignal;

  /// No description provided for @bullishSignal.
  ///
  /// In en, this message translates to:
  /// **'Bullish'**
  String get bullishSignal;

  /// No description provided for @bearishSignal.
  ///
  /// In en, this message translates to:
  /// **'Bearish'**
  String get bearishSignal;

  /// No description provided for @overboughtSignal.
  ///
  /// In en, this message translates to:
  /// **'Overbought'**
  String get overboughtSignal;

  /// No description provided for @oversoldSignal.
  ///
  /// In en, this message translates to:
  /// **'Oversold'**
  String get oversoldSignal;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'id': return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
