import 'package:flutter/material.dart';

/// Tema dell'applicazione DicaDoc.
class AppTheme {
  AppTheme._();

  // Colore brand: blu/teal medicale, calmo.
  static const Color brand = Color(0xFF1B7F8C);
  static const Color brandDark = Color(0xFF0E5560);

  // Stati "emoticon" del pannello terapia (semaforo).
  static const Color statoOk = Color(0xFF2E9E5B); // verde sorridente
  static const Color statoAttenzione = Color(0xFFE0A100); // giallo
  static const Color statoAllarme = Color(0xFFD0392E); // rosso triste

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: brand,
      brightness: Brightness.light,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFFF5F7F8),
      appBarTheme: const AppBarTheme(
        backgroundColor: brand,
        foregroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
