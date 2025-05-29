import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData cardInputTheme = ThemeData(
  primaryColor: const Color(0xFF081133),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.inter(),
    labelSmall: GoogleFonts.inter(
      color: const Color(0xFF212247),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: const TextStyle(
      color: Color(0xFF585987),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.inter(color: Color(0xFF585987)),
  ),
);
