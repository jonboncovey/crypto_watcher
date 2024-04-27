import 'package:crypto_watcher/entity/Token.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';

class TokenRepository {
  final Dio _dio;

  TokenRepository(this._dio);

  Future<List<Token>> getTokenList() async {
    var url = 'https://api.coingecko.com/api/v3/coins/markets';

    try {
      final response = await _dio.get(
        url,
        queryParameters: {'vs_currency': 'usd'},
      );
      if (response.statusCode == 200) {
        List<Token> tokens =
            response.data.map<Token>((token) => Token.fromJson(token)).toList();
        return tokens;
      } else {
        throw Exception(
            'Failed to load token list, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Dio error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getTokenDetails(String id) async {
    var url = 'https://api.coingecko.com/api/v3/coins/$id';

    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to load token details, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Dio error: ${e.toString()}');
    }
  }

  Future<List<FlSpot>> fetchTokenPriceData(String tokenId) async {
    var url =
        'https://api.coingecko.com/api/v3/coins/$tokenId/market_chart?vs_currency=usd&days=30&interval=daily';
    try {
      var response = await _dio.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = response.data;
        List<dynamic> prices = jsonResponse['prices'];
        List<FlSpot> spots = prices.map((price) {
          int index = prices.indexOf(price);
          double priceValue = price[1];
          return FlSpot(index.toDouble(), priceValue);
        }).toList();
        return spots;
      } else {
        throw Exception(
            'Failed to load token price data, status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}
