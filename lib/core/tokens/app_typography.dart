import 'package:flutter/material.dart';

class AppTypography {
  // ── Primary Design Font Family (DM Sans)[cite: 9]
  static const String fontFamilySans = 'DM Sans';
  static const String fontFamilyMono = 'JetBrains Mono';

  // ── Font Sizes[cite: 9]
  static const double size2Xs = 9.5;
  static const double sizeXs = 11.0; //  Exact Figma 11px base caption & label size
  static const double sizeSm = 13.0;
  static const double sizeMd = 15.0;
  static const double sizeLg = 18.0;
  static const double sizeXl = 20.0;
  static const double size2Xl = 22.0;
  static const double size3Xl = 28.0;
  static const double size4Xl = 34.0;

  // ── Font Weights[cite: 9]
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700; //  Figma Bold (w700)[cite: 9]
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // ── Line Heights (multiplier = line_height_px / font_size_px)[cite: 9]
  static const double lineHeightTight = 1.2;
  static const double lineHeightCaption = 1.336; //  Exact 14.7px height on 11px font (14.7 / 11)
  static const double lineHeightNormal = 1.45;
  static const double lineHeightRelaxed = 1.6;
}