import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../controllers/auth/auth_bloc.dart';
import '../../controllers/dashboard/dashboard_bloc.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/app_localizations_x.dart';
import '../../models/analysis_response.dart';
import '../../theme/app_colors.dart';
import '../login/login_page.dart';
import '../widgets/language_switcher_button.dart';
import 'widgets/analysis_card.dart';
import 'widgets/signal_distribution_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const String routeName = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(const FetchAnalysis());
  }

  Future<void> _refresh() async {
    context.read<DashboardBloc>().add(const FetchAnalysis());
  }

  @override
  Widget build(BuildContext context) {
    final DashboardState dashboardState = context.watch<DashboardBloc>().state;
    final AuthState authState = context.watch<AuthBloc>().state;

    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthUnauthenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            LoginPage.routeName,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _DashboardAppBar(
          dashboardState: dashboardState,
          isLoggingOut: authState is AuthLoading,
          onRefresh: () {
            _refresh();
          },
          onLogout: () {
            context.read<AuthBloc>().add(const LogoutRequested());
          },
        ),
        body: DecoratedBox(
          decoration: const BoxDecoration(gradient: AppColors.panelGradient),
          child: Stack(
            children: <Widget>[
              const Positioned(
                top: -90,
                right: -40,
                child: _GlowOrb(size: 220, color: Color(0x2644A1A0)),
              ),
              const Positioned(
                top: 180,
                left: -60,
                child: _GlowOrb(size: 180, color: Color(0x180D5C63)),
              ),
              SafeArea(child: _buildBody(context, dashboardState)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, DashboardState state) {
    if (state is DashboardLoading || state is DashboardInitial) {
      return const _DashboardLoadingView();
    }

    if (state is DashboardError) {
      return _DashboardErrorView(messageKey: state.message, onRetry: _refresh);
    }

    final DashboardLoaded loadedState = state as DashboardLoaded;
    if (loadedState.messages.isEmpty) {
      return _DashboardEmptyView(onRefresh: _refresh);
    }

    final _DashboardSummary summary = _DashboardSummary.fromMessages(
      loadedState.messages,
    );

    return RefreshIndicator(
      onRefresh: _refresh,
      color: AppColors.secondary,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 96, 16, 24),
        itemCount: loadedState.messages.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _DashboardSummaryPanel(summary: summary),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AnalysisCard(message: loadedState.messages[index - 1]),
          );
        },
      ),
    );
  }
}

class _DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _DashboardAppBar({
    required this.dashboardState,
    required this.isLoggingOut,
    required this.onRefresh,
    required this.onLogout,
  });

  final DashboardState dashboardState;
  final bool isLoggingOut;
  final VoidCallback onRefresh;
  final VoidCallback onLogout;

  @override
  Size get preferredSize => const Size.fromHeight(92);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final String localeName = Localizations.localeOf(context).toLanguageTag();
    final NumberFormat countFormat = NumberFormat.decimalPattern(localeName);

    final String subtitle = switch (dashboardState) {
      DashboardLoaded(:final messages) => l10n.dashboardSubtitleUpdated(
        _formatTime(_latestUpdate(messages), localeName),
        countFormat.format(messages.length),
      ),
      DashboardError() => l10n.dashboardSubtitleInterrupted,
      DashboardLoading() || DashboardInitial() => l10n.dashboardSubtitleSyncing,
      _ => l10n.dashboardSubtitleDefault,
    };

    return AppBar(
      toolbarHeight: 92,
      titleSpacing: 16,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            l10n.appTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.inkMuted),
          ),
        ],
      ),
      actions: <Widget>[
        _ActionIconButton(
          icon: Icons.refresh_rounded,
          tooltip: l10n.tooltipRefresh,
          onPressed: onRefresh,
        ),
        const SizedBox(width: 8),
        _ActionShell(
          child: LanguageSwitcherButton(
            iconColor: AppColors.primary,
            backgroundColor: AppColors.surface.withValues(alpha: 0.86),
          ),
        ),
        const SizedBox(width: 8),
        _ActionIconButton(
          icon: Icons.logout_rounded,
          tooltip: l10n.tooltipLogout,
          onPressed: isLoggingOut ? null : onLogout,
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  static DateTime _latestUpdate(List<Message> messages) {
    return messages
        .map((Message item) => item.analysis.lastUpdate)
        .reduce((DateTime a, DateTime b) => a.isAfter(b) ? a : b);
  }

  static String _formatTime(DateTime dateTime, String localeName) {
    return DateFormat.Hm(localeName).format(dateTime);
  }
}

class _ActionShell extends StatelessWidget {
  const _ActionShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18, bottom: 18),
      child: child,
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  const _ActionIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        margin: const EdgeInsets.only(top: 18, bottom: 18),
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.86),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 18,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: AppColors.primary),
        ),
      ),
    );
  }
}

class _DashboardSummaryPanel extends StatelessWidget {
  const _DashboardSummaryPanel({required this.summary});

  final _DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final String localeName = Localizations.localeOf(context).toLanguageTag();
    final NumberFormat countFormat = NumberFormat.decimalPattern(localeName);
    final NumberFormat decimalFormat = NumberFormat.decimalPatternDigits(
      locale: localeName,
      decimalDigits: 1,
    );

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: AppColors.heroGradient,
            borderRadius: BorderRadius.circular(28),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 26,
                offset: Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                l10n.marketSnapshotTitle,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.marketSnapshotSummary(
                  countFormat.format(summary.buyCount + summary.sellCount),
                  countFormat.format(summary.totalPairs),
                ),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  _HeroStat(
                    label: l10n.avgRsiLabel,
                    value: decimalFormat.format(summary.averageRsi),
                  ),
                  _HeroStat(
                    label: l10n.strongestSideLabel,
                    value: _dominantSignalLabel(l10n, summary),
                  ),
                  _HeroStat(
                    label: l10n.lastUpdateLabel,
                    value: DateFormat.Hm(
                      localeName,
                    ).format(summary.lastUpdated),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool stacked = constraints.maxWidth < 720;
            final Widget chart = Expanded(
              child: SignalDistributionChart(
                buyCount: summary.buyCount,
                sellCount: summary.sellCount,
                neutralCount: summary.neutralCount,
              ),
            );
            final Widget stats = Expanded(
              child: _SummaryStatsCard(summary: summary),
            );

            if (stacked) {
              return Column(
                children: <Widget>[
                  SignalDistributionChart(
                    buyCount: summary.buyCount,
                    sellCount: summary.sellCount,
                    neutralCount: summary.neutralCount,
                  ),
                  const SizedBox(height: 16),
                  _SummaryStatsCard(summary: summary),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[chart, const SizedBox(width: 16), stats],
            );
          },
        ),
      ],
    );
  }

  static String _dominantSignalLabel(
    AppLocalizations l10n,
    _DashboardSummary summary,
  ) {
    return switch (summary.dominantSignalKey) {
      'buy' => l10n.dominantBuyBias,
      'sell' => l10n.dominantSellBias,
      _ => l10n.dominantMixedHold,
    };
  }
}

class _SummaryStatsCard extends StatelessWidget {
  const _SummaryStatsCard({required this.summary});

  final _DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final String localeName = Localizations.localeOf(context).toLanguageTag();
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
              l10n.signalBoardTitle,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.signalBoardDescription,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 18),
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.55,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                _StatTile(
                  label: l10n.buySignal.toUpperCase(),
                  value: countFormat.format(summary.buyCount),
                  tone: AppColors.success,
                  softTone: AppColors.successSoft,
                ),
                _StatTile(
                  label: l10n.sellSignal.toUpperCase(),
                  value: countFormat.format(summary.sellCount),
                  tone: AppColors.danger,
                  softTone: AppColors.dangerSoft,
                ),
                _StatTile(
                  label: l10n.holdSignal.toUpperCase(),
                  value: countFormat.format(summary.neutralCount),
                  tone: AppColors.neutral,
                  softTone: AppColors.neutralSoft,
                ),
                _StatTile(
                  label: l10n.pairsLabel,
                  value: countFormat.format(summary.totalPairs),
                  tone: AppColors.primary,
                  softTone: AppColors.surfaceMuted,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.tone,
    required this.softTone,
  });

  final String label;
  final String value;
  final Color tone;
  final Color softTone;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: softTone,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: tone,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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

class _DashboardLoadingView extends StatelessWidget {
  const _DashboardLoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.95),
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
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CircularProgressIndicator(),
                const SizedBox(height: 18),
                Text(
                  context.l10n.dashboardLoadingMessage,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardErrorView extends StatelessWidget {
  const _DashboardErrorView({required this.messageKey, required this.onRetry});

  final String messageKey;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: DecoratedBox(
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
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: const BoxDecoration(
                    color: AppColors.dangerSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.wifi_tethering_error_rounded,
                    size: 30,
                    color: AppColors.danger,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  l10n.dashboardErrorTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.errorForKey(messageKey),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 22),
                FilledButton.icon(
                  onPressed: () {
                    onRetry();
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(l10n.dashboardRetryButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardEmptyView extends StatelessWidget {
  const _DashboardEmptyView({required this.onRefresh});

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 140, 24, 24),
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.95),
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
              padding: const EdgeInsets.all(26),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceMuted,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.insights_rounded,
                      size: 28,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.dashboardEmptyTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.dashboardEmptyDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 18),
                  FilledButton(
                    onPressed: () {
                      onRefresh();
                    },
                    child: Text(l10n.dashboardCheckAgain),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: <Color>[color, Colors.transparent]),
        ),
      ),
    );
  }
}

class _DashboardSummary {
  const _DashboardSummary({
    required this.totalPairs,
    required this.buyCount,
    required this.sellCount,
    required this.neutralCount,
    required this.averageRsi,
    required this.lastUpdated,
  });

  factory _DashboardSummary.fromMessages(List<Message> messages) {
    int buyCount = 0;
    int sellCount = 0;
    int neutralCount = 0;
    double totalRsi = 0;
    DateTime latest = messages.first.analysis.lastUpdate;

    for (final Message item in messages) {
      totalRsi += item.analysis.indicators.rsi;
      final recommendation = item.analysis.recommendation;
      if (recommendation.name == 'buy') {
        buyCount += 1;
      } else if (recommendation.name == 'sell') {
        sellCount += 1;
      } else {
        neutralCount += 1;
      }

      if (item.analysis.lastUpdate.isAfter(latest)) {
        latest = item.analysis.lastUpdate;
      }
    }

    return _DashboardSummary(
      totalPairs: messages.length,
      buyCount: buyCount,
      sellCount: sellCount,
      neutralCount: neutralCount,
      averageRsi: totalRsi / messages.length,
      lastUpdated: latest,
    );
  }

  final int totalPairs;
  final int buyCount;
  final int sellCount;
  final int neutralCount;
  final double averageRsi;
  final DateTime lastUpdated;

  String get dominantSignalKey {
    if (buyCount > sellCount && buyCount > neutralCount) {
      return 'buy';
    }
    if (sellCount > buyCount && sellCount > neutralCount) {
      return 'sell';
    }
    return 'mixed';
  }
}
