import 'package:crypto_watcher/entity/Token.dart';

class FakeBitcoin extends Token {
  FakeBitcoin() : super(
      name: 'Bitcoin',
      symbol: 'BTC',
      image: 'bitcoin.png',
      id: 'bitcoin',
      currentPrice: 50000);
}

class FakeEthereum extends Token {
  FakeEthereum() : super(
      name: 'Ethereum',
      symbol: 'ETH',
      image: 'ethereum.png',
      id: 'ethereum',
      currentPrice: 3000);
}