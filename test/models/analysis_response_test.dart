import 'dart:convert';

import 'package:afiatrade/models/analysis_response.dart';
import 'package:afiatrade/models/enums.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/analysis_response_fixture.dart';

void main() {
  group('Welcome.fromJson', () {
    test('parses the sample response payload', () {
      final Welcome response = Welcome.fromJson(
        jsonDecode(analysisResponseFixture) as Map<String, dynamic>,
      );

      expect(response.result, 'success');
      expect(response.message, hasLength(1));
      expect(response.message.first.symbol, 'EURUSD');
      expect(response.message.first.analysis.indicators.rsi, 30.54);
      expect(
        response.message.first.analysis.recommendation,
        Recommendation.buy,
      );
      expect(response.message.first.analysis.currentPrice.ask, 1.1438);
      expect(response.message.first.analysis.tradingSuggestions, isNotNull);
    });

    test('accepts a null trading_suggestions payload', () {
      final Welcome response = Welcome.fromJson(
        jsonDecode(analysisResponseWithoutSuggestionsFixture)
            as Map<String, dynamic>,
      );

      expect(response.message.first.symbol, 'USDCAD');
      expect(response.message.first.analysis.tradingSuggestions, isNull);
      expect(response.message.first.analysis.signals.rsi, Rsi.overbought);
    });
  });
}
