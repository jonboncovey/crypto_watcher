import 'package:crypto_watcher/entity/Token.dart';
import 'package:crypto_watcher/repository/token_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class TokenState {
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
}

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final TokenRepository tokenRepository;

  TokenBloc({required this.tokenRepository})
      : super(TokenState(
            allTokens: [],
            selectedToken:
                Token(name: '', symbol: '', image: '', id: '', currentPrice: 0),
            filteredTokens: [],
            selectedTokenPriceData: [],
            isLoading: false)) {
    on<LoadTokens>((event, emit) => _onGetAllTokens(event, emit));
    on<SearchTokens>((event, emit) => _onSearchTokens(event, emit));
    on<SelectToken>((event, emit) => _onSelectToken(event, emit));
    on<FetchTokenPriceData>(
        (event, emit) => _onFetchTokenPriceData(event, emit));
  }

  _onGetAllTokens(LoadTokens event, Emitter<TokenState> emit) async {
    _publishState(emit, isLoading: true);
    final tokens = await tokenRepository.getTokenList();
    _publishState(emit, allTokens: tokens, filteredTokens: tokens);
  }

  _onFetchTokenPriceData(
      FetchTokenPriceData event, Emitter<TokenState> emit) async {
    final tokenPriceData =
        await tokenRepository.fetchTokenPriceData(event.tokenId);
    _publishState(emit, selectedTokenPriceData: tokenPriceData);
  }

  _onSearchTokens(SearchTokens event, Emitter<TokenState> emit) async {
    var filteredTokens = state.allTokens
        .where((token) =>
            token.name.toLowerCase().contains(event.query.toLowerCase()) ||
            token.symbol.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    if (event.query.isEmpty) {
      _publishState(emit, filteredTokens: state.allTokens);
    } else {
      _publishState(emit, filteredTokens: filteredTokens);
    }
  }

  _onSelectToken(SelectToken event, Emitter<TokenState> emit) async {
    _publishState(emit, isLoading: true);

    final selectedToken = await tokenRepository.getTokenDetails(event.token.id);
    final tokenPriceData =
        await tokenRepository.fetchTokenPriceData(event.token.id);

    event.token.description = selectedToken['description']['en'];

    _publishState(
      emit,
      selectedToken: event.token,
      selectedTokenPriceData: tokenPriceData,
    );
  }

  void _publishState(
    Emitter<TokenState> emit, {
    List<Token>? allTokens,
    Token? selectedToken,
    List<Token>? filteredTokens,
    List<FlSpot>? selectedTokenPriceData,
    bool? isLoading,
  }) {
    emit(TokenState(
      allTokens: allTokens ?? state.allTokens,
      selectedToken: selectedToken ?? state.selectedToken,
      filteredTokens: filteredTokens ?? state.filteredTokens,
      selectedTokenPriceData:
          selectedTokenPriceData ?? state.selectedTokenPriceData,
      isLoading: isLoading ?? false,
    ));
  }
}
