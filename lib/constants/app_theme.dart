import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _primary = Color(0xFF0C54BE);
  static const _onPrimary = Colors.white;
  static const _secondary = Color(0xFFCED3DC);
  static const _onSecondary = Color(0xFF303F60);
  static const _background = Color(0xFFF5F9FD);
  static const _error = Colors.red;
  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _primary,
      onPrimaryContainer: _onPrimary,
      secondary: _secondary,
      onSecondaryContainer: _onSecondary,
      surface: _background,
      background: _background,
      error: _error,
      onPrimary: _onPrimary,
      onSecondary: _onSecondary,
      onSurface: _onSecondary,
      onBackground: _onSecondary,
      onError: _error,
    ),
    scaffoldBackgroundColor: _background,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: _primary),
      displayMedium: GoogleFonts.poppins(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: Colors.black),
      displaySmall: GoogleFonts.poppins(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Colors.black),
      bodyLarge: GoogleFonts.poppins(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.black),
      bodyMedium: GoogleFonts.poppins(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: Colors.black),
      bodySmall: GoogleFonts.poppins(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: Colors.black),
    ),
    fontFamily: 'Poppins',
  );
}
