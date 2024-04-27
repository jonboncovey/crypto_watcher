import 'package:crypto_watcher/bloc/token/token_bloc.dart';
import 'package:crypto_watcher/ui/token_list_page/components/token_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenListScreen extends StatelessWidget {
  const TokenListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                BlocProvider.of<TokenBloc>(context).add(SearchTokens(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search tokens...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child:
                BlocBuilder<TokenBloc, TokenState>(builder: (context, state) {
              if (state.status == TokenStateStatus.error) {
                return const Center(
                    child: Text('Error Loading Token List >.<'));
              }
              return ListView.builder(
                itemCount: state.filteredTokens.length,
                itemBuilder: (context, index) {
                  final token = state.filteredTokens[index];
                  return TokenListItem(token: token);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
