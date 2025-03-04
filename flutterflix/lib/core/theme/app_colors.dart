import 'package:flutter/material.dart';

class AppColors {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color textPrimary;
  final Color textSecondary;
  final Color borderColor;
  final Color socialBackground;
  final Color linkColor;

  // Light Theme Colors
  static final AppColors light = AppColors._(
    primary: const Color(0xFF4B39EF), // Purple button color
    secondary: Colors.white,
    background: Colors.white,
    textPrimary: Colors.black,
    textSecondary: const Color(0xFF57636C),
    borderColor: const Color(0xFFE0E3E7),
    socialBackground: Colors.grey[300]!,
    linkColor: const Color(0xFF6B7280),
  );

  // Dark Theme Colors
  static final AppColors dark = AppColors._(
    primary: const Color(0xFFBB86FC), // A lighter purple for dark mode
    secondary: Colors.black,
    background: const Color(0xFF121212),
    textPrimary: Colors.white,
    textSecondary: const Color(0xFFB0BEC5),
    borderColor: const Color(0xFF37474F),
    socialBackground: Colors.grey[800]!,
    linkColor: const Color(0xFF8E99A4), // Subtle link color for dark mode
  );

  const AppColors._({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.textPrimary,
    required this.textSecondary,
    required this.borderColor,
    required this.socialBackground,
    required this.linkColor,
  });

  /// Gets the current theme's colors based on the brightness.
  static AppColors of(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark ? AppColors.dark : AppColors.light;
  }
}
