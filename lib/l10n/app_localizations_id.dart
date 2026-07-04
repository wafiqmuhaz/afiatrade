// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Afiatrade';

  @override
  String get splashTagline => 'Wawasan pasar yang terus bergerak';

  @override
  String get languageEnglish => 'Inggris';

  @override
  String get languageIndonesian => 'Bahasa Indonesia';

  @override
  String get languageSelectorTooltip => 'Ganti bahasa';

  @override
  String get loginWelcomeTitle => 'Selamat datang kembali';

  @override
  String get loginDescription => 'Masuk dengan kredensial asesmen untuk melihat analisis forex terbaru.';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Kata sandi';

  @override
  String get signInButton => 'Masuk';

  @override
  String get loginCredentialsHint => 'Gunakan user@test.com / password123';

  @override
  String get authRequiredFields => 'Email dan kata sandi wajib diisi.';

  @override
  String get authInvalidCredentials => 'Email atau kata sandi tidak valid.';

  @override
  String get authGeneric => 'Login belum dapat diproses saat ini.';

  @override
  String get dashboardTitle => 'Denyut Afiatrade';

  @override
  String dashboardSubtitleUpdated(Object time, Object count) {
    return 'Diperbarui $time • $count pasar dipantau';
  }

  @override
  String get dashboardSubtitleInterrupted => 'Umpan terputus • tekan segarkan untuk mencoba lagi';

  @override
  String get dashboardSubtitleSyncing => 'Menyelaraskan sinyal pasar terbaru';

  @override
  String get dashboardSubtitleDefault => 'Dashboard pasar';

  @override
  String get tooltipRefresh => 'Segarkan';

  @override
  String get tooltipLogout => 'Keluar';

  @override
  String get marketSnapshotTitle => 'Ringkasan pasar';

  @override
  String marketSnapshotSummary(Object activeSignals, Object pairsCount) {
    return '$activeSignals sinyal arah aktif di $pairsCount pasangan';
  }

  @override
  String get avgRsiLabel => 'Rata-rata RSI';

  @override
  String get strongestSideLabel => 'Arah terkuat';

  @override
  String get lastUpdateLabel => 'Pembaruan terakhir';

  @override
  String get dominantBuyBias => 'Bias BELI';

  @override
  String get dominantSellBias => 'Bias JUAL';

  @override
  String get dominantMixedHold => 'Campuran / tahan';

  @override
  String get signalBoardTitle => 'Papan sinyal';

  @override
  String get signalBoardDescription => 'Ringkasan cepat dari sinyal yang ada pada snapshot dashboard saat ini.';

  @override
  String get buySignal => 'Beli';

  @override
  String get sellSignal => 'Jual';

  @override
  String get holdSignal => 'Tahan';

  @override
  String get pairsLabel => 'Pasangan';

  @override
  String get dashboardLoadingMessage => 'Menyelaraskan sinyal forex terbaru...';

  @override
  String get dashboardErrorTitle => 'Umpan sementara tidak tersedia';

  @override
  String get dashboardRetryButton => 'Coba sinkronkan lagi';

  @override
  String get dashboardEmptyTitle => 'Belum ada analisis live';

  @override
  String get dashboardEmptyDescription => 'Tarik untuk menyegarkan atau tekan tombol di bawah untuk mengecek apakah feed sudah kembali.';

  @override
  String get dashboardCheckAgain => 'Cek lagi';

  @override
  String get dashboardNetwork => 'Periksa koneksi internet Anda lalu coba lagi.';

  @override
  String get dashboardApi => 'Server analisis sedang tidak tersedia saat ini.';

  @override
  String get dashboardParsing => 'Respons analisis yang diterima tidak dapat dibaca.';

  @override
  String get dashboardGeneric => 'Terjadi masalah saat memuat data.';

  @override
  String get signalDistributionTitle => 'Distribusi sinyal';

  @override
  String get signalDistributionDescription => 'Dihitung dari snapshot dashboard saat ini.';

  @override
  String get pairsShortLabel => 'pair';

  @override
  String analysisHeader(Object timeframe, Object updatedAt) {
    return 'Timeframe $timeframe • diperbarui $updatedAt';
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
  String get macdHistLabel => 'Hist MACD';

  @override
  String get sma50DriftLabel => 'Drift SMA50';

  @override
  String get bollingerPosLabel => 'Posisi Bollinger';

  @override
  String get positiveMomentum => 'Momentum positif';

  @override
  String get negativeMomentum => 'Momentum negatif';

  @override
  String get priceAboveSma50 => 'Harga di atas SMA50';

  @override
  String get priceBelowSma50 => 'Harga di bawah SMA50';

  @override
  String get bandPressure => 'Tekanan band';

  @override
  String get rsiPulseLabel => 'Denyut RSI';

  @override
  String get bollingerPositionLabel => 'Posisi Bollinger';

  @override
  String get signalMatrixTitle => 'Matriks sinyal';

  @override
  String get signalMaCrossLabel => 'Persilangan MA';

  @override
  String get signalMaTrendLabel => 'Tren MA';

  @override
  String get signalRsiLabel => 'RSI';

  @override
  String get signalMacdLabel => 'MACD';

  @override
  String get signalBollingerLabel => 'Bollinger';

  @override
  String get tradingSuggestionsTitle => 'Saran trading';

  @override
  String get stopLossLabel => 'Stop loss';

  @override
  String get atrTargetLabel => 'Target ATR';

  @override
  String get keyLevelLabel => 'Level kunci';

  @override
  String get dailyRangeLabel => 'Rentang harian';

  @override
  String get rsiCaptionOverbought => 'Area jenuh beli';

  @override
  String get rsiCaptionOversold => 'Area jenuh jual';

  @override
  String get rsiCaptionBalanced => 'Momentum seimbang';

  @override
  String get neutralSignal => 'Netral';

  @override
  String get bullishSignal => 'Bullish';

  @override
  String get bearishSignal => 'Bearish';

  @override
  String get overboughtSignal => 'Jenuh beli';

  @override
  String get oversoldSignal => 'Jenuh jual';
}
