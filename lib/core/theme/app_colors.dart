import 'package:flutter/material.dart';

/// Asosiy brend: `#1E3D32` va uning yorug‘/qorong‘i nuanslari.
abstract final class AppColors {
  /// Asosiy yashil-to‘q (splash, primary, aksentlar).
  static const Color primary = Color(0xFF1E3D32);

  /// Bosilganda / gradient pastki uchi.
  static const Color primaryDark = Color(0xFF142A23);

  /// Gradient yuqori uchi, yoritilgan nuans.
  static const Color primaryLight = Color(0xFF356B56);

  static const Color splashBackground = primary;

  static const Color accent = Color(0xFFE07A5F);

  static const Color background = Color(0xFFF5F6F8);
  static const Color card = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF101828);
  static const Color textSecondary = Color(0xFF667085);

  static const Color border = Color(0xFFE4E7EC);
  static const Color success = Color(0xFF12B76A);
  static const Color warning = Color(0xFFF79009);

  /// Chip, badge fonlari (`primary`ning juda och turi).
  static const Color accentSoft = Color(0xFFE6EEEA);

  /// Pastki navigatsiya fon.
  static const Color navBarLight = Color(0xFFD8E6E0);

  // Dark
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1C1C1E);
  static const Color darkTextPrimary = Color(0xFFF2F4F7);
  static const Color darkTextSecondary = Color(0xFF98A2B3);
  static const Color darkBorder = Color(0xFF2D2D2F);
}
