import 'package:crypto_watcher/entity/Token.dart';
import 'package:crypto_watcher/repository/token_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'token_event.dart';
part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final TokenRepository tokenRepository;

  TokenBloc({required this.tokenRepository})
      : super(TokenState(
            allTokens: const [],
            selectedToken: Token(
              name: '',
              symbol: '',
              image: '',
              id: '',
              currentPrice: 0,
              description: '',
            ),
            filteredTokens: const [],
            status: TokenStateStatus.loading)) {
    on<LoadTokens>((event, emit) => _onGetAllTokens(event, emit));
    on<SearchTokens>((event, emit) => _onSearchTokens(event, emit));
    on<SelectToken>((event, emit) => _onSelectToken(event, emit));
  }

  _onGetAllTokens(LoadTokens event, Emitter<TokenState> emit) async {
    _publishState(emit, status: TokenStateStatus.loading);

    final List<Token> tokens = await tokenRepository.getTokenList();

    _publishState(emit, allTokens: tokens, filteredTokens: tokens);
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
    _publishState(
      emit,
      status: TokenStateStatus.loading,
      selectedToken: Token(
        name: '',
        symbol: '',
        image: '',
        id: '',
        currentPrice: 0,
        description: '',
      ),
    );

    try {
      final tokenPriceData =
          await tokenRepository.fetchTokenPriceData(event.token.id);
      final tokenDetails =
          await tokenRepository.getTokenDetails(event.token.id);

      event.token.description = tokenDetails['description']['en'];
      event.token.priceData = tokenPriceData;

      _publishState(
        emit,
        selectedToken: event.token,
      );
    } catch (e) {
      _publishState(emit, status: TokenStateStatus.error);
    }
  }

  void _publishState(
    Emitter<TokenState> emit, {
    List<Token>? allTokens,
    Token? selectedToken,
    List<Token>? filteredTokens,
    TokenStateStatus? status,
  }) {
    emit(TokenState(
      allTokens: allTokens ?? state.allTokens,
      selectedToken: selectedToken ?? state.selectedToken,
      filteredTokens: filteredTokens ?? state.filteredTokens,
      status: status ?? TokenStateStatus.loaded,
    ));
  }
}
