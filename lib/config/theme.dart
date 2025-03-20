import 'package:flutter/material.dart';

class AppThemes {
  static const Color primaryPurple = Color(0xFF6B4B94);
  static const Color darkPurple = Color(0xFF1E2B6F);
  static const Color lightBackground = Colors.white;
  static const Color darkBackground = Colors.black;

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryPurple,
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryPurple,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 18, color: Colors.black),
      bodyMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 16, color: Colors.black),
      titleLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 22, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        side: BorderSide.none,
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: darkPurple,
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkPurple,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 18, color: Colors.white),
      bodyMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 16, color: Colors.white),
      titleLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 22, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        side: BorderSide.none, 
        backgroundColor: darkPurple,
        foregroundColor: Colors.white, 
      ),
    ),
  );
}
