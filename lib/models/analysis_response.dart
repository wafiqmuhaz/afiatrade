import 'enums.dart';

class Welcome {
  Welcome({required this.result, required this.message});

  factory Welcome.fromJson(Map<String, dynamic> json) {
    return Welcome(
      result: _requireString(json['result'], 'result'),
      message: _requireList(json['message'], 'message')
          .map(
            (Object? item) => Message.fromJson(_requireMap(item, 'message[]')),
          )
          .toList(),
    );
  }

  final String result;
  final List<Message> message;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'result': result,
    'message': message.map((Message item) => item.toJson()).toList(),
  };
}

class Message {
  Message({
    required this.symbol,
    required this.timeframe,
    required this.analysis,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      symbol: _requireString(json['symbol'], 'symbol'),
      timeframe: parseEnum<Timeframe>(
        json['timeframe'],
        timeframeValues,
        'timeframe',
      ),
      analysis: Analysis.fromJson(_requireMap(json['analysis'], 'analysis')),
    );
  }

  final String symbol;
  final Timeframe timeframe;
  final Analysis analysis;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'symbol': symbol,
    'timeframe': timeframe.apiValue,
    'analysis': analysis.toJson(),
  };
}

class Analysis {
  Analysis({
    required this.indicators,
    required this.signals,
    required this.recommendation,
    required this.lastUpdate,
    required this.currentPrice,
    this.tradingSuggestions,
  });

  factory Analysis.fromJson(Map<String, dynamic> json) {
    return Analysis(
      indicators: Indicators.fromJson(
        _requireMap(json['indicators'], 'analysis.indicators'),
      ),
      signals: Signals.fromJson(
        _requireMap(json['signals'], 'analysis.signals'),
      ),
      recommendation: parseEnum<Recommendation>(
        json['recommendation'],
        recommendationValues,
        'analysis.recommendation',
      ),
      lastUpdate: _requireDateTime(json['last_update'], 'analysis.last_update'),
      currentPrice: CurrentPrice.fromJson(
        _requireMap(json['current_price'], 'analysis.current_price'),
      ),
      tradingSuggestions: json['trading_suggestions'] == null
          ? null
          : TradingSuggestions.fromJson(
              _requireMap(
                json['trading_suggestions'],
                'analysis.trading_suggestions',
              ),
            ),
    );
  }

  final Indicators indicators;
  final Signals signals;
  final Recommendation recommendation;
  final DateTime lastUpdate;
  final CurrentPrice currentPrice;
  final TradingSuggestions? tradingSuggestions;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'indicators': indicators.toJson(),
    'signals': signals.toJson(),
    'recommendation': recommendation.apiValue,
    'last_update': lastUpdate.toIso8601String(),
    'current_price': currentPrice.toJson(),
    'trading_suggestions': tradingSuggestions?.toJson(),
  };
}

class Indicators {
  Indicators({
    required this.movingAverages,
    required this.rsi,
    required this.macd,
    required this.bollingerBands,
  });

  factory Indicators.fromJson(Map<String, dynamic> json) {
    return Indicators(
      movingAverages: MovingAverages.fromJson(
        _requireMap(json['moving_averages'], 'indicators.moving_averages'),
      ),
      rsi: _requireDouble(json['rsi'], 'indicators.rsi'),
      macd: Macd.fromJson(_requireMap(json['macd'], 'indicators.macd')),
      bollingerBands: BollingerBands.fromJson(
        _requireMap(json['bollinger_bands'], 'indicators.bollinger_bands'),
      ),
    );
  }

  final MovingAverages movingAverages;
  final double rsi;
  final Macd macd;
  final BollingerBands bollingerBands;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'moving_averages': movingAverages.toJson(),
    'rsi': rsi,
    'macd': macd.toJson(),
    'bollinger_bands': bollingerBands.toJson(),
  };
}

class MovingAverages {
  MovingAverages({
    required this.sma10,
    required this.sma20,
    required this.sma50,
    required this.priceVsSma50,
  });

  factory MovingAverages.fromJson(Map<String, dynamic> json) {
    return MovingAverages(
      sma10: _requireDouble(json['sma_10'], 'moving_averages.sma_10'),
      sma20: _requireDouble(json['sma_20'], 'moving_averages.sma_20'),
      sma50: _requireDouble(json['sma_50'], 'moving_averages.sma_50'),
      priceVsSma50: _requireDouble(
        json['price_vs_sma50'],
        'moving_averages.price_vs_sma50',
      ),
    );
  }

  final double sma10;
  final double sma20;
  final double sma50;
  final double priceVsSma50;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'sma_10': sma10,
    'sma_20': sma20,
    'sma_50': sma50,
    'price_vs_sma50': priceVsSma50,
  };
}

class Macd {
  Macd({
    required this.macdLine,
    required this.signalLine,
    required this.histogram,
  });

  factory Macd.fromJson(Map<String, dynamic> json) {
    return Macd(
      macdLine: _requireDouble(json['macd_line'], 'macd.macd_line'),
      signalLine: _requireDouble(json['signal_line'], 'macd.signal_line'),
      histogram: _requireDouble(json['histogram'], 'macd.histogram'),
    );
  }

  final double macdLine;
  final double signalLine;
  final double histogram;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'macd_line': macdLine,
    'signal_line': signalLine,
    'histogram': histogram,
  };
}

class BollingerBands {
  BollingerBands({
    required this.upper,
    required this.middle,
    required this.lower,
    required this.pricePosition,
  });

  factory BollingerBands.fromJson(Map<String, dynamic> json) {
    return BollingerBands(
      upper: _requireDouble(json['upper'], 'bollinger_bands.upper'),
      middle: _requireDouble(json['middle'], 'bollinger_bands.middle'),
      lower: _requireDouble(json['lower'], 'bollinger_bands.lower'),
      pricePosition: _requireDouble(
        json['price_position'],
        'bollinger_bands.price_position',
      ),
    );
  }

  final double upper;
  final double middle;
  final double lower;
  final double pricePosition;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'upper': upper,
    'middle': middle,
    'lower': lower,
    'price_position': pricePosition,
  };
}

class Signals {
  Signals({
    required this.maCross,
    required this.maTrend,
    required this.rsi,
    required this.macd,
    required this.bollinger,
  });

  factory Signals.fromJson(Map<String, dynamic> json) {
    return Signals(
      maCross: parseEnum<Recommendation>(
        json['ma_cross'],
        recommendationValues,
        'signals.ma_cross',
      ),
      maTrend: parseEnum<MaTrend>(
        json['ma_trend'],
        maTrendValues,
        'signals.ma_trend',
      ),
      rsi: parseEnum<Rsi>(json['rsi'], rsiValues, 'signals.rsi'),
      macd: parseEnum<Recommendation>(
        json['macd'],
        recommendationValues,
        'signals.macd',
      ),
      bollinger: parseEnum<Bollinger>(
        json['bollinger'],
        bollingerValues,
        'signals.bollinger',
      ),
    );
  }

  final Recommendation maCross;
  final MaTrend maTrend;
  final Rsi rsi;
  final Recommendation macd;
  final Bollinger bollinger;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'ma_cross': maCross.apiValue,
    'ma_trend': maTrend.apiValue,
    'rsi': rsi.apiValue,
    'macd': macd.apiValue,
    'bollinger': bollinger.apiValue,
  };
}

class CurrentPrice {
  CurrentPrice({required this.bid, required this.ask, required this.spread});

  factory CurrentPrice.fromJson(Map<String, dynamic> json) {
    return CurrentPrice(
      bid: _requireDouble(json['bid'], 'current_price.bid'),
      ask: _requireDouble(json['ask'], 'current_price.ask'),
      spread: _requireInt(json['spread'], 'current_price.spread'),
    );
  }

  final double bid;
  final double ask;
  final int spread;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'bid': bid,
    'ask': ask,
    'spread': spread,
  };
}

class TradingSuggestions {
  TradingSuggestions({
    required this.stopLoss,
    required this.takeProfit,
    required this.volatility,
    required this.keyLevels,
    required this.riskReward,
  });

  factory TradingSuggestions.fromJson(Map<String, dynamic> json) {
    return TradingSuggestions(
      stopLoss: _requireDouble(
        json['stop_loss'],
        'trading_suggestions.stop_loss',
      ),
      takeProfit: RiskReward.fromJson(
        _requireMap(json['take_profit'], 'trading_suggestions.take_profit'),
      ),
      volatility: Volatility.fromJson(
        _requireMap(json['volatility'], 'trading_suggestions.volatility'),
      ),
      keyLevels: KeyLevels.fromJson(
        _requireMap(json['key_levels'], 'trading_suggestions.key_levels'),
      ),
      riskReward: RiskReward.fromJson(
        _requireMap(json['risk_reward'], 'trading_suggestions.risk_reward'),
      ),
    );
  }

  final double stopLoss;
  final RiskReward takeProfit;
  final Volatility volatility;
  final KeyLevels keyLevels;
  final RiskReward riskReward;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'stop_loss': stopLoss,
    'take_profit': takeProfit.toJson(),
    'volatility': volatility.toJson(),
    'key_levels': keyLevels.toJson(),
    'risk_reward': riskReward.toJson(),
  };
}

class KeyLevels {
  KeyLevels({
    required this.recentHigh,
    required this.recentLow,
    required this.swingHigh,
    required this.swingLow,
  });

  factory KeyLevels.fromJson(Map<String, dynamic> json) {
    return KeyLevels(
      recentHigh: _requireDouble(json['recent_high'], 'key_levels.recent_high'),
      recentLow: _requireDouble(json['recent_low'], 'key_levels.recent_low'),
      swingHigh: _requireDouble(json['swing_high'], 'key_levels.swing_high'),
      swingLow: _requireDouble(json['swing_low'], 'key_levels.swing_low'),
    );
  }

  final double recentHigh;
  final double recentLow;
  final double swingHigh;
  final double swingLow;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'recent_high': recentHigh,
    'recent_low': recentLow,
    'swing_high': swingHigh,
    'swing_low': swingLow,
  };
}

class RiskReward {
  RiskReward({
    required this.atrBased,
    required this.keyLevel,
    required this.fibonacci,
  });

  factory RiskReward.fromJson(Map<String, dynamic> json) {
    return RiskReward(
      atrBased: _requireDouble(json['atr_based'], 'risk_reward.atr_based'),
      keyLevel: _requireDouble(json['key_level'], 'risk_reward.key_level'),
      fibonacci: _requireDouble(json['fibonacci'], 'risk_reward.fibonacci'),
    );
  }

  final double atrBased;
  final double keyLevel;
  final double fibonacci;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'atr_based': atrBased,
    'key_level': keyLevel,
    'fibonacci': fibonacci,
  };
}

class Volatility {
  Volatility({required this.atr, required this.dailyRange});

  factory Volatility.fromJson(Map<String, dynamic> json) {
    return Volatility(
      atr: _requireDouble(json['atr'], 'volatility.atr'),
      dailyRange: _requireDouble(json['daily_range'], 'volatility.daily_range'),
    );
  }

  final double atr;
  final double dailyRange;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'atr': atr,
    'daily_range': dailyRange,
  };
}

String _requireString(Object? value, String fieldName) {
  if (value is! String) {
    throw FormatException('Expected a string for .');
  }
  return value;
}

Map<String, dynamic> _requireMap(Object? value, String fieldName) {
  if (value is! Map<String, dynamic>) {
    throw FormatException('Expected an object for .');
  }
  return value;
}

List<Object?> _requireList(Object? value, String fieldName) {
  if (value is! List<Object?>) {
    throw FormatException('Expected a list for .');
  }
  return value;
}

double _requireDouble(Object? value, String fieldName) {
  if (value is num) {
    return value.toDouble();
  }
  throw FormatException('Expected a number for .');
}

int _requireInt(Object? value, String fieldName) {
  if (value is num) {
    return value.toInt();
  }
  throw FormatException('Expected an integer for .');
}

DateTime _requireDateTime(Object? value, String fieldName) {
  final String rawValue = _requireString(value, fieldName);
  final String normalized = rawValue.contains('T')
      ? rawValue
      : rawValue.replaceFirst(' ', 'T');
  return DateTime.parse(normalized);
}
