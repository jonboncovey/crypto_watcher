import 'package:crypto_watcher/bloc/token/token_bloc.dart';
import 'package:crypto_watcher/entity/Token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenListItem extends StatelessWidget {
  final Token token;
  const TokenListItem({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.25),
        child: Image.network(token.image),
      ),
      title: Text(token.name),
      subtitle: Text('\$${token.symbol.toUpperCase()}'),
      trailing: Text(
        '\$${token.currentPrice.toString()}',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      ),
      onTap: () {
        BlocProvider.of<TokenBloc>(context).add(SelectToken(token));
        Navigator.pushNamed(context, '/details');
      },
    );
  }
}
