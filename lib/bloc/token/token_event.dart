part of 'token_bloc.dart';

abstract class TokenEvent {}

class LoadTokens extends TokenEvent {}

class SearchTokens extends TokenEvent {
  final String query;

  SearchTokens(this.query);
}

class SelectToken extends TokenEvent {
  final Token token;

  SelectToken(this.token);
}

class FetchTokenPriceData extends TokenEvent {
  final String tokenId;

  FetchTokenPriceData(this.tokenId);
}
