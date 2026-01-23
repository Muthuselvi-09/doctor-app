import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF0E6EFF); // Medical Blue
  static const Color secondary = Color(0xFF00C2A8); // Teal Medical
  static const Color accent = Color(0xFFEEF6FF); // Soft White

  // Gradient Colors
  static const List<Color> primaryGradient = [
    primary,
    Color(0xFF00C2A8),
  ];

  // Background Colors
  static const Color background = Color(0xFFF8FAFF);
  static const Color surface = Colors.white;
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1A1C1E);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textHint = Color(0xFFA0AEC0);

  // States
  static const Color success = Color(0xFF28A745);
  static const Color error = Color(0xFFDC3545);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF17A2B8);

  // Glassmorphism specific
  static final Color glassBorder = Colors.white.withOpacity(0.2);
  static final Color glassBackground = Colors.white.withOpacity(0.1);
}
