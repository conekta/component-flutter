import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dark_colors.dart';

final ThemeData darkTheme = ThemeData(
  primaryColor: DarkAppColors.primary,
  colorScheme: const ColorScheme.dark(
      primary: DarkAppColors.primary,
      onPrimary: Colors.white, //
      surface: DarkAppColors.background,
      shadow: DarkAppColors.disabled),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.inter(color: DarkAppColors.text),
    labelSmall: GoogleFonts.inter(
      color: DarkAppColors.text,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: const TextStyle(
      color: DarkAppColors.label,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.inter(color: DarkAppColors.disabled, fontSize: 14),
    contentPadding:
        const EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: DarkAppColors.disabled),
      borderRadius: BorderRadius.circular(6),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: DarkAppColors.disabled),
      borderRadius: BorderRadius.circular(6),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: DarkAppColors.disabled),
      borderRadius: BorderRadius.circular(6),
    ),
  ),
);
