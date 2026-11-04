import 'package:flutter/material.dart';

class AppShadows {
  static const List<BoxShadow> xs = [
    BoxShadow(offset: Offset(0, 1), blurRadius: 2, color: Color.fromRGBO(0, 0, 0, 0.05)), //[cite: 4]
  ];

  static const List<BoxShadow> sm = [
    BoxShadow(offset: Offset(0, 2), blurRadius: 4, color: Color.fromRGBO(0, 0, 0, 0.06)), //[cite: 4]
  ];

  static const List<BoxShadow> md = [
    BoxShadow(offset: Offset(0, 4), blurRadius: 8, color: Color.fromRGBO(0, 0, 0, 0.08)), //[cite: 4]
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(offset: Offset(0, 8), blurRadius: 16, color: Color.fromRGBO(0, 0, 0, 0.12)), //[cite: 4]
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(offset: Offset(0, 16), blurRadius: 32, color: Color.fromRGBO(0, 0, 0, 0.16)), //[cite: 4]
  ];

  static const List<BoxShadow> buttonPrimaryLight = [
    BoxShadow(offset: Offset(0, 10), blurRadius: 18, color: Color.fromRGBO(0, 0, 0, 0.08)), //[cite: 1]
    BoxShadow(offset: Offset(0, 24), blurRadius: 48, color: Color.fromRGBO(44, 93, 121, 0.2)), //[cite: 1]
  ];

  static const List<BoxShadow> buttonPrimaryDark = [
    BoxShadow(offset: Offset(0, 10), blurRadius: 18, color: Color.fromRGBO(0, 0, 0, 0.25)), //[cite: 1]
    BoxShadow(offset: Offset(0, 24), blurRadius: 48, color: Color.fromRGBO(0, 0, 0, 0.4)), //[cite: 1]
  ];
}