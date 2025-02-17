import 'package:app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppPalette.primaryColor,
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.backgroundColor,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppPalette.primaryColor,
      secondary: AppPalette.primaryColor,
      surfaceBright: AppPalette.backgroundColor,
      surface: AppPalette.backgroundColor,
    ),
    fontFamily: 'Cairo',
  );
}
