import 'package:flutter/material.dart';

class AppColors {
  // ── Brand & Accent
  static const Color primary = Color(0xff2E7D6E);
  static const Color primaryHover = Color(0xff24685B);
  static const Color primaryDark = Color(0xff2E7D6E);
  static const Color accentNavy = Color(0xff1C3A5E);
  static const Color accentBlue = Color(0xff2A5FAA);
  static const Color darkNavy = Color(0xff122B48);
  static const Color darkForest = Color(0xff15503F);

  // ── Backgrounds & Surfaces
  static const Color backgroundLight = Color(0xffF8FAFC);
  static const Color backgroundDark = Color(0xff0B1120);
  static const Color surfaceLight = Color(0xffFFFFFF);
  static const Color surfaceDark = Color(0xff131C2E);
  static const Color surfaceSecondaryDark = Color(0xff1E293B);

  // ── Typography Colors
  static const Color textPrimaryLight = Color(0xff1A1A2E);
  static const Color textPrimaryDark = Color(0xffF8FAFC);
  static const Color textSecondaryLight = Color(0xff64748B);
  static const Color textSecondaryDark = Color(0xff94A3B8);
  static const Color textMutedLight = Color(0xff94A3B8);
  static const Color textMutedDark = Color(0xff64748B);
  static const Color textOnPrimary = Color(0xffFFFFFF);

  // ── Borders & Dividers
  static const Color borderLight = Color(0xffE2E8F0);
  static const Color borderDark = Color(0xff243248);
  static const Color borderStrongLight = Color(0xffCBD5E1);
  static const Color borderStrongDark = Color(0xff334155);

  // ── Feedback & Status
  static const Color success = Color(0xff10B981);
  static const Color warning = Color(0xffF59E0B);
  static const Color danger = Color(0xffEF4444);
  static const Color info = Color(0xff3B82F6);
  static const Color disabled = Color(0xffCBD5E1);
  static const Color disabledDark = Color(0xff334155);

  // ── Selection State Styling
  static const Color selectionCardSelectedBgLight = Color(0xffF0FAF7);
  static const Color selectionCardSelectedBgDark = Color(0xff064E3B);
  static const Color selectionCardSelectedBorderLight = Color(0xff2E7D6E);
  static const Color selectionCardSelectedBorderDark = Color(0xff2E7D6E);
  static const Color selectionCardIconDefaultBgLight = Color(0xffF1F5F9);

  // ── Role-Specific Button Gradients
  /// Creative Professional Gradient: #2E7D6E (0%) -> #1C3A5E (100%)
  static const Gradient buttonGradientCreative = LinearGradient(
    colors: [
      Color(0xff2E7D6E),
      Color(0xff1C3A5E),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// Business Professional Gradient: #1C3A5E (0%) -> #2A5FAA (100%)
  static const Gradient buttonGradientBusiness = LinearGradient(
    colors: [
      Color(0xff1C3A5E),
      Color(0xff2A5FAA),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Fallback alias (defaults to creative professional gradient)
  static const Gradient buttonGradient = buttonGradientCreative;

  // ── Brand Gradients
  static const Gradient brandGradientLight = LinearGradient(
    colors: [
      Color(0xff2E7D6E),
      Color(0xff1C3A5E),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient brandGradientDark = LinearGradient(
    colors: [
      Color(0xff2E7D6E),
      Color(0xff1C3A5E),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}