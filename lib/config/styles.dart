import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';

class Styles {
  static const double normalElevation = 4.0;

  static final ShapeBorder smallRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6.0),
  );

  static final ShapeBorder largeRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  );

  static final pageTitle = GoogleFonts.nunito(
    fontSize: 36,
    color: Palette.green,
    fontWeight: FontWeight.bold,
    shadows: <Shadow>[
      Shadow(
        offset: const Offset(0, 4.0),
        blurRadius: 4.0,
        color: const Color(0xFF000000).withOpacity(0.25),
      ),
    ],
  );

  static final normalText = GoogleFonts.nunito(
    fontSize: 18,
    color: Palette.cream,
    fontWeight: FontWeight.normal,
  );

  static final normalTextBold = GoogleFonts.nunito(
    fontSize: 18,
    color: Palette.cream,
    fontWeight: FontWeight.bold,
  );

  static final largeTextBold = GoogleFonts.nunito(
    fontSize: 24,
    color: Palette.cream,
    fontWeight: FontWeight.bold,
  );

  static final greenText = GoogleFonts.nunito(
    fontSize: 18,
    color: Palette.green,
  );
  static final greenTextBold = GoogleFonts.nunito(
    fontSize: 18,
    color: Palette.green,
    fontWeight: FontWeight.bold,
  );

  static final homeTeam = GoogleFonts.nunito(
    fontSize: 18,
    color: Palette.green,
    fontWeight: FontWeight.bold,
  );

  static final awayTeam = GoogleFonts.nunito(
    fontSize: 16,
    color: Palette.cream,
    // fontWeight: FontWeight.bold,
  );

  static final matchupTime = GoogleFonts.nunito(
    fontSize: 13,
    color: Palette.cream,
  );

  /// Same as normalTextBold
  static final matchupSeparator = GoogleFonts.nunito(
    fontSize: 18,
    color: Palette.cream,
    fontWeight: FontWeight.bold,
  );
}
