import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_watcher/bloc/token/token_bloc.dart';
import 'package:crypto_watcher/entity/Token.dart';
import 'package:crypto_watcher/repository/token_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'token_bloc_test.mocks.dart';

@GenerateMocks([TokenRepository])
void main() {
  group('TokenBloc Tests', () {
    late TokenBloc tokenBloc;
    late MockTokenRepository mockTokenRepository;

    setUp(() {
      mockTokenRepository = MockTokenRepository();
      tokenBloc = TokenBloc(tokenRepository: mockTokenRepository);
    });

    blocTest<TokenBloc, TokenState>(
      'emits [TokenState] with loaded tokens when LoadTokens is added',
      build: () {
        when(mockTokenRepository.getTokenList()).thenAnswer((_) async => [
          Token(name: 'Bitcoin', symbol: 'BTC', image: 'bitcoin.png', id: 'bitcoin', currentPrice: 50000),
          Token(name: 'Ethereum', symbol: 'ETH', image: 'ethereum.png', id: 'ethereum', currentPrice: 3000),
        ]);
        return tokenBloc;
      },
      act: (bloc) => bloc.add(LoadTokens()),
      expect: () => [
        isA<TokenState>().having((s) => s.isLoading, 'isLoading', true),
        isA<TokenState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having((s) => s.allTokens, 'allTokens', isNotEmpty),
      ],
    );
  });
}