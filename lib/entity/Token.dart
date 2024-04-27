import 'package:fl_chart/fl_chart.dart';

class Token {
  final String name;
  final String symbol;
  String? description;
  final String image;
  final String id;
  final double currentPrice;
  FlSpot? priceData;

  Token({
    required this.name,
    required this.symbol,
    required this.image,
    required this.id,
    required this.currentPrice,
    this.description,
    this.priceData,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        name: json['name'],
        symbol: json['symbol'],
        image: json['image'],
        id: json['id'],
        currentPrice: json['current_price'].toDouble(),
        // description: json['description']['en'],
      );
}
