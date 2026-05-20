import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryGreen = Color(0xFF006C35); // Deep spiritual emerald green
  static const Color secondaryGold = Color(0xFFD4AF37); // Warm espiritual gold
  static const Color accentMint = Color(0xFFE2F3E9); // Light soothing mint
  static const Color backgroundLight = Color(0xFFF7FAF8); // Clean soft off-white/mint
  static const Color surfaceWhite = Colors.white;
  static const Color textDark = Color(0xFF2C3E35); // Very dark forest green/charcoal
  static const Color textLight = Colors.white;
  static const Color alertRed = Color(0xFFD32F2F); // High-visibility red for emergency

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primaryGreen,
        secondary: secondaryGold,
        surface: surfaceWhite,
        error: alertRed,
        onPrimary: textLight,
        onSecondary: textDark,
        onSurface: textDark,
      ),
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: textLight,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'System', // Arabic system font
          color: textLight,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 2,
        shadowColor: primaryGreen.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: primaryGreen.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: primaryGreen,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          height: 1.5,
          color: textDark,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          height: 1.4,
          color: textDark,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: textLight,
          minimumSize: const Size(double.infinity, 56), // Large tap target (Hajj elderly friendly)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
