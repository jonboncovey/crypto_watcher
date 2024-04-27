import 'package:crypto_watcher/entity/Token.dart';
import 'package:crypto_watcher/repository/token_repository.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'token_repository_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late TokenRepository tokenRepository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    tokenRepository = TokenRepository(mockDio);
  });

  group('getTokenList', () {
    test('returns list of tokens on successful API call', () async {
      final responseData = [
        {'name': 'Bitcoin', 'symbol': 'btc', 'image': 'bitcoin.png', 'id': 'bitcoin', 'current_price': 50000.0},
        {'name': 'Ethereum', 'symbol': 'eth', 'image': 'ethereum.png', 'id': 'ethereum', 'current_price': 3000.0},
      ];
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(data: responseData, statusCode: 200, requestOptions: RequestOptions(data: responseData)));

      final result = await tokenRepository.getTokenList();

      expect(result, isA<List<Token>>());
      expect(result.length, 2);
      expect(result[0].name, 'Bitcoin');
      expect(result[1].name, 'Ethereum');
    });

    test('throws exception on API call error', () {
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(() => tokenRepository.getTokenList(), throwsException);
    });
  });

  group('getTokenDetails', () {
    test('returns token details on successful API call', () async {
      final responseData = {'name': 'Bitcoin', 'symbol': 'btc', 'description': {'en': 'Bitcoin description'}};
      when(mockDio.get(any)).thenAnswer((_) async => Response(data: responseData, statusCode: 200, requestOptions: RequestOptions(data: responseData)));

      final result = await tokenRepository.getTokenDetails('bitcoin');

      expect(result, isA<Map<String, dynamic>>());
      expect(result['name'], 'Bitcoin');
      expect(result['description']['en'], 'Bitcoin description');
    });

    test('throws exception on API call error', () {
      when(mockDio.get(any)).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(() => tokenRepository.getTokenDetails('bitcoin'), throwsException);
    });
  });

  group('fetchTokenPriceData', () {
    test('returns list of FlSpot on successful API call', () async {
      final responseData = {'prices': [
        [1685232000000, 27000.123456789012],
        [1685318400000, 27100.123456789012],
      ]};
      when(mockDio.get(any)).thenAnswer((_) async => Response(data: responseData, statusCode: 200, requestOptions: RequestOptions(data: responseData)));

      final result = await tokenRepository.fetchTokenPriceData('bitcoin');

      expect(result, isA<List<FlSpot>>());
      expect(result.length, 2);
      expect(result[0].x, 0);
      expect(result[0].y, 27000.123456789012);
      expect(result[1].x, 1);
      expect(result[1].y, 27100.123456789012);
    });

    test('throws exception on API call error', () {
      when(mockDio.get(any)).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(() => tokenRepository.fetchTokenPriceData('bitcoin'), throwsException);
    });
  });
}