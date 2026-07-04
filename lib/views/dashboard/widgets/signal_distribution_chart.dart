import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations_x.dart';
import '../../../theme/app_colors.dart';

class SignalDistributionChart extends StatelessWidget {
  const SignalDistributionChart({
    super.key,
    required this.buyCount,
    required this.sellCount,
    required this.neutralCount,
  });

  final int buyCount;
  final int sellCount;
  final int neutralCount;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final String localeName = Localizations.localeOf(context).toLanguageTag();
    final int total = buyCount + sellCount + neutralCount;
    final NumberFormat countFormat = NumberFormat.decimalPattern(localeName);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              l10n.signalDistributionTitle,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.signalDistributionDescription,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 18),
            Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 170,
                    child: CustomPaint(
                      painter: _SignalDonutPainter(
                        buyCount: buyCount,
                        sellCount: sellCount,
                        neutralCount: neutralCount,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              countFormat.format(total),
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            Text(
                              l10n.pairsShortLabel,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      _LegendTile(
                        label: l10n.buySignal,
                        count: countFormat.format(buyCount),
                        color: AppColors.success,
                        softColor: AppColors.successSoft,
                      ),
                      const SizedBox(height: 10),
                      _LegendTile(
                        label: l10n.sellSignal,
                        count: countFormat.format(sellCount),
                        color: AppColors.danger,
                        softColor: AppColors.dangerSoft,
                      ),
                      const SizedBox(height: 10),
                      _LegendTile(
                        label: l10n.holdSignal,
                        count: countFormat.format(neutralCount),
                        color: AppColors.neutral,
                        softColor: AppColors.neutralSoft,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendTile extends StatelessWidget {
  const _LegendTile({
    required this.label,
    required this.count,
    required this.color,
    required this.softColor,
  });

  final String label;
  final String count;
  final Color color;
  final Color softColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: softColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              count,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

class _SignalDonutPainter extends CustomPainter {
  const _SignalDonutPainter({
    required this.buyCount,
    required this.sellCount,
    required this.neutralCount,
  });

  final int buyCount;
  final int sellCount;
  final int neutralCount;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double strokeWidth = 22;
    final double radius = math.min(size.width, size.height) / 2 - strokeWidth;
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    final Paint trackPaint = Paint()
      ..color = AppColors.chartTrack
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas.drawArc(rect, 0, math.pi * 2, false, trackPaint);

    final int total = buyCount + sellCount + neutralCount;
    if (total == 0) {
      return;
    }

    final List<({int count, Color color})> segments =
        <({int count, Color color})>[
          (count: buyCount, color: AppColors.success),
          (count: sellCount, color: AppColors.danger),
          (count: neutralCount, color: AppColors.neutral),
        ];

    double startAngle = -math.pi / 2;
    for (final ({int count, Color color}) segment in segments) {
      if (segment.count == 0) {
        continue;
      }

      final double sweepAngle = (segment.count / total) * (math.pi * 2) - 0.08;
      final Paint paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidth;

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += (segment.count / total) * (math.pi * 2);
    }
  }

  @override
  bool shouldRepaint(covariant _SignalDonutPainter oldDelegate) {
    return buyCount != oldDelegate.buyCount ||
        sellCount != oldDelegate.sellCount ||
        neutralCount != oldDelegate.neutralCount;
  }
}
