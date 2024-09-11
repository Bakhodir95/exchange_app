import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleTheme extends ThemeEvent {
  final bool isDarkMode;

  ToggleTheme({required this.isDarkMode});

  @override
  List<Object?> get props => [isDarkMode];
}
