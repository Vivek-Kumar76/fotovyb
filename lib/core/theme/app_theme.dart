import 'package:flutter/material.dart';
import 'package:p1/core/tokens/tokens.dart';

class AppTheme {
  // ===========================================================================
  // LIGHT THEME CONFIGURATION
  // ===========================================================================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppTypography.fontFamilySans,
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // Color Scheme Mapping
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.textOnPrimary,
        secondary: AppColors.primaryHover,
        onSecondary: AppColors.textOnPrimary,
        error: AppColors.danger,
        onError: AppColors.textOnPrimary,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textPrimaryLight,
        outline: AppColors.borderLight,
        outlineVariant: AppColors.borderStrongLight,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimaryLight),
        titleTextStyle: TextStyle(
          fontFamily: AppTypography.fontFamilySans,
          fontSize: AppTypography.sizeLg,
          fontWeight: AppTypography.bold,
          color: AppColors.textPrimaryLight,
        ),
      ),

      // Card & Surface Theme (Using CardThemeData for Flutter M3)
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusLg,
          side: const BorderSide(color: AppColors.borderLight),
        ),
        margin: EdgeInsets.zero,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space4,
          vertical: AppSpacing.space3 + 2,
        ),
        hintStyle: const TextStyle(
          color: AppColors.textMutedLight,
          fontSize: AppTypography.sizeSm,
          fontWeight: AppTypography.regular,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.radiusMd,
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.radiusMd,
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.radiusMd,
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.radiusMd,
          borderSide: const BorderSide(color: AppColors.danger),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          minimumSize: const Size.fromHeight(48.0),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space6),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.radiusFull,
          ),
          textStyle: const TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: AppTypography.sizeMd,
            fontWeight: AppTypography.semibold,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.surfaceLight,
          foregroundColor: AppColors.textPrimaryLight,
          minimumSize: const Size.fromHeight(48.0),
          side: const BorderSide(color: AppColors.borderLight),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.radiusMd,
          ),
          textStyle: const TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: AppTypography.sizeSm,
            fontWeight: AppTypography.semibold,
          ),
        ),
      ),

      // Typography Hierarchy
      textTheme: _buildTextTheme(
        textColor: AppColors.textPrimaryLight,
        mutedColor: AppColors.textMutedLight,
        secondaryColor: AppColors.textSecondaryLight,
      ),
    );
  }

  // ===========================================================================
  // DARK THEME CONFIGURATION
  // ===========================================================================
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppTypography.fontFamilySans,
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // Color Scheme Mapping
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryDark,
        onPrimary: AppColors.textOnPrimary,
        secondary: AppColors.primaryHover,
        onSecondary: AppColors.textOnPrimary,
        error: AppColors.danger,
        onError: AppColors.textOnPrimary,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
        outline: AppColors.borderDark,
        outlineVariant: AppColors.borderStrongDark,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
        titleTextStyle: TextStyle(
          fontFamily: AppTypography.fontFamilySans,
          fontSize: AppTypography.sizeLg,
          fontWeight: AppTypography.bold,
          color: AppColors.textPrimaryDark,
        ),
      ),

      // Card & Surface Theme (Using CardThemeData for Flutter M3)
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusLg,
          side: const BorderSide(color: AppColors.borderDark),
        ),
        margin: EdgeInsets.zero,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space4,
          vertical: AppSpacing.space3 + 2,
        ),
        hintStyle: const TextStyle(
          color: AppColors.textMutedDark,
          fontSize: AppTypography.sizeSm,
          fontWeight: AppTypography.regular,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.radiusMd,
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.radiusMd,
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.radiusMd,
          borderSide: const BorderSide(color: AppColors.primaryDark, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.radiusMd,
          borderSide: const BorderSide(color: AppColors.danger),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.textOnPrimary,
          minimumSize: const Size.fromHeight(48.0),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space6),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.radiusFull,
          ),
          textStyle: const TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: AppTypography.sizeMd,
            fontWeight: AppTypography.semibold,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.surfaceSecondaryDark,
          foregroundColor: AppColors.textPrimaryDark,
          minimumSize: const Size.fromHeight(48.0),
          side: const BorderSide(color: AppColors.borderDark),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.radiusMd,
          ),
          textStyle: const TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: AppTypography.sizeSm,
            fontWeight: AppTypography.semibold,
          ),
        ),
      ),

      // Typography Hierarchy
      textTheme: _buildTextTheme(
        textColor: AppColors.textPrimaryDark,
        mutedColor: AppColors.textMutedDark,
        secondaryColor: AppColors.textSecondaryDark,
      ),
    );
  }

  // ===========================================================================
  // HELPER: TEXT THEME GENERATOR
  // ===========================================================================
  static TextTheme _buildTextTheme({
    required Color textColor,
    required Color mutedColor,
    required Color secondaryColor,
  }) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: AppTypography.fontFamilySans,
        fontSize: AppTypography.size4Xl,
        fontWeight: AppTypography.bold,
        height: AppTypography.lineHeightTight,
        color: textColor,
      ),
      displayMedium: TextStyle(
        fontFamily: AppTypography.fontFamilySans,
        fontSize: AppTypography.size3Xl,
        fontWeight: AppTypography.bold,
        height: AppTypography.lineHeightTight,
        color: textColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: AppTypography.fontFamilySans,
        fontSize: AppTypography.size2Xl,
        fontWeight: AppTypography.bold,
        height: AppTypography.lineHeightTight,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: AppTypography.fontFamilySans,
        fontSize: AppTypography.sizeXl,
        fontWeight: AppTypography.semibold,
        height: AppTypography.lineHeightNormal,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontFamily: AppTypography.fontFamilySans,
        fontSize: AppTypography.sizeLg,
        fontWeight: AppTypography.semibold,
        height: AppTypography.lineHeightNormal,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontFamily: AppTypography.fontFamilySans,
        fontSize: AppTypography.sizeMd,
        fontWeight: AppTypography.medium,
        height: AppTypography.lineHeightNormal,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: AppTypography.fontFamilySans,
        fontSize: AppTypography.sizeMd,
        fontWeight: AppTypography.regular,
        height: AppTypography.lineHeightNormal,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: AppTypography.fontFamilySans,
        fontSize: AppTypography.sizeSm,
        fontWeight: AppTypography.regular,
        height: AppTypography.lineHeightNormal,
        color: secondaryColor,
      ),
      bodySmall: TextStyle(
        fontFamily: AppTypography.fontFamilySans,
        fontSize: AppTypography.sizeXs,
        fontWeight: AppTypography.regular,
        height: AppTypography.lineHeightNormal,
        color: mutedColor,
      ),
      labelLarge: TextStyle(
        fontFamily: AppTypography.fontFamilySans,
        fontSize: AppTypography.sizeSm,
        fontWeight: AppTypography.semibold,
        color: textColor,
      ),
    );
  }
}