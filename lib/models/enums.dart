class EnumValues<T> {
  EnumValues(this.map);

  final Map<String, T> map;
  Map<T, String>? _reverseMap;

  Map<T, String> get reverse {
    _reverseMap ??= map.map(
      (String key, T value) => MapEntry<T, String>(value, key),
    );
    return _reverseMap!;
  }
}

enum Recommendation { buy, neutral, sell }

enum MaTrend { bullish, bearish }

enum Rsi { neutral, overbought, oversold }

enum Bollinger { bearish, neutral }

enum Timeframe { h1 }

final EnumValues<Recommendation> recommendationValues =
    EnumValues<Recommendation>(<String, Recommendation>{
      'buy': Recommendation.buy,
      'neutral': Recommendation.neutral,
      'sell': Recommendation.sell,
    });

final EnumValues<MaTrend> maTrendValues = EnumValues<MaTrend>(<String, MaTrend>{
  'bullish': MaTrend.bullish,
  'bearish': MaTrend.bearish,
});

final EnumValues<Rsi> rsiValues = EnumValues<Rsi>(<String, Rsi>{
  'neutral': Rsi.neutral,
  'overbought': Rsi.overbought,
  'oversold': Rsi.oversold,
});

final EnumValues<Bollinger> bollingerValues = EnumValues<Bollinger>(
  <String, Bollinger>{
    'bearish': Bollinger.bearish,
    'neutral': Bollinger.neutral,
  },
);

final EnumValues<Timeframe> timeframeValues = EnumValues<Timeframe>(
  <String, Timeframe>{'H1': Timeframe.h1},
);

T parseEnum<T>(Object? rawValue, EnumValues<T> values, String fieldName) {
  if (rawValue is! String) {
    throw FormatException('Expected a string for .');
  }

  final T? parsed = values.map[rawValue] ?? values.map[rawValue.toLowerCase()];
  if (parsed == null) {
    throw FormatException('Unsupported value "" for .');
  }

  return parsed;
}

extension RecommendationX on Recommendation {
  String get apiValue => recommendationValues.reverse[this]!;
}

extension MaTrendX on MaTrend {
  String get apiValue => maTrendValues.reverse[this]!;
}

extension RsiX on Rsi {
  String get apiValue => rsiValues.reverse[this]!;
}

extension BollingerX on Bollinger {
  String get apiValue => bollingerValues.reverse[this]!;
}

extension TimeframeX on Timeframe {
  String get apiValue => timeframeValues.reverse[this]!;
}
