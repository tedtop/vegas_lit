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
}
