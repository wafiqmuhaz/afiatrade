import '../l10n/app_message_keys.dart';

class NetworkException implements Exception {
  NetworkException([this.message = 'Unable to reach the server.']);

  final String message;

  @override
  String toString() => message;
}

class ApiException implements Exception {
  ApiException({
    required this.statusCode,
    required this.body,
    this.message = 'The server returned an unexpected response.',
  });

  final int statusCode;
  final String body;
  final String message;

  @override
  String toString() => '$message (HTTP $statusCode)';
}

class ParsingException implements Exception {
  ParsingException([
    this.message = 'Unable to read the analysis data right now.',
    this.cause,
  ]);

  final String message;
  final Object? cause;

  @override
  String toString() => message;
}

class InvalidCredentialsException implements Exception {
  InvalidCredentialsException([
    this.message = AppMessageKeys.authInvalidCredentials,
  ]);

  final String message;

  @override
  String toString() => message;
}
