import 'package:crypto_watcher/bloc/theme_cubit.dart';
import 'package:crypto_watcher/bloc/token/token_bloc.dart';
import 'package:crypto_watcher/ui/token_details_page/token_details_page.dart';
import 'package:crypto_watcher/ui/token_list_page/token_list_page.dart';
import 'package:crypto_watcher/repository/token_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TokenRepository(Dio()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider(
              create: (context) => TokenBloc(
                    tokenRepository:
                        RepositoryProvider.of<TokenRepository>(context),
                  )..add(LoadTokens())),
        ],
        child: BlocBuilder<ThemeCubit, ThemeData>(builder: (context, theme) {
          return MaterialApp(
            theme: theme,
            title: 'Token App',
            initialRoute: '/',
            routes: {
              '/': (context) => TokenListScreen(),
              '/details': (context) => TokenDetailsScreen(),
            },
          );
        }),
      ),
    );
  }
}
