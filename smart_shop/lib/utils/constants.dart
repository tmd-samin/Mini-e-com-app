import 'package:flutter/material.dart';

class AppConstants {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String loginKey = 'isLoggedIn';
  static const String themeKey = 'isDarkTheme';
  static const String userKey = 'userData';
}

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      margin: EdgeInsets.all(8),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      margin: EdgeInsets.all(8),
    ),
  );
}