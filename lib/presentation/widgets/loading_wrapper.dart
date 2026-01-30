import 'package:flutter/material.dart';
import 'package:todo/core/theme/colors.dart';

class LoadingWrapper extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingWrapper({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AbsorbPointer(absorbing: isLoading, child: child),
        if (isLoading)
          Container(
            color: Colors.black.withAlpha(50),
            child: Center(
              child: Container(
                padding: const EdgeInsetsGeometry.all(32),
                decoration: const BoxDecoration(
                  color: ColorDark.bottomNavigationBackground,
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
                ),
                child: const CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}
