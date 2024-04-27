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
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _quantityController,
              onChanged: (_) =>
                  _updateQuantity(state.selectedToken.currentPrice),
              decoration: const InputDecoration(
                labelText: 'Quantity',
                prefixIcon: Icon(Icons.confirmation_number),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        );
      }),
    );
  }
}
