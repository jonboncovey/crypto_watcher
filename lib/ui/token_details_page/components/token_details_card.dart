import 'package:crypto_watcher/bloc/token/token_bloc.dart';
import 'package:crypto_watcher/ui/core/cw_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenDetailsCard extends StatelessWidget {
  const TokenDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CwContainer(
      child: BlocBuilder<TokenBloc, TokenState>(builder: (context, state) {
        if (state.status == TokenStateStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == TokenStateStatus.error) {
          return const Center(child: Text('Error Loading Token Details >.<'));
        }
        return Column(children: [
          Row(
            children: [
              Image.network(state.selectedToken.image, width: 42),
              const SizedBox(width: 8),
              Text(
                '${state.selectedToken.name} (${state.selectedToken.symbol.toUpperCase()})',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                '\$${state.selectedToken.currentPrice.toString()}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ]);
      }),
    );
  }
}
