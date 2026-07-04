import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'controllers/auth/auth_bloc.dart';
import 'controllers/dashboard/dashboard_bloc.dart';
import 'l10n/app_localizations.dart';
import 'l10n/l10n.dart';
import 'l10n/locale_controller.dart';
import 'l10n/locale_scope.dart';
import 'repositories/auth_repository.dart';
import 'repositories/dashboard_repository.dart';
import 'services/api_service.dart';
import 'services/session_service.dart';
import 'theme/app_theme.dart';
import 'views/dashboard/dashboard_page.dart';
import 'views/login/login_page.dart';
import 'views/splash/splash_page.dart';

class AfiatradeApp extends StatefulWidget {
  const AfiatradeApp({
    super.key,
    this.apiService,
    this.sessionService,
    this.authRepository,
    this.dashboardRepository,
  });

  final ApiService? apiService;
  final SessionService? sessionService;
  final AuthRepository? authRepository;
  final DashboardRepository? dashboardRepository;

  @override
  State<AfiatradeApp> createState() => _AfiatradeAppState();
}

class _AfiatradeAppState extends State<AfiatradeApp> {
  late final SessionService _resolvedSessionService =
      widget.sessionService ?? SessionService();
  late final ApiService _resolvedApiService = widget.apiService ?? ApiService();
  late final AuthRepository _resolvedAuthRepository =
      widget.authRepository ??
      AuthRepository(sessionService: _resolvedSessionService);
  late final DashboardRepository _resolvedDashboardRepository =
      widget.dashboardRepository ??
      DashboardRepository(apiService: _resolvedApiService);
  late final LocaleController _localeController = LocaleController(
    sessionService: _resolvedSessionService,
  );
  late final Future<void> _localeFuture = _localeController
      .loadPreferredLocale();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _localeFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }

        return LocaleScope(
          controller: _localeController,
          child: AnimatedBuilder(
            animation: _localeController,
            builder: (BuildContext context, _) {
              return _buildApp();
            },
          ),
        );
      },
    );
  }

  Widget _buildApp() {
    return MultiRepositoryProvider(
      providers: <RepositoryProvider<dynamic>>[
        RepositoryProvider<AuthRepository>.value(
          value: _resolvedAuthRepository,
        ),
        RepositoryProvider<DashboardRepository>.value(
          value: _resolvedDashboardRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<AuthBloc>(
            create: (BuildContext context) =>
                AuthBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<DashboardBloc>(
            create: (BuildContext context) => DashboardBloc(
              dashboardRepository: context.read<DashboardRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          locale: _localeController.locale,
          supportedLocales: L10n.supportedLocales,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
                if (_localeController.locale != null) {
                  return _localeController.locale;
                }

                return L10n.fallbackLocale(locale);
              },
          initialRoute: SplashPage.routeName,
          routes: <String, WidgetBuilder>{
            SplashPage.routeName: (_) => const SplashPage(),
            LoginPage.routeName: (_) => const LoginPage(),
            DashboardPage.routeName: (_) => const DashboardPage(),
          },
        ),
      ),
    );
  }
}
