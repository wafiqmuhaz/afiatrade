import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations_x.dart';
import '../../../models/analysis_response.dart';
import '../../../models/enums.dart';
import '../../../theme/app_colors.dart';

class AnalysisCard extends StatelessWidget {
  const AnalysisCard({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final Analysis analysis = message.analysis;
    final TradingSuggestions? suggestions = analysis.tradingSuggestions;
    final _SignalPalette palette = _SignalPalette.fromRecommendation(
      analysis.recommendation,
    );
    final l10n = context.l10n;
    final String localeName = Localizations.localeOf(context).toLanguageTag();
    final NumberFormat compactTwo = NumberFormat.decimalPatternDigits(
      locale: localeName,
      decimalDigits: 2,
    );
    final NumberFormat fixedFour = NumberFormat.decimalPatternDigits(
      locale: localeName,
      decimalDigits: 4,
    );
    final NumberFormat fixedFive = NumberFormat.decimalPatternDigits(
      locale: localeName,
      decimalDigits: 5,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.97),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[palette.softColor, AppColors.surface],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              message.symbol,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.analysisHeader(
                                message.timeframe.apiValue,
                                _formatTime(analysis.lastUpdate, localeName),
                              ),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      _RecommendationBadge(
                        label: l10n
                            .recommendationLabel(analysis.recommendation)
                            .toUpperCase(),
                        palette: palette,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _PriceBlock(
                          label: l10n.bidLabel,
                          value: fixedFive.format(analysis.currentPrice.bid),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _PriceBlock(
                          label: l10n.askLabel,
                          value: fixedFive.format(analysis.currentPrice.ask),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _PriceBlock(
                          label: l10n.spreadLabel,
                          value: NumberFormat.decimalPattern(
                            localeName,
                          ).format(analysis.currentPrice.spread),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: <Widget>[
                _MetricTile(
                  label: l10n.rsiLabel,
                  value: compactTwo.format(analysis.indicators.rsi),
                  caption: _rsiCaption(context, analysis.indicators.rsi),
                ),
                _MetricTile(
                  label: l10n.macdHistLabel,
                  value: fixedFive.format(analysis.indicators.macd.histogram),
                  caption: analysis.indicators.macd.histogram >= 0
                      ? l10n.positiveMomentum
                      : l10n.negativeMomentum,
                ),
                _MetricTile(
                  label: l10n.sma50DriftLabel,
                  value: fixedFour.format(
                    analysis.indicators.movingAverages.priceVsSma50,
                  ),
                  caption: analysis.indicators.movingAverages.priceVsSma50 >= 0
                      ? l10n.priceAboveSma50
                      : l10n.priceBelowSma50,
                ),
                _MetricTile(
                  label: l10n.bollingerPosLabel,
                  value: compactTwo.format(
                    analysis.indicators.bollingerBands.pricePosition,
                  ),
                  caption: l10n.bandPressure,
                ),
              ],
            ),
            const SizedBox(height: 18),
            _IndicatorBar(
              label: l10n.rsiPulseLabel,
              value: analysis.indicators.rsi / 100,
              valueText: compactTwo.format(analysis.indicators.rsi),
              color: palette.color,
            ),
            const SizedBox(height: 12),
            _IndicatorBar(
              label: l10n.bollingerPositionLabel,
              value: analysis.indicators.bollingerBands.pricePosition.clamp(
                0.0,
                1.0,
              ),
              valueText: compactTwo.format(
                analysis.indicators.bollingerBands.pricePosition,
              ),
              color: AppColors.secondary,
            ),
            const SizedBox(height: 18),
            Text(
              l10n.signalMatrixTitle,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _SignalChip(
                  label: l10n.signalMaCrossLabel,
                  value: l10n.signalValueLabel(
                    analysis.signals.maCross.apiValue,
                  ),
                ),
                _SignalChip(
                  label: l10n.signalMaTrendLabel,
                  value: l10n.signalValueLabel(
                    analysis.signals.maTrend.apiValue,
                  ),
                ),
                _SignalChip(
                  label: l10n.signalRsiLabel,
                  value: l10n.signalValueLabel(analysis.signals.rsi.apiValue),
                ),
                _SignalChip(
                  label: l10n.signalMacdLabel,
                  value: l10n.signalValueLabel(analysis.signals.macd.apiValue),
                ),
                _SignalChip(
                  label: l10n.signalBollingerLabel,
                  value: l10n.signalValueLabel(
                    analysis.signals.bollinger.apiValue,
                  ),
                ),
              ],
            ),
            if (suggestions != null) ...<Widget>[
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted.withValues(alpha: 0.78),
                  borderRadius: BorderRadius.circular(22),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      l10n.tradingSuggestionsTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: <Widget>[
                        _SuggestionStat(
                          label: l10n.stopLossLabel,
                          value: fixedFive.format(suggestions.stopLoss),
                        ),
                        _SuggestionStat(
                          label: l10n.atrTargetLabel,
                          value: fixedFive.format(
                            suggestions.takeProfit.atrBased,
                          ),
                        ),
                        _SuggestionStat(
                          label: l10n.keyLevelLabel,
                          value: fixedFive.format(
                            suggestions.takeProfit.keyLevel,
                          ),
                        ),
                        _SuggestionStat(
                          label: l10n.dailyRangeLabel,
                          value: fixedFive.format(
                            suggestions.volatility.dailyRange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static String _formatTime(DateTime dateTime, String localeName) {
    return DateFormat.Hm(localeName).format(dateTime);
  }

  static String _rsiCaption(BuildContext context, double rsi) {
    final l10n = context.l10n;

    if (rsi >= 70) {
      return l10n.rsiCaptionOverbought;
    }
    if (rsi <= 30) {
      return l10n.rsiCaptionOversold;
    }
    return l10n.rsiCaptionBalanced;
  }
}

class _RecommendationBadge extends StatelessWidget {
  const _RecommendationBadge({required this.label, required this.palette});

  final String label;
  final _SignalPalette palette;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _PriceBlock extends StatelessWidget {
  const _PriceBlock({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.inkMuted),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.caption,
  });

  final String label;
  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 145),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.chartTrack),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(caption, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _IndicatorBar extends StatelessWidget {
  const _IndicatorBar({
    required this.label,
    required this.value,
    required this.valueText,
    required this.color,
  });

  final String label;
  final double value;
  final String valueText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
            ),
            Text(
              valueText,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: value.clamp(0.0, 1.0),
            minHeight: 10,
            backgroundColor: AppColors.chartTrack,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _SignalChip extends StatelessWidget {
  const _SignalChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(16),
      ),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.inkMuted,
            fontWeight: FontWeight.w600,
          ),
          children: <InlineSpan>[
            TextSpan(text: '$label: '),
            TextSpan(
              text: value,
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestionStat extends StatelessWidget {
  const _SuggestionStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 125),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _SignalPalette {
  const _SignalPalette({required this.color, required this.softColor});

  factory _SignalPalette.fromRecommendation(Recommendation recommendation) {
    return switch (recommendation) {
      Recommendation.buy => const _SignalPalette(
        color: AppColors.success,
        softColor: AppColors.successSoft,
      ),
      Recommendation.sell => const _SignalPalette(
        color: AppColors.danger,
        softColor: AppColors.dangerSoft,
      ),
      Recommendation.neutral => const _SignalPalette(
        color: AppColors.neutral,
        softColor: AppColors.neutralSoft,
      ),
    };
  }

  final Color color;
  final Color softColor;
}
