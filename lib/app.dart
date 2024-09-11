import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_app/main.dart';
import 'package:exchange_app/src/blocs/theme/theme_block.dart';
import 'package:exchange_app/src/blocs/theme/theme_state.dart';
import 'package:exchange_app/src/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Echange App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
          ),
          themeMode: (state as ThemeInitial).themeMode,
          home: const ExchangeRateScreen(),
        );
      },
    );
  }
}
