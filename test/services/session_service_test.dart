import 'package:afiatrade/services/session_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SessionService', () {
    late SessionService sessionService;

    setUp(() {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      sessionService = SessionService();
    });

    test('round-trips login state', () async {
      expect(await sessionService.isLoggedIn(), isFalse);

      await sessionService.setLoggedIn(true);
      expect(await sessionService.isLoggedIn(), isTrue);

      await sessionService.setLoggedIn(false);
      expect(await sessionService.isLoggedIn(), isFalse);
    });

    test('stores and clears the login email', () async {
      await sessionService.setEmail('user@test.com');
      expect(await sessionService.getEmail(), 'user@test.com');

      await sessionService.clearSession();
      expect(await sessionService.getEmail(), isNull);
      expect(await sessionService.isLoggedIn(), isFalse);
    });

    test('keeps the locale preference when clearing the session', () async {
      await sessionService.setLocaleCode('id');
      expect(await sessionService.getLocaleCode(), 'id');

      await sessionService.clearSession();

      expect(await sessionService.getLocaleCode(), 'id');
    });
  });
}
