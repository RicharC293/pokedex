import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData.dark().copyWith(
  textTheme: GoogleFonts.robotoTextTheme(
    ThemeData.dark().textTheme,
  ),
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        surface: const Color(0xFF200F50),
        onSurface: const Color(0xFFE0E0E0),
        primary: const Color(0xFFF7D548),
        secondary: const Color(0xFF4829A2),
      ),
  scaffoldBackgroundColor: const Color(0xFF200F50),
);
