import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ThemeInitial extends ThemeState {
  final ThemeMode themeMode;

  ThemeInitial({required this.themeMode});

  @override
  List<Object?> get props => [themeMode];
}
