import 'package:afiatrade/models/app_exceptions.dart';
import 'package:afiatrade/repositories/auth_repository.dart';
import 'package:afiatrade/services/session_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSessionService extends Mock implements SessionService {}

void main() {
  group('AuthRepository', () {
    late MockSessionService sessionService;
    late AuthRepository authRepository;

    setUp(() {
      sessionService = MockSessionService();
      authRepository = AuthRepository(sessionService: sessionService);
      when(() => sessionService.setLoggedIn(any())).thenAnswer((_) async {});
      when(() => sessionService.setEmail(any())).thenAnswer((_) async {});
      when(() => sessionService.clearSession()).thenAnswer((_) async {});
    });

    test('logs in with the required static credentials', () async {
      await authRepository.login('user@test.com', 'password123');

      verify(() => sessionService.setLoggedIn(true)).called(1);
      verify(() => sessionService.setEmail('user@test.com')).called(1);
    });

    test('throws when credentials are invalid', () async {
      await expectLater(
        () => authRepository.login('wrong@test.com', 'nope'),
        throwsA(isA<InvalidCredentialsException>()),
      );

      verifyNever(() => sessionService.setLoggedIn(any()));
      verifyNever(() => sessionService.setEmail(any()));
    });

    test('clears the session on logout', () async {
      await authRepository.logout();

      verify(() => sessionService.clearSession()).called(1);
    });
  });
}
