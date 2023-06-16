import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData(useMaterial3: true,
      brightness: Brightness.light,
      textTheme: const TextTheme(headlineMedium: TextStyle(fontWeight: FontWeight.bold)),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 23,
        ),
      ),drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),);
  static ThemeData darkTheme = ThemeData(useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff14081A),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(0xff14081A),
    ),drawerTheme: const DrawerThemeData(backgroundColor: Color(0xff14081A),)
  );
}
