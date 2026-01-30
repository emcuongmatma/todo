import 'package:flutter/material.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/core/theme/text_theme.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: ColorDark.background,
  canvasColor: ColorDark.background,
  splashFactory: NoSplash.splashFactory,
  highlightColor: Colors.transparent,
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColorDark.primary,
    onSurface: ColorDark.whiteFocus,
  ),
  appBarTheme: const AppBarThemeData(backgroundColor: ColorDark.background),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ColorDark.primary,
    shape: CircleBorder(),
  ),
  dialogTheme: const DialogThemeData(
    insetPadding: EdgeInsets.symmetric(horizontal: 24),
    backgroundColor: ColorDark.bottomNavigationBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: ColorDark.primary,
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: ColorDark.bottomNavigationBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
  ),
  textTheme: textTheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorDark.primary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: ColorDark.primary.withAlpha(128),
      disabledForegroundColor: ColorDark.primary.withAlpha(128),
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  ),
  inputDecorationTheme: InputDecorationThemeData(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: ColorDark.dividerColor, width: 0.8),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ColorDark.primary;
      }
      return Colors.transparent;
    }),
  ),
);
