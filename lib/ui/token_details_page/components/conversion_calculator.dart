import 'package:crypto_watcher/bloc/token/token_bloc.dart';
import 'package:crypto_watcher/ui/core/cw_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversionCalculator extends StatefulWidget {
  const ConversionCalculator({super.key});

  @override
  _ConversionCalculatorState createState() => _ConversionCalculatorState();
}

class _ConversionCalculatorState extends State<ConversionCalculator> {
  late TextEditingController _usdController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _usdController = TextEditingController();
    _quantityController = TextEditingController();
  }

  @override
  void dispose() {
    _usdController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _updatePrice(double currentPrice) {
    final usd = double.tryParse(_usdController.text) ?? 0;
    final quantity = usd / currentPrice;
    _quantityController.text = quantity.toStringAsFixed(8);
  }

  void _updateQuantity(double currentPrice) {
    final quantity = double.tryParse(_quantityController.text) ?? 0;
    final usd = quantity * currentPrice;
    _usdController.text = usd.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return CwContainer(
      child: BlocBuilder<TokenBloc, TokenState>(builder: (context, state) {
        return Column(
          children: [
            TextField(
              controller: _usdController,
              onChanged: (_) => _updatePrice(state.selectedToken.currentPrice),
              decoration: const InputDecoration(
                labelText: 'USD',
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      height: 1,
                      color: Theme.of(context).colorScheme.background),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.currency_exchange,
                      color: Theme.of(context).colorScheme.background),
                ),
                Expanded(
                  child: Container(
                      height: 1,
                      color: Theme.of(context).colorScheme.background),
                ),
              ],
            ),
            TextField(
              controller: _quantityController,
              onChanged: (_) =>
                  _updateQuantity(state.selectedToken.currentPrice),
              decoration: InputDecoration(
                labelText: state.selectedToken.symbol.toUpperCase(),
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ],
        );
      }),
    );
  }
}
