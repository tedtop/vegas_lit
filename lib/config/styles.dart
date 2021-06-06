import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'palette.dart';

class Styles {
  static const ScreenBreakpoints screenBreakpoints = ScreenBreakpoints(
    desktop: 1000,
    tablet: 600,
    watch: 80,
  );
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
    fontSize: 14,
    color: Palette.cream,
  );

  /// Same as normalTextBold
  static final matchupSeparator = GoogleFonts.nunito(
    fontSize: 18,
    color: Palette.cream,
    fontWeight: FontWeight.bold,
  );

  // FEATURE SPECIFIC CUSTOM STYLES

  /// --> ADMIN VAULT
  static final adminVaultTitle = GoogleFonts.nunito(
    fontSize: 28,
    color: Palette.green,
    fontWeight: FontWeight.bold,
  );

  /// --> AUTHENTICATION
  static final signUpFieldDescription = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w200,
  );
  static final signUpFieldText = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );
  static final signUpFieldHint = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: Palette.cream,
  );
  static const authFieldError = TextStyle(
    fontSize: 10,
    // height: 0.3,
  );
  static final signUpAgreement =
      GoogleFonts.nunito(fontSize: 11, color: Palette.cream);
  static final authButtonText = GoogleFonts.nunito(
    color: Palette.green,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static final authNormalText = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: Palette.cream,
  );

  static const signUpInputFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(4),
    ),
  );
  static const signUpInputFieldFocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: Palette.cream),
  );
  static const logInInputFocusedBorder = UnderlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Palette.cream),
  );

  /// --> BET HISTORY
  static final betHistoryCardNormal = GoogleFonts.nunito(
    fontSize: 14,
    color: Palette.cream,
  );
  static final betHistoryTeamNotAway = GoogleFonts.nunito(
    fontSize: 14,
    color: Palette.green,
  );
  static final betHistoryTeamAway = GoogleFonts.nunito(
    fontSize: 14,
    color: Palette.cream,
  );
  static final betHistoryAmount = GoogleFonts.nunito(
    fontSize: 24,
    color: Palette.cream,
    fontWeight: FontWeight.bold,
  );
  static final betHistoryDescription = GoogleFonts.nunito(
    fontSize: 14,
    color: Palette.cream,
    fontWeight: FontWeight.bold,
  );
  static final betHistoryNormal = GoogleFonts.nunito(
    color: Palette.cream,
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );
  static final betHistoryDropdown = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Palette.cream,
  );
  static final betHistoryDesktopItem = GoogleFonts.nunito(
    fontSize: 14,
    color: Palette.cream,
    fontWeight: FontWeight.normal,
  );
  static final betHistoryDesktopField = GoogleFonts.nunito(
    fontSize: 14,
    color: Palette.cream,
    fontWeight: FontWeight.bold,
  );
  static final betHistoryDesktopTime = GoogleFonts.nunito(
    color: Palette.green,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  /// --> BET SLIP
  static final betSlipBoxNormalText = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w200,
    color: Palette.cream,
  );
  static final betSlipBoxLargeText = GoogleFonts.nunito(
      fontSize: 24, fontWeight: FontWeight.bold, color: Palette.cream);

  /// --> DRAWER PAGES
  /// --> GAMES
  /// --> HOME

  /// --> LEADERBOARD
  static final leaderboardDropdown = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Palette.cream,
  );
  static final leaderboardUsername = GoogleFonts.nunito(
    fontWeight: FontWeight.bold,
    color: Palette.cream,
    fontSize: 20,
  );
  static final leaderboardDesktopItem = GoogleFonts.nunito(
    fontSize: 14,
    color: Palette.cream,
    fontWeight: FontWeight.normal,
  );
  static final leaderboardDesktopField = GoogleFonts.nunito(
    fontSize: 14,
    color: Palette.cream,
    fontWeight: FontWeight.bold,
  );

  /// --> OPEN BETS
  static final openBetsTextButton = GoogleFonts.nunito(
    color: Palette.green,
    fontWeight: FontWeight.bold,
  );
  static final openBetsNormalText = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Palette.cream,
  );
  static final openBetsEmpty = GoogleFonts.nunito(
    color: Palette.cream,
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );
  static final openBetsCardNormal = GoogleFonts.nunito(
    fontSize: 14,
    color: Palette.cream,
  );
  static final openBetsCardTime = GoogleFonts.nunito(
    color: Palette.red,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static final openBetsCardBetText = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static final openBetsCardBetMoney = GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static final openBetsDesktopField = GoogleFonts.nunito(
    fontSize: 14,
    color: Palette.cream,
    fontWeight: FontWeight.bold,
  );
  static final openBetsDesktopItem = GoogleFonts.nunito(
    fontSize: 14,
    color: Palette.cream,
    fontWeight: FontWeight.normal,
  );
  static final openBetsDesktopTime = GoogleFonts.nunito(
    color: Palette.red,
    fontSize: 14,
  );

  /// --> PROFILE
  static final profileUsernameLetter = GoogleFonts.nunito(
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );
  static final profileUsername = GoogleFonts.nunito(
      fontSize: 24, fontWeight: FontWeight.bold, color: Palette.cream);
  static final profileFieldDescription = GoogleFonts.nunito(
    fontSize: 14,
    color: Palette.green,
    shadows: <Shadow>[
      Shadow(
        offset: const Offset(0, 2.0),
        blurRadius: 2.0,
        color: const Color(0xFF000000).withOpacity(0.25),
      ),
    ],
  );
  static final profileFieldValue =
      GoogleFonts.nunito(fontSize: 20, color: Palette.cream);

  /// --> SHARED WIDGETS
  /// // --> BOTTOM BAR
  static final bottomBarHeading = GoogleFonts.nunito(
      fontSize: 18, color: Palette.green, fontWeight: FontWeight.w600);
  static final bottomBarType = GoogleFonts.nunito(
      fontSize: 16, color: Palette.cream, fontWeight: FontWeight.w700);
  static final bottomBarNormal = GoogleFonts.nunito(
      fontSize: 16, color: Palette.cream, fontWeight: FontWeight.w500);

  ///
}
