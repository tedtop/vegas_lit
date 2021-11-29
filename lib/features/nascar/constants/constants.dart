import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NascarPalette {
  static const Color blue = Color.fromRGBO(0, 122, 194, 1);
  static const Color darkBlack = Color(0xff000000);
  static const Color lightBlack = Color.fromRGBO(33, 33, 33, 1);
  static const Color yellow = Color.fromRGBO(255, 215, 0, 1);
  static const Color cream = Color.fromRGBO(245, 241, 227, 1);
  static const Color red = Color.fromRGBO(216, 9, 54, 1);
  static const Color green = Color.fromRGBO(76, 217, 100, 1);
}

class NascarStyles {
  static final ThemeData theme = ThemeData(
    colorScheme: const ColorScheme(
      primary: NascarPalette.darkBlack,
      primaryVariant: NascarPalette.lightBlack,
      secondary: NascarPalette.blue,
      secondaryVariant: NascarPalette.yellow,
      surface: NascarPalette.lightBlack,
      background: NascarPalette.darkBlack,
      error: NascarPalette.red,
      onPrimary: NascarPalette.cream,
      onSecondary: NascarPalette.cream,
      onSurface: NascarPalette.cream,
      onBackground: NascarPalette.cream,
      onError: NascarPalette.cream,
      brightness: Brightness.dark,
    ),
  );
  static final TextStyle buttonText = GoogleFonts.montserrat(
    fontSize: 16,
    color: NascarPalette.cream,
  );
  static final TextStyle smallBoldText = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: NascarPalette.cream,
  );
  static final TextStyle smallLightText = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: NascarPalette.cream,
  );
  static final TextStyle normalBoldText = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: NascarPalette.cream,
  );
  static final TextStyle normalLightText = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: NascarPalette.cream,
  );
  static final TextStyle titleText = GoogleFonts.montserrat(
    fontSize: 65,
    fontWeight: FontWeight.w400,
    color: NascarPalette.cream,
  );
  static final TextStyle largeText = GoogleFonts.montserrat(
    fontSize: 50,
    fontWeight: FontWeight.w500,
    color: NascarPalette.cream,
  );
  static final TextStyle largeLightText = GoogleFonts.montserrat(
    fontSize: 35,
    fontWeight: FontWeight.w400,
    color: NascarPalette.cream,
  );
  static final TextStyle mediumText = GoogleFonts.montserrat(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: NascarPalette.cream,
  );
}
