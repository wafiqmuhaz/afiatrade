import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/app_exceptions.dart';

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<http.Response> get(Uri uri) async {
    try {
      return await _client.get(uri).timeout(const Duration(seconds: 15));
    } on SocketException {
      throw NetworkException('No internet connection.');
    } on TimeoutException {
      throw NetworkException('The request timed out.');
    }
  }
}
