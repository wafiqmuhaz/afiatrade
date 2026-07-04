const String analysisResponseFixture = '''
{
  "result": "success",
  "message": [
    {
      "symbol": "EURUSD",
      "timeframe": "H1",
      "analysis": {
        "indicators": {
          "moving_averages": {
            "sma_10": 1.14405,
            "sma_20": 1.14434,
            "sma_50": 1.14235,
            "price_vs_sma50": 0.0012
          },
          "rsi": 30.54,
          "macd": {
            "macd_line": 0.00026,
            "signal_line": 0.00051,
            "histogram": -0.00025
          },
          "bollinger_bands": {
            "upper": 1.14558,
            "middle": 1.14434,
            "lower": 1.14309,
            "price_position": 0.18
          }
        },
        "signals": {
          "ma_cross": "neutral",
          "ma_trend": "bullish",
          "rsi": "neutral",
          "macd": "neutral",
          "bollinger": "neutral"
        },
        "recommendation": "buy",
        "last_update": "2026-07-04 03:17:07",
        "current_price": {
          "bid": 1.14355,
          "ask": 1.1438,
          "spread": 25
        },
        "trading_suggestions": {
          "stop_loss": 1.13474,
          "take_profit": {
            "atr_based": 1.1577,
            "key_level": 1.14729,
            "fibonacci": 1.14041
          },
          "volatility": {
            "atr": 0.00708,
            "daily_range": 0.00086
          },
          "key_levels": {
            "recent_high": 1.14729,
            "recent_low": 1.13616,
            "swing_high": 1.14729,
            "swing_low": 1.13616
          },
          "risk_reward": {
            "atr_based": 1.61,
            "key_level": 0.42,
            "fibonacci": -0.36
          }
        }
      }
    }
  ]
}
''';

const String analysisResponseWithoutSuggestionsFixture = '''
{
  "result": "success",
  "message": [
    {
      "symbol": "USDCAD",
      "timeframe": "H1",
      "analysis": {
        "indicators": {
          "moving_averages": {
            "sma_10": 1.41997,
            "sma_20": 1.41873,
            "sma_50": 1.41937,
            "price_vs_sma50": 0.00046
          },
          "rsi": 77.31,
          "macd": {
            "macd_line": 0.00037,
            "signal_line": 0.00016,
            "histogram": 0.0002
          },
          "bollinger_bands": {
            "upper": 1.42151,
            "middle": 1.41873,
            "lower": 1.41595,
            "price_position": 0.7
          }
        },
        "signals": {
          "ma_cross": "neutral",
          "ma_trend": "bullish",
          "rsi": "overbought",
          "macd": "neutral",
          "bollinger": "neutral"
        },
        "recommendation": "neutral",
        "last_update": "2026-07-04 03:17:07",
        "current_price": {
          "bid": 1.41983,
          "ask": 1.42084,
          "spread": 101
        },
        "trading_suggestions": null
      }
    }
  ]
}
''';

const String malformedAnalysisResponseFixture =
    '{"result":"success","message":"broken"}';
