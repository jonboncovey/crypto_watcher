import 'package:crypto_watcher/bloc/token/token_bloc.dart';
import 'package:crypto_watcher/ui/token_list_page/components/token_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Token List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                print('hit');
                BlocProvider.of<TokenBloc>(context).add(SearchTokens(query));
              },
              decoration: InputDecoration(
                hintText: 'Search tokens...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child:
                BlocBuilder<TokenBloc, TokenState>(builder: (context, state) {
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
