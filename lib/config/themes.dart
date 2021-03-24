import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';

class Themes {
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    canvasColor: Palette.darkGrey,
    accentColor: Palette.green,
    primaryColor: Palette.darkGrey,
    primaryColorLight: Palette.lightGrey,
    primaryColorDark: Palette.darkGrey,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(18.0),
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      color: Palette.darkGrey,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Palette.cream),
      ),
    ),
    textTheme: const TextTheme(
      headline6: TextStyle(color: Palette.cream),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Palette.darkGrey,
    ),
    scaffoldBackgroundColor: Palette.darkGrey,
    iconTheme: const IconThemeData(
      color: Palette.cream,
    ),
  );
}
