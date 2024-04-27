import 'package:fl_chart/fl_chart.dart';

class Token {
  final String name;
  final String symbol;
  final String image;
  final String id;
  final double currentPrice;
  String? description;
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
      );
}
