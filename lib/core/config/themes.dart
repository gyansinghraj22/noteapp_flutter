import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: "Inter",
      useMaterial3: false,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF8644D4),
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
    );
  }
}
