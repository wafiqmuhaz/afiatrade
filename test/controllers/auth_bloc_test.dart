import 'package:afiatrade/controllers/auth/auth_bloc.dart';
import 'package:afiatrade/l10n/app_message_keys.dart';
import 'package:afiatrade/models/app_exceptions.dart';
import 'package:afiatrade/repositories/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('AuthBloc', () {
    late MockAuthRepository authRepository;

    setUp(() {
      authRepository = MockAuthRepository();
    });

    blocTest<AuthBloc, AuthState>(
      'emits loading then authenticated when the session is already active',
      build: () {
        when(() => authRepository.isLoggedIn()).thenAnswer((_) async => true);
        return AuthBloc(authRepository: authRepository);
      },
      act: (AuthBloc bloc) => bloc.add(const AppStarted()),
      expect: () => <AuthState>[const AuthLoading(), const AuthAuthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits loading then authenticated when credentials are valid',
      build: () {
        when(
          () => authRepository.login('user@test.com', 'password123'),
        ).thenAnswer((_) async {});
        return AuthBloc(authRepository: authRepository);
      },
      act: (AuthBloc bloc) => bloc.add(
        const LoginSubmitted(email: 'user@test.com', password: 'password123'),
      ),
      expect: () => <AuthState>[const AuthLoading(), const AuthAuthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits loading then failure when credentials are invalid',
      build: () {
        when(
          () => authRepository.login('wrong@test.com', 'nope'),
        ).thenThrow(InvalidCredentialsException());
        return AuthBloc(authRepository: authRepository);
      },
      act: (AuthBloc bloc) => bloc.add(
        const LoginSubmitted(email: 'wrong@test.com', password: 'nope'),
      ),
      expect: () => <AuthState>[
        const AuthLoading(),
        const AuthFailure(AppMessageKeys.authInvalidCredentials),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits a validation failure when fields are empty',
      build: () => AuthBloc(authRepository: authRepository),
      act: (AuthBloc bloc) =>
          bloc.add(const LoginSubmitted(email: '', password: '')),
      expect: () => <AuthState>[
        const AuthFailure(AppMessageKeys.authRequiredFields),
      ],
    );
  });
}
