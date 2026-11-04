import 'package:flutter/material.dart';
import 'package:p1/core/tokens/tokens.dart'; //[cite: 2]

class PageTransitions {
  static Route slideHorizontal(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: AppAnimations.easeInOut)); //[cite: 8]
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: AppAnimations.slow, //[cite: 8]
    );
  }

  static Route fade(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: AppAnimations.easeOut), //[cite: 8]
          child: child,
        );
      },
      transitionDuration: AppAnimations.normal, //[cite: 8]
    );
  }
}