import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/theme/colors.dart';

final textTheme = TextTheme(
  headlineLarge: GoogleFonts.lato(
    fontWeight: FontWeight.w700,
    color: ColorDark.whiteFocus,
    fontSize: 32
  ),
  headlineMedium: GoogleFonts.lato(
      fontWeight: FontWeight.w700,
      color: ColorDark.whiteFocus,
      fontSize: 20
  ),
  headlineSmall: GoogleFonts.lato(
      fontWeight: FontWeight.w700,
      color: ColorDark.whiteFocus,
      fontSize: 16
  ),
  titleLarge: GoogleFonts.lato(
      fontWeight: FontWeight.w500,
      color: ColorDark.whiteFocus,
      fontSize: 18
  ),
  titleMedium: GoogleFonts.lato(
      fontWeight: FontWeight.w500,
      color: ColorDark.whiteFocus,
      fontSize: 16
  ),
  titleSmall: GoogleFonts.lato(
      fontWeight: FontWeight.w500,
      color: ColorDark.whiteFocus,
      fontSize: 14
  ),
  labelMedium: GoogleFonts.lato(
    fontWeight: FontWeight.w600,
    fontSize: 24
  ),
  bodyLarge: GoogleFonts.lato(
    fontWeight: FontWeight.w400,
      color: ColorDark.whiteFocus,
    fontSize: 20
  ),
  bodyMedium: GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      color: ColorDark.whiteFocus,
      fontSize: 16
  ),
  bodySmall: GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      color: ColorDark.whiteFocus,
      fontSize: 12
  ),
);