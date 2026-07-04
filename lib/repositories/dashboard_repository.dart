import 'dart:convert';

import '../models/analysis_response.dart';
import '../models/app_exceptions.dart';
import '../services/api_service.dart';

class DashboardRepository {
  DashboardRepository({required this.apiService});

  final ApiService apiService;

  Future<List<Message>> fetchAnalysis({String timeframe = 'H1'}) async {
    final Uri uri = Uri.https(
      'api-mt5.techcrm.net',
      '/v5-terminal-analis/analysis_main',
      <String, String>{'timeframe': timeframe},
    );

    final response = await apiService.get(uri);
    if (response.statusCode != 200) {
      throw ApiException(statusCode: response.statusCode, body: response.body);
    }

    try {
      final Map<String, dynamic> decodedBody =
          jsonDecode(response.body) as Map<String, dynamic>;
      final Welcome welcome = Welcome.fromJson(decodedBody);
      return welcome.message;
    } on FormatException catch (error) {
      throw ParsingException('Unable to parse the market analysis.', error);
    } on TypeError catch (error) {
      throw ParsingException('Unable to parse the market analysis.', error);
    }
  }
}
