import 'package:flutter/material.dart';

class AppColors {
  // Brand Greens (from MyCampus Design System)
  static const Color primary = Color(0xFF00A651);
  static const Color primaryDark = Color(0xFF064E3B);
  static const Color primaryDeep = Color(0xFF073A27);
  static const Color primaryLight = Color(0xFFE8F8F0);
  static const Color secondary = Color(0xFF34D399);
  static const Color tertiary = Color(0xFF10DE83);
  static const Color mintAccent = Color(0xFFA7F3D0);
  static const Color mintBadge = Color(0xFFD1FAE5);

  // Surface & Canvas
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF0B0F17); // Neutral from design system
  static const Color cardDark = Color(0xFF131D28);
  static const Color darkHero = Color(0xFF0B1F17);

  // Typography Colors
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textMutedLight = Color(0xFF94A3B8);

  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textMutedDark = Color(0xFF64748B);

  // Functional Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFECFDF5);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFFFBEB);

  static const Color danger = Color(0xFFEF4444);
  static const Color dangerLight = Color(0xFFFEF2F2);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFEFF6FF);

  static const Color purple = Color(0xFF8B5CF6);
  static const Color purpleLight = Color(0xFFF5F3FF);

  // Borders & Dividers
  static const Color borderSubtle = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF1E293B);
  static const Color divider = Color(0xFFEEF2F6);

  // Convenient Theme Aliases
  static const Color textPrimary = textPrimaryLight;
  static const Color textSecondary = textSecondaryLight;
  static const Color textTertiary = textMutedLight;
  static const Color surfaceLight = cardLight;
  static const Color border = borderSubtle;
  static const Color accentLight = mintAccent;
}
