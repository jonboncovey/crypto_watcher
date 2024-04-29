import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const seedColor = Color.fromARGB(255, 34, 124, 16);

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: seedColor,
  brightness: Brightness.light,
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: seedColor,
  brightness: Brightness.dark,
);

final lightTheme = ThemeData(
  fontFamily: 'OpenSans',
  colorScheme: lightColorScheme,
);
final darkTheme = ThemeData(
  fontFamily: 'OpenSans',
  colorScheme: darkColorScheme,
);

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(darkTheme);

  void toggleTheme() {
    emit(state.brightness == Brightness.light ? darkTheme : lightTheme);
  }
}
