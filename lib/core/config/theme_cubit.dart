import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/core/utils/shared_pref.dart';

enum AppThemeMode { light, dark, system }

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_getInitialTheme()) {
    _loadTheme();
  }

  static const String _themeKey = 'theme_mode';
  AppThemeMode _currentThemeMode = AppThemeMode.system;

  AppThemeMode get currentThemeMode => _currentThemeMode;

  static ThemeData _getInitialTheme() {
    // Default to system theme initially
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark
        ? AppThemes.darkTheme
        : AppThemes.lightTheme;
  }

  void _loadTheme() async {
    final savedTheme = SharedPref.getStringValue(_themeKey);
    if (savedTheme.isNotEmpty) {
      _currentThemeMode = AppThemeMode.values.firstWhere(
        (mode) => mode.name == savedTheme,
        orElse: () => AppThemeMode.system,
      );
    } else {
      _currentThemeMode = AppThemeMode.system;
    }
    _updateTheme();
  }

  void _updateTheme() {
    switch (_currentThemeMode) {
      case AppThemeMode.light:
        emit(AppThemes.lightTheme);
        break;
      case AppThemeMode.dark:
        emit(AppThemes.darkTheme);
        break;
      case AppThemeMode.system:
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        emit(
          brightness == Brightness.dark
              ? AppThemes.darkTheme
              : AppThemes.lightTheme,
        );
        break;
    }
  }

  void setTheme(AppThemeMode themeMode) async {
    _currentThemeMode = themeMode;
    await SharedPref.setStringValue(_themeKey, themeMode.name);
    _updateTheme();
  }

  void toggleTheme() {
    final newMode =
        _currentThemeMode == AppThemeMode.light
            ? AppThemeMode.dark
            : AppThemeMode.light;
    setTheme(newMode);
  }

  bool get isDarkMode {
    return state.brightness == Brightness.dark;
  }

  bool get isLightMode {
    return state.brightness == Brightness.light;
  }
}

// Enhanced AppThemes class
class AppThemes {
  // Brand Colors
  static const Color primaryColor = Color(0xFF1DC7F2);
  static const Color primaryDarkColor = Color(0xFF0891B2);
  static const Color accentColor = Color(0xFF8B5CF6);

  // Light Theme Colors - Inspired by minimalist design
  static const Color lightBackground = Color(0xFFFAF9F6); // Warm off-white
  static const Color lightSurface = Color(0xFFF5F4F0); // Subtle warm gray
  static const Color lightCardColor = Color(0xFFFFFFFF); // Pure white cards
  static const Color lightTextPrimary = Color(0xFF1A1A1A); // Deep charcoal
  static const Color lightTextSecondary = Color(0xFF6B7280); // Soft gray
  static const Color lightBorder = Color(0xFFE5E7EB); // Light border
  static const Color lightAccent = Color(0xFF8B9DC3); // Soft blue-gray

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCardColor = Color(0xFF334155);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkBorder = Color(0xFF475569);

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: "Inter",
      useMaterial3: true,
      brightness: Brightness.light,

      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        primaryContainer: Color(0xFFE0F7FF),
        secondary: lightAccent,
        secondaryContainer: Color(0xFFF1F3F6),
        surface: lightSurface,
        surfaceContainerHighest: lightCardColor,
        background: lightBackground,
        error: Color(0xFFDC2626),
        onPrimary: Colors.white,
        onSecondary: lightTextPrimary,
        onSurface: lightTextPrimary,
        onBackground: lightTextPrimary,
        onError: Colors.white,
        outline: lightBorder,
        shadow: Color(0x0F000000), // Softer shadows
        surfaceVariant: Color(0xFFF8F7F4), // Warm surface variant
      ),

      scaffoldBackgroundColor: lightBackground,

      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: lightTextPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          color: lightTextPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.25,
        ),
        headlineMedium: TextStyle(
          color: lightTextPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: lightTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: lightTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: lightTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          color: lightTextSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          color: lightTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: lightBackground,
        foregroundColor: lightTextPrimary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          color: lightTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
        ),
        iconTheme: IconThemeData(color: lightTextPrimary),
      ),

      cardTheme: CardThemeData(
        color: lightCardColor,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.06),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: primaryColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightBorder.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightBorder.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFDC2626)),
        ),
        labelStyle: TextStyle(
          color: lightTextSecondary,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(color: lightTextSecondary.withOpacity(0.7)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightBackground,
        selectedItemColor: primaryColor,
        unselectedItemColor: lightTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      dividerTheme: const DividerThemeData(color: lightBorder, thickness: 1),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: "Inter",
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        primaryContainer: Color(0xFF164E63),
        secondary: accentColor,
        secondaryContainer: Color(0xFF581C87),
        surface: darkSurface,
        surfaceContainerHighest: darkCardColor,
        background: darkBackground,
        error: Color(0xFFEF4444),
        onPrimary: darkBackground,
        onSecondary: darkBackground,
        onSurface: darkTextPrimary,
        onBackground: darkTextPrimary,
        onError: darkBackground,
        outline: darkBorder,
        shadow: Color(0x3A000000),
      ),

      scaffoldBackgroundColor: darkBackground,

      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: darkTextPrimary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
        ),
        iconTheme: IconThemeData(color: darkTextPrimary),
      ),

      cardTheme: CardThemeData(
        color: darkCardColor,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: darkBackground,
          elevation: 4,
          shadowColor: primaryColor.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
        labelStyle: const TextStyle(color: darkTextSecondary),
        hintStyle: const TextStyle(color: darkTextSecondary),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        selectedItemColor: primaryColor,
        unselectedItemColor: darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      dividerTheme: const DividerThemeData(color: darkBorder, thickness: 1),
    );
  }
}
