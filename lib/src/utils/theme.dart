import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

final ThemeData cardInputTheme = ThemeData(
  primaryColor: AppColors.primary,
  colorScheme:const ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: Colors.white, //
    surface: Colors.white,
    shadow: AppColors.disabled
  ),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.inter(),
    labelSmall: GoogleFonts.inter(
      color: AppColors.text,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: AppColors.label,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.inter(color: AppColors.disabled, fontSize: 14),
    contentPadding: const EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.disabled),
      borderRadius: BorderRadius.circular(6),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.disabled),
      borderRadius: BorderRadius.circular(6),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.disabled),
      borderRadius: BorderRadius.circular(6),
    ),
  ),
);
