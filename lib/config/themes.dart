import 'package:flutter/material.dart';

import 'palette.dart';

class Themes {
  static final ThemeData dark = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
      },
    ),
    colorScheme: const ColorScheme(
        primary: Palette.darkGrey,
        primaryVariant: Palette.lightGrey,
        secondary: Palette.green,
        secondaryVariant: Palette.green,
        surface: Palette.lightGrey,
        background: Palette.darkGrey,
        error: Palette.red,
        onPrimary: Palette.cream,
        onSecondary: Palette.cream,
        onSurface: Palette.cream,
        onBackground: Palette.cream,
        onError: Palette.cream,
        brightness: Brightness.dark),
    canvasColor: Palette.darkGrey,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(18),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
        selectionHandleColor: Palette.cream,
        selectionColor: Colors.transparent,
        cursorColor: Palette.lightGrey),
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
