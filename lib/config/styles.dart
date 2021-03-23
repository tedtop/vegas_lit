import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';

class Styles {
  static const double dropShadow = 4.0;

  static final ShapeBorder buttonRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6.0),
  );

  static final TextStyle greenButtonText = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle redButtonText = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );

  static final ShapeBorder cardRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  );

  static const TextStyle emptySlipText = TextStyle(
    color: Colors.grey,
    fontSize: 15,
  );

  static final TextStyle headingLeaderboard = GoogleFonts.nunito(
    color: Palette.green,
    fontSize: 30.0,
    fontWeight: FontWeight.w600,
  );

  /* ---------------------------------------- */

  static final nunitoFont = GoogleFonts.nunito();

  static final defaultSizeBoldCream = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Palette.cream,
  );

  static final defaultCreamBold = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Palette.cream,
  );

  static final defaultSizeColorCreamBold = GoogleFonts.nunito(
    color: Palette.cream,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static final greenColor = GoogleFonts.nunito(color: Palette.green);

  static final creamColor = GoogleFonts.nunito(
    color: Palette.cream,
  );

  static final redColor = GoogleFonts.nunito(
    color: Palette.red,
  );

  static final smallSizeColorCream = GoogleFonts.nunito(
    color: Palette.cream,
    fontSize: 14,
  );

  static final moreSmallSizeColorCream = GoogleFonts.nunito(
    color: Palette.cream,
    fontSize: 10,
  );

  static final moreSmallSizeColorRed = GoogleFonts.nunito(
    color: Palette.red,
    fontSize: 10,
  );

  static final creamMediumLessBold = GoogleFonts.nunito(
    color: Palette.cream,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
  );

  static final largeGreenBold = GoogleFonts.nunito(
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

  static final smallFontLessBold = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Palette.cream,
  );

  static final greenBold = GoogleFonts.nunito(
    color: Palette.green,
    fontWeight: FontWeight.bold,
  );

  static final defaultCreamLessBold = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: Palette.cream,
  );

  static final nunitoGreen = GoogleFonts.nunito(color: Palette.green);
  static final defaultGreen = GoogleFonts.nunito(
    color: Palette.green,
    fontSize: 18,
  );
  static final smallCream = GoogleFonts.nunito(
    color: Palette.cream,
    fontSize: 10,
  );
  static final small = GoogleFonts.nunito(
    fontSize: 10,
  );

  static final creamLargeBold = GoogleFonts.nunito(
    fontSize: 24,
    color: Palette.cream,
    fontWeight: FontWeight.w700,
  );
  static final defaultBoldCream = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Palette.cream,
  );

  static final defaultCream = GoogleFonts.nunito(
    fontSize: 18,
    color: Palette.cream,
  );
}
