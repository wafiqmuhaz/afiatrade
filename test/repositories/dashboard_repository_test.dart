import 'package:afiatrade/models/app_exceptions.dart';
import 'package:afiatrade/repositories/dashboard_repository.dart';
import 'package:afiatrade/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../fixtures/analysis_response_fixture.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('DashboardRepository', () {
    late MockApiService apiService;
    late DashboardRepository dashboardRepository;

    setUpAll(() {
      registerFallbackValue(Uri.parse('https://example.com'));
    });

    setUp(() {
      apiService = MockApiService();
      dashboardRepository = DashboardRepository(apiService: apiService);
    });

    test('maps a successful API response into messages', () async {
      when(
        () => apiService.get(any()),
      ).thenAnswer((_) async => http.Response(analysisResponseFixture, 200));

      final messages = await dashboardRepository.fetchAnalysis();

      expect(messages, hasLength(1));
      expect(messages.first.symbol, 'EURUSD');
      expect(messages.first.analysis.currentPrice.spread, 25);
    });

    test('throws ApiException on non-200 responses', () async {
      when(
        () => apiService.get(any()),
      ).thenAnswer((_) async => http.Response('server error', 500));

      await expectLater(
        dashboardRepository.fetchAnalysis,
        throwsA(isA<ApiException>()),
      );
    });

    test('throws ParsingException on malformed payloads', () async {
      when(() => apiService.get(any())).thenAnswer(
        (_) async => http.Response(malformedAnalysisResponseFixture, 200),
      );

      await expectLater(
        dashboardRepository.fetchAnalysis,
        throwsA(isA<ParsingException>()),
      );
    });
  });
}
