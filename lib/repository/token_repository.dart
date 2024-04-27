import 'package:crypto_watcher/entity/Token.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';

class TokenRepository {
  final Dio _dio;

  TokenRepository(this._dio);

  Future<List<Token>> getTokenList() async {
    final response = await _dio.get(
      'https://api.coingecko.com/api/v3/coins/markets',
      queryParameters: {'vs_currency': 'usd'},
    );
    print(response.data[0]['image']);
    List<Token> tokens = response.data
        .map<Token>((token) => Token.fromJson(token))
        .toList(); // for (Token token in tokens) {
    //   token.priceData = await fetchTokenPriceData(token.id);
    // }
    return tokens;
  }

  Future<Map<String, dynamic>> getTokenDetails(String id) async {
    final response =
        await _dio.get('https://api.coingecko.com/api/v3/coins/$id');
    return response.data;
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
        throw Exception('Failed to load token price data');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}
