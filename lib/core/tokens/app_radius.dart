import 'package:flutter/material.dart';

class AppRadius {
  static const double none = 0.0; //[cite: 3]
  static const double xs = 4.0; //[cite: 3]
  static const double sm = 8.0;   // Increased from 6.0 (for small chips & OTP boxes)
  static const double md = 14.0;  // 👈 INCREASED from 10.0 (affects all standard text fields & buttons)
  static const double lg = 18.0;  // 👈 INCREASED from 14.0 (affects selection cards & large buttons)
  static const double xl = 24.0;  // 👈 INCREASED from 18.0 (affects bottom sheets & modals)
  static const double full = 9999.0; //[cite: 3]

  static BorderRadius get radiusNone => BorderRadius.zero; //[cite: 3]
  static BorderRadius get radiusXs => BorderRadius.circular(xs); //[cite: 3]
  static BorderRadius get radiusSm => BorderRadius.circular(sm); //[cite: 3]
  static BorderRadius get radiusMd => BorderRadius.circular(md); //[cite: 3]
  static BorderRadius get radiusLg => BorderRadius.circular(lg); //[cite: 3]
  static BorderRadius get radiusXl => BorderRadius.circular(xl); //[cite: 3]
  static BorderRadius get radiusFull => BorderRadius.circular(full); //[cite: 3]
}