# afiatrade

A Flutter mobile application that authenticates a user, then pulls live-ish forex technical analysis (moving averages, RSI, MACD, Bollinger Bands, signals, and trading suggestions) from a remote analysis API and renders it as a scrollable dashboard.

Built as a technical assessment deliverable demonstrating clean **MVC** layering with **flutter_bloc** as the Controller layer, `SharedPreferences` for session persistence, and `http` for networking.

---

## 1. Tech Stack

| Concern | Choice |
|---|---|
| Language / Framework | Dart / Flutter (stable channel) |
| State Management | `flutter_bloc` (Bloc pattern) |
| Architecture Pattern | MVC (Model-View-Controller), Bloc = Controller |
| Session Persistence | `shared_preferences` |
| Networking | `http` package |
| Localization | Flutter official i18n (`flutter_localizations` + `intl`, ARB-based) |
| JSON Modeling | Hand-rolled `fromJson`/`toJson` (no code-gen) |
| Navigation | `Navigator` 1.0 (named routes) - sufficient for 3-screen flow |
| Dashboard Visualization | Custom-painted donut chart (no extra package) |

> Note: This project uses **Bloc** end-to-end per direct instruction. 

## 2. App Flow

```text
Splash (2s delay)
   |
   |-- SharedPreferences: isLoggedIn == true --> Dashboard
   |
   '-- SharedPreferences: isLoggedIn == false --> Login
                                                    |
                                        success ----+--> save session --> Dashboard
                                        failure ----'--> inline validation error
```

## 3. Hardcoded Auth (per assignment spec)

```json
{
  "email": "user@test.com",
  "password": "password123"
}
```

No real auth backend is called for login - this is validated client-side against the fixed credential pair above, then a session flag is persisted locally.

## 4. Dashboard Data Source

```text
GET https://api-mt5.techcrm.net/v5-terminal-analis/analysis_main?timeframe=H1
```

Response is a list of per-symbol technical analysis snapshots (indicators, signals, recommendation, current price, optional trading suggestions). 

## 5. Project Structure

```text
lib/
|-- main.dart
|-- app.dart                      # MaterialApp + route table + BlocProviders
|-- l10n/
|   |-- app_en.arb               # English translations
|   |-- app_id.arb               # Bahasa Indonesia translations
|   |-- app_localizations.dart   # generated typed localization accessors
|   |-- app_localizations_x.dart # context.l10n helpers + message-key mapping
|   |-- locale_controller.dart   # runtime locale + persistence bridge
|   '-- locale_scope.dart        # inherited notifier for locale switching
|-- theme/
|   |-- app_colors.dart           # shared palette extracted from Splash
|   '-- app_theme.dart            # centralized ThemeData
|-- models/
|   |-- analysis_response.dart    # Welcome, Message, Analysis, Indicators...
|   '-- enums.dart                # Recommendation, MaTrend, Rsi, Bollinger, Timeframe
|-- services/
|   |-- api_service.dart          # raw http client wrapper
|   '-- session_service.dart      # SharedPreferences wrapper
|-- repositories/
|   |-- auth_repository.dart
|   '-- dashboard_repository.dart
|-- controllers/                  # "Controller" layer = Bloc
|   |-- auth/
|   |   |-- auth_bloc.dart
|   |   |-- auth_event.dart
|   |   '-- auth_state.dart
|   '-- dashboard/
|       |-- dashboard_bloc.dart
|       |-- dashboard_event.dart
|       '-- dashboard_state.dart
'-- views/                        # "View" layer - zero business logic
    |-- splash/splash_page.dart
    |-- login/login_page.dart
    |-- widgets/language_switcher_button.dart
    '-- dashboard/
        |-- dashboard_page.dart
        '-- widgets/analysis_card.dart
```

## 6. Getting Started

```bash
flutter pub get
flutter run
```

### Dependencies (`pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  flutter_bloc: ^8.1.6
  equatable: ^2.0.7
  http: ^1.5.0
  intl: ^0.20.2
  shared_preferences: ^2.5.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.7
  mocktail: ^1.0.4
```

## 7. Build Release APK

```bash
flutter build apk --release
# output: build/app/outputs/flutter-apk/app-release.apk
```

## 8. Trying the app

```bash
You can install and try the application by downloading afiatrade.apk in the root of this project.
```
# direct download:
[Afiatrade (Github)](https://github.com/wafiqmuhaz/afiatrade/raw/refs/heads/main/afiatrade.apk)
