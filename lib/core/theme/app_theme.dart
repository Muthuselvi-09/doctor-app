import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'revival_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: RevivalColors.navyBlue,
        primary: RevivalColors.navyBlue,
        secondary: RevivalColors.primaryBlue,
        tertiary: RevivalColors.success,
        background: RevivalColors.softGrey,
        surface: RevivalColors.white,
        error: RevivalColors.danger,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: RevivalColors.black,
      ),
      scaffoldBackgroundColor: RevivalColors.softGrey,
      
      // Typography
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: RevivalColors.deepNavy,
          letterSpacing: -0.5,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: RevivalColors.deepNavy,
          letterSpacing: -0.5,
        ),
        titleLarge: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: RevivalColors.deepNavy,
        ),
        titleMedium: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: RevivalColors.deepNavy,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 16,
          color: RevivalColors.black,
        ),
        bodyMedium: GoogleFonts.outfit(
          fontSize: 14,
          color: RevivalColors.darkGrey,
        ),
        labelLarge: GoogleFonts.outfit(
          fontWeight: FontWeight.w600,
        ),
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: RevivalColors.softGrey,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: RevivalColors.navyBlue),
        titleTextStyle: GoogleFonts.outfit(
          color: RevivalColors.navyBlue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: RevivalColors.navyBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: RevivalColors.midGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: RevivalColors.midGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: RevivalColors.navyBlue, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: RevivalColors.danger),
        ),
        labelStyle: TextStyle(color: RevivalColors.darkGrey),
        hintStyle: TextStyle(color: RevivalColors.verificationGrey),
      ),

      // Cards
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: RevivalColors.midGrey.withOpacity(0.5)),
        ),
      ),

      // Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: RevivalColors.navyBlue,
        unselectedItemColor: RevivalColors.darkGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedLabelStyle: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.outfit(fontSize: 12),
      ),
    );
  }
}
