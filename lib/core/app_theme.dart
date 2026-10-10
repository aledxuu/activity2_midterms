import 'package:flutter/material.dart';

/// One simple theme: a light grey background and white cards.
class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: const Color(0xFFF3F5F4),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      );
}
