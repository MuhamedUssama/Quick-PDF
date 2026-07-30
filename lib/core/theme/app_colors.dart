import 'package:flutter/material.dart';

/// AppColors defines the complete color system for LocalSend.
/// Inspired by modern Deep Teal (#006D77), Lighter Teal (#83C5BE),
/// Off-White (#F8FAFC), and Dark Slate (#1B1D1E).
abstract class AppColors {
  // ===========================================================================
  // 🌿 BRAND & TEAL ACCENT COLORS
  // ===========================================================================

  /// Deep Teal - Primary brand color (Sophisticated & Modern)
  static const Color primary = Color(0xFF006D77);
  static const Color primaryLight = Color(0xFF2A9D8F);
  static const Color primaryDark = Color(0xFF004D54);

  /// Lighter Teal / Soft Cyan - Secondary accent & interactive highlights
  static const Color secondary = Color(0xFF83C5BE);
  static const Color secondaryLight = Color(0xFFE2F1F0);
  static const Color secondaryDark = Color(0xFF4C9A93);

  /// Warm Sand Coral - Secondary warmth accent for transfers & highlights
  static const Color accentCoral = Color(0xFFE29578);
  static const Color accentCoralLight = Color(0xFFFFDDD2);

  /// Mint Success - Active connection / Transfer completed
  static const Color mintGreen = Color(0xFF2A9D8F);
  static const Color mintGreenLight = Color(0xFF83C5BE);

  /// Coral Pulse - Live activity, active upload badge, errors
  static const Color coralPulse = Color(0xFFE76F51);
  static const Color coralPulseLight = Color(0xFFF4A261);

  /// Amber Warning - Interrupted transfer, pending states
  static const Color amberWarning = Color(0xFFE9C46A);

  // ===========================================================================
  // 🌙 DARK THEME PALETTE (Dark Slate #1B1D1E & Soft Charcoal)
  // ===========================================================================

  static const Color darkBackground = Color(0xFF141516); // Deep Slate Backdrop
  static const Color darkSurface = Color(0xFF1B1D1E);    // Dark Slate Surface
  static const Color darkSurfaceElevated = Color(0xFF25282A); // Elevated Container
  static const Color darkSurfaceContainer = Color(0xFF2E3235);
  static const Color darkBorder = Color(0xFF2E3235);
  static const Color darkDivider = Color(0xFF232527);

  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF64748B);

  // ===========================================================================
  // ☀️ LIGHT THEME PALETTE (Off-White #F8FAFC & Crisp Slate)
  // ===========================================================================

  static const Color lightBackground = Color(0xFFF8FAFC); // Off-White
  static const Color lightSurface = Color(0xFFFFFFFF);    // Pure White Card
  static const Color lightSurfaceElevated = Color(0xFFF1F5F9);
  static const Color lightSurfaceContainer = Color(0xFFE2E8F0);
  static const Color lightBorder = Color(0xFFCBD5E1);
  static const Color lightDivider = Color(0xFFE2E8F0);

  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF94A3B8);

  // ===========================================================================
  // 🎨 HARMONIOUS GRADIENTS
  // ===========================================================================

  /// Primary Deep Teal -> Lighter Teal Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF006D77), Color(0xFF83C5BE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Active Transfer Gradient (Deep Teal -> Warm Coral Sand)
  static const LinearGradient transferGradient = LinearGradient(
    colors: [Color(0xFF006D77), Color(0xFFE29578)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Success Signal Gradient (Teal Green -> Lighter Teal)
  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF2A9D8F), Color(0xFF83C5BE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Dark Glass Backdrop Fill
  static const Color darkGlassFill = Color(0xCC1B1D1E);

  /// Light Glass Backdrop Fill
  static const Color lightGlassFill = Color(0xCCFFFFFF);
}
