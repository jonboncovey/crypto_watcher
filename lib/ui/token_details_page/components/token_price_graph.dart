import 'package:crypto_watcher/bloc/token/token_bloc.dart';
import 'package:crypto_watcher/ui/core/cw_container.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceChart extends StatelessWidget {
  const PriceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CwContainer(
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: BlocBuilder<TokenBloc, TokenState>(builder: (context, state) {
          ColorScheme colorScheme = Theme.of(context).colorScheme;
          if (state.status == TokenStateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == TokenStateStatus.error) {
            return const Center(child: Text('Error Loading Price Graph >.>'));
          }

          return LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  color: colorScheme.primary,
                  spots: state.selectedToken.priceData ?? [],
                  isCurved: true,
                  barWidth: 2,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
