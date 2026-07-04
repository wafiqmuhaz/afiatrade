import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _loginEmailKey = 'loginEmail';
  static const String _localeCodeKey = 'localeCode';

  Future<bool> isLoggedIn() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_isLoggedInKey, value);
  }

  Future<void> setEmail(String email) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_loginEmailKey, email);
  }

  Future<String?> getEmail() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_loginEmailKey);
  }

  Future<void> setLocaleCode(String localeCode) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_localeCodeKey, localeCode);
  }

  Future<String?> getLocaleCode() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_localeCodeKey);
  }

  Future<void> clearSession() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_isLoggedInKey, false);
    await preferences.remove(_loginEmailKey);
  }
}
