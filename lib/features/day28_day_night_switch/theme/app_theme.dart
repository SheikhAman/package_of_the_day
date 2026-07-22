import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color(0xFFF7F7FB),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF7F7FB),
      foregroundColor: Colors.black87,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF6C5CE7)),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF15202B),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF15202B),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF6C5CE7),
      brightness: Brightness.dark,
    ),
  );
}
