import 'package:flutter/material.dart';

/// Notificador do tema
ValueNotifier<bool> themeNotifier = ValueNotifier<bool>(false);

/// Tema Claro
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFFFCC00), // Amarelo
  scaffoldBackgroundColor: const Color(0xFFFAFAFA), // Fundo claro
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFCC00), // Amarelo
    foregroundColor: Color(0xFF1E1E1E), // Texto escuro
    elevation: 4,
    centerTitle: true,
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFFFCC00), // Amarelo
    secondary: Color(0xFF1E1E1E), // Azul dos ícones e detalhes
    tertiary: Color(0xFFF5F5F5), // Para backgrounds mais suaves
    surface: Colors.white,
    onPrimary: Color(0xFF1E1E1E), // Texto sobre o primário (amarelo)
    onSecondary: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1E1E1E),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF1E1E1E)),
    displayMedium: TextStyle(color: Color(0xFF1E1E1E)),
    displaySmall: TextStyle(color: Color(0xFF1E1E1E)),
    bodyLarge: TextStyle(color: Color(0xFF1E1E1E)),
    bodyMedium: TextStyle(color: Color(0xFF1E1E1E)),
    bodySmall: TextStyle(color: Color(0xFF1E1E1E)),
    titleLarge: TextStyle(
      color: Color(0xFF1E1E1E),
      fontWeight: FontWeight.bold,
      fontFamily: 'Cairo',
    ),
  ),
  iconTheme: const IconThemeData(color: Color(0xFF2850C8)), // Azul para ícones
);

/// Tema Escuro
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFFFFCC00), // Amarelo
  scaffoldBackgroundColor: const Color(0xFF121212), // Fundo bem escuro
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFCCA300), // Amarelo mais escuro
    foregroundColor: Color(0xFFF0F0F0), // Texto branco
    elevation: 4,
    centerTitle: true,
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFFFCC00), // Amarelo
    secondary: Color(0xFFCCA300), // Ícones também amarelos no escuro
    tertiary: Color(0xFF2C2C2C),
    surface: Color(0xFF1E1E1E),
    onPrimary: Color(0xFF1E1E1E), // Texto sobre amarelo
    onSecondary: Color(0xFFF0F0F0),
    onSurface: Color(0xFFF0F0F0),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFFF0F0F0)),
    displayMedium: TextStyle(color: Color(0xFFF0F0F0)),
    displaySmall: TextStyle(color: Color(0xFFF0F0F0)),
    bodyLarge: TextStyle(color: Color(0xFFF0F0F0)),
    bodyMedium: TextStyle(color: Color(0xFFF0F0F0)),
    bodySmall: TextStyle(color: Color(0xFFF0F0F0)),
    titleLarge: TextStyle(
      color: Color(0xFFF0F0F0),
      fontWeight: FontWeight.bold,
      fontFamily: 'Cairo',
    ),
  ),
  iconTheme: const IconThemeData(color: Color(0xFFFFCC00)), // Ícones amarelos
);
