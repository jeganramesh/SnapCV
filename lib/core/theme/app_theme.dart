import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Apple-inspired minimal theme configuration with modern Roman (Inter) font
class AppTheme {
  AppTheme._();

  // Apple System Colors
  static const Color primaryColor = Color(0xFF007AFF);
  static const Color destructiveColor = Color(0xFFFF3B30);
  static const Color successColor = Color(0xFF34C759);
  static const Color warningColor = Color(0xFFFF9500);

  // Grays
  static const Color systemGray = Color(0xFF8E8E93);
  static const Color systemGray2 = Color(0xFFAEAEB2);
  static const Color systemGray3 = Color(0xFFC7C7CC);
  static const Color systemGray4 = Color(0xFFD1D1D6);
  static const Color systemGray5 = Color(0xFFE5E5EA);
  static const Color systemGray6 = Color(0xFFF2F2F7);

  // Background Colors
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color secondaryBackgroundColor = Color(0xFFF2F2F7);
  static const Color tertiaryBackgroundColor = Color(0xFFFFFFFF);

  // Label Colors
  static const Color labelColor = Color(0xFF000000);
  static const Color secondaryLabelColor = Color(0x993C3C43);
  static const Color tertiaryLabelColor = Color(0x4D3C3C43);
  static const Color quaternaryLabelColor = Color(0x2E3C3C43);

  // Light Theme with Inter font
  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: secondaryBackgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
        surface: backgroundColor,
        error: destructiveColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: labelColor,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: labelColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          color: labelColor,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: systemGray5, width: 0.5),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: systemGray6,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: GoogleFonts.inter(
          color: secondaryLabelColor,
          fontSize: 15,
        ),
        labelStyle: GoogleFonts.inter(
          color: secondaryLabelColor,
          fontSize: 15,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: CircleBorder(),
      ),
      dividerTheme: const DividerThemeData(
        color: systemGray5,
        thickness: 0.5,
        space: 0,
      ),
      textTheme: baseTextTheme.copyWith(
        headlineLarge: GoogleFonts.inter(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: labelColor,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: labelColor,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: labelColor,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: labelColor,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: labelColor,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: labelColor,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: labelColor,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: labelColor,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: secondaryLabelColor,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: labelColor,
        ),
      ),
    );
  }
}
