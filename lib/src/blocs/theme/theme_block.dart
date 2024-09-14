import 'package:bloc/bloc.dart';
import 'package:exchange_app/src/blocs/theme/theme_event.dart';
import 'package:exchange_app/src/blocs/theme/theme_state.dart';
import 'package:exchange_app/src/repositories/theme_repository.dart';
import 'package:flutter/material.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepository _themeRepository;

  ThemeBloc(this._themeRepository)
      : super(ThemeInitial(themeMode: ThemeMode.system)) {
    on<ToggleTheme>(_onToggleTheme);
    _loadTheme();
  }

  Future<void> _onToggleTheme(
      ToggleTheme event, Emitter<ThemeState> emit) async {
    final themeMode = event.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeInitial(themeMode: themeMode));

    await _themeRepository.setThemeMode(event.isDarkMode);
  }



  Future<void> _loadTheme() async {
    final isDarkMode = await _themeRepository.getThemeMode();
    add(ToggleTheme(isDarkMode: isDarkMode));
  }
}
