import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_message_keys.dart';
import '../../models/app_exceptions.dart';
import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

export 'auth_event.dart';
export 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(const AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  final AuthRepository authRepository;

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final bool isLoggedIn = await authRepository.isLoggedIn();
    emit(isLoggedIn ? const AuthAuthenticated() : const AuthUnauthenticated());
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (event.email.trim().isEmpty || event.password.isEmpty) {
      emit(const AuthFailure(AppMessageKeys.authRequiredFields));
      return;
    }

    emit(const AuthLoading());

    try {
      await authRepository.login(event.email.trim(), event.password);
      emit(const AuthAuthenticated());
    } on InvalidCredentialsException catch (error) {
      emit(AuthFailure(error.message));
    } catch (_) {
      emit(const AuthFailure(AppMessageKeys.authGeneric));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await authRepository.logout();
    emit(const AuthUnauthenticated());
  }
}
