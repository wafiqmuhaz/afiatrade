import '../models/app_exceptions.dart';
import '../services/session_service.dart';

class AuthRepository {
  AuthRepository({required this.sessionService});

  static const String validEmail = 'user@test.com';
  static const String validPassword = 'password123';

  final SessionService sessionService;

  Future<bool> isLoggedIn() {
    return sessionService.isLoggedIn();
  }

  Future<void> login(String email, String password) async {
    if (email != validEmail || password != validPassword) {
      throw InvalidCredentialsException();
    }

    await sessionService.setLoggedIn(true);
    await sessionService.setEmail(email);
  }

  Future<void> logout() {
    return sessionService.clearSession();
  }
}
