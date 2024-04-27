import 'package:crypto_watcher/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CwContainer extends StatelessWidget {
  final Widget child;
  const CwContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.read<ThemeCubit>().state.colorScheme;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
