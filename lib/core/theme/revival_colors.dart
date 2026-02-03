import 'package:flutter/material.dart';

class RevivalColors {
  // Brand Colors
  static const Color navyBlue = Color(0xFF001F3F);
  static const Color deepNavy = Color(0xFF001529);
  static const Color primaryBlue = Color(0xFF003366);
  
  // Neutral Colors
  static const Color softGrey = Color(0xFFF5F7FA);
  static const Color midGrey = Color(0xFFE0E6ED);
  static const Color darkGrey = Color(0xFF606F7B);
  static const Color white = Colors.white;
  static const Color black = Color(0xFF1A1A1A);

  // Functional Colors
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFC107);
  static const Color danger = Color(0xFFDC3545);
  static const Color accent = Color(0xFFE6F0FF);
  static const Color activeGreen = Color(0xFF28A745);
  static const Color expiringOrange = Color(0xFFFFC107);
  static const Color expiredRed = Color(0xFFDC3545);
  static const Color pendingBlue = Color(0xFF003366);
  static const Color verificationGrey = Color(0xFF606F7B);

  // Gradients
  static const LinearGradient navyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      navyBlue,
      primaryBlue,
    ],
  );
}
