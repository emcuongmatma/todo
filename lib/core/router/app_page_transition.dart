import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppTransitionPage<T> extends CustomTransitionPage<T> {
  AppTransitionPage({
    required super.child,
    required LocalKey super.key,
  }) : super(
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutQuart)),
        ),
        child: child,
      );
    },
  );
}