part of 'token_bloc.dart';

class TokenState extends Equatable {
  final List<Token> allTokens;
  final List<Token> filteredTokens;
  final Token selectedToken;
  final List<FlSpot> selectedTokenPriceData;
  final bool isLoading;

  TokenState({
    required this.allTokens,
    required this.selectedToken,
    required this.filteredTokens,
    required this.selectedTokenPriceData,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [
        allTokens,
        selectedToken,
        filteredTokens,
        selectedTokenPriceData,
        isLoading,
      ];
}
