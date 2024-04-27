import 'package:crypto_watcher/bloc/token/token_bloc.dart';
import 'package:crypto_watcher/ui/token_details_page/components/conversion_calculator.dart';
import 'package:crypto_watcher/ui/token_details_page/components/expandable_text.dart';
import 'package:crypto_watcher/ui/token_details_page/components/token_details_card.dart';
import 'package:crypto_watcher/ui/token_details_page/components/token_price_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenDetailsScreen extends StatelessWidget {
  const TokenDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: BlocBuilder<TokenBloc, TokenState>(builder: (context, state) {
            if (state.status == TokenStateStatus.error) {
              return const Center(child: Text('Error Loading Token Details >.<'));
            }
            return Text(
              state.selectedToken.name,
              style: Theme.of(context).textTheme.headlineMedium,
            );
          }),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const TokenDetailsCard(),
            const SizedBox(height: 16),
            const PriceChart(),
            const SizedBox(height: 16),
            ExpandableText(
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            const ConversionCalculator()
          ],
        ));
  }
}
