part of 'token_bloc.dart';

enum TokenStateStatus {
  loading,
  loaded,
  error,
}

class TokenState extends Equatable {
  final List<Token> allTokens;
  final List<Token> filteredTokens;
  final Token selectedToken;
  final TokenStateStatus status;

  const TokenState({
    required this.allTokens,
    required this.selectedToken,
    required this.filteredTokens,
    required this.status,
  });

  @override
  List<Object?> get props => [
        allTokens,
        selectedToken,
        filteredTokens,
        status,
      ];
}
