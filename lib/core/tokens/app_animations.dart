import 'package:flutter/animation.dart';

class AppAnimations {
  static const Duration fast = Duration(milliseconds: 150); //[cite: 8]
  static const Duration normal = Duration(milliseconds: 250); //[cite: 8]
  static const Duration slow = Duration(milliseconds: 400); //[cite: 8]

  static const Curve standard = Curves.ease; //[cite: 8]
  static const Curve easeIn = Curves.easeIn; //[cite: 8]
  static const Curve easeOut = Curves.easeOut; //[cite: 8]
  static const Curve easeInOut = Curves.easeInOut; //[cite: 8]
}