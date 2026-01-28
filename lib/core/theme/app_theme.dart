import 'package:flutter/material.dart';

/// App color constants
class AppColors {
  AppColors._();

  /// Primary (main) color: #00191A
  static const Color primary = Color(0xFF000808);

  /// Secondary color: #469B9D
  static const Color secondary = Color(0xFF469B9D);

  /// Text color: #FFFFFF
  static const Color text = Color(0xFFFFFFFF);

  static const Color teal = Color(0xFF092635);

  static const Color tealLight = Color(0xFF79C9C5);


  static const Color white = Colors.white;
}

/// Centralized app theme configuration
class AppTheme {
  AppTheme._();

  /// Main app theme
  static ThemeData get theme {
    return ThemeData(
      fontFamily: 'Roboto',
      useMaterial3: true,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.primary,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.text,
        secondary: AppColors.secondary,
        onSecondary: AppColors.text,
        error: Colors.red,
        onError: AppColors.text,
        surface: AppColors.primary,
        onSurface: AppColors.text,
        surfaceContainerHighest: AppColors.primary.withValues(alpha: 0.8),
        onSurfaceVariant: AppColors.text,
        outline: AppColors.secondary,
        shadow: Colors.black,
        inverseSurface: AppColors.text,
        onInverseSurface: AppColors.primary,
        inversePrimary: AppColors.secondary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.text,
        iconTheme: IconThemeData(color: AppColors.text),
        centerTitle: true,
        elevation: 0,
      ),
      // Text theme with all styles set to white
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.text),
      ),
      textTheme: const TextTheme(
        // HERO / DISPLAY
        displayLarge: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.w900, // Roboto Black
          color: AppColors.text,
          letterSpacing: -1.2,
        ),
        displayMedium: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w800, // Roboto ExtraBold
          color: AppColors.text,
          letterSpacing: -1.0,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700, // Roboto Bold
          color: AppColors.text,
          letterSpacing: -0.5,
        ),

        // HEADLINES
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700, // Roboto Bold
          color: AppColors.text,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600, // Roboto SemiBold
          color: AppColors.text,
          letterSpacing: -0.3,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600, // Roboto SemiBold
          color: AppColors.text,
          letterSpacing: 0,
        ),

        // TITLES
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600, // SemiBold
          color: AppColors.text,
          letterSpacing: 0,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500, // Medium
          color: AppColors.text,
          letterSpacing: 0.15,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500, // Medium
          color: AppColors.text,
          letterSpacing: 0.1,
        ),

        // BODY
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400, // Regular
          color: AppColors.text,
          letterSpacing: 0.15,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400, // Regular
          color: AppColors.text,
          letterSpacing: 0.25,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400, // Regular
          color: AppColors.text,
          letterSpacing: 0.4,
        ),

        // LABELS / BUTTONS / CAPS
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600, // SemiBold (better for buttons)
          color: AppColors.text,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500, // Medium
          color: AppColors.text,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500, // Medium
          color: AppColors.text,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
