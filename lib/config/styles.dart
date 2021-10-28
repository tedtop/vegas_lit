import 'package:flutter/material.dart';
import 'package:vegas_lit/config/extensions.dart';

import 'package:vegas_lit/config/palette.dart';

class Styles {
  static TextStyle emoji({double size = 18}) => VLTextStyle.emoji.size(size);

  static const double normalElevation = 4;

  static final OutlinedBorder smallRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6),
  );

  static final ShapeBorder largeRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  );
  static final versionText = VLTextStyle.nunito.creamColored.size(12);

  static final pageTitle =
      VLTextStyle.nunito.greenColored.size(36).bold.withShadows(<Shadow>[
    Shadow(
      offset: const Offset(0, 4),
      blurRadius: 4,
      color: const Color(0xFF000000).withOpacity(0.25),
    ),
  ]);

  static final normalText = VLTextStyle.nunito.creamColored.size(18);

  static final normalTextBold = VLTextStyle.nunito.creamColored.size(18).bold;

  static final largeTextBold = VLTextStyle.nunito.creamColored.size(24).bold;

  static final greenText = VLTextStyle.nunito.greenColored.size(18);

  static final greenTextBold = VLTextStyle.nunito.greenColored.size(18).bold;

  static final homeTeam = VLTextStyle.nunito.greenColored.size(16).w800;

  static final awayTeam = VLTextStyle.nunito.creamColored.size(16);

  static final matchupTime = VLTextStyle.nunito.creamColored.size(14);

  /// Same as normalTextBold
  static final matchupSeparator = VLTextStyle.nunito.creamColored.size(18).bold;

  // FEATURE SPECIFIC CUSTOM STYLES

  /// --> ADMIN VAULT
  static final adminVaultTitle = VLTextStyle.nunito.greenColored.size(28).bold;

  /// --> AUTHENTICATION
  static final signUpFieldDescription =
      VLTextStyle.nunito.creamColored.size(18).w200;

  static final signUpFieldText = VLTextStyle.nunito.creamColored.size(18).w300;
  static final signUpFieldHint = VLTextStyle.nunito.creamColored.size(18).w300;
  static final authFieldError = VLTextStyle.nunito.creamColored.size(10);
  static final signUpAgreement = VLTextStyle.nunito.creamColored.size(11);
  static final authButtonText = VLTextStyle.nunito.greenColored.size(18).bold;
  static final authNormalText = VLTextStyle.nunito.creamColored.size(18).w300;
  static const signUpInputFieldBorder = OutlineInputBorder();
  static const signUpInputFieldFocusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Palette.cream),
  );
  static const logInInputFocusedBorder = UnderlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Palette.cream),
  );
  // static final signUpInputFieldEnabledBorder = OutlineInputBorder(
  //   borderRadius: const BorderRadius.all(Radius.circular(4)),
  //   borderSide: BorderSide(color: Palette.cream.withAlpha(150)),
  // );
  static final logInInputEnabledBorder = UnderlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Palette.cream.withAlpha(150)),
  );

  /// --> BET HISTORY
  static final betHistoryCardNormal = VLTextStyle.nunito.creamColored.size(14);
  static final betHistoryCardBold =
      VLTextStyle.nunito.creamColored.size(14).bold;
  static final betHistoryCardBoldGreen =
      VLTextStyle.nunito.greenColored.size(14).bold;
  static final betHistoryCardBoldRed =
      VLTextStyle.nunito.redColored.size(14).bold;
  static final betHistoryTeamNotAway = VLTextStyle.nunito.greenColored.size(14);
  static final betHistoryTeamAway = VLTextStyle.nunito.creamColored.size(14);
  static final betHistoryAmount = VLTextStyle.nunito.creamColored.size(24).bold;
  static final betHistoryDescription =
      VLTextStyle.nunito.creamColored.size(14).bold;
  static final betHistoryNormal = VLTextStyle.nunito.creamColored.size(18).w300;
  static final betHistoryDropdown =
      VLTextStyle.nunito.creamColored.size(18).bold;
  static final betHistoryDesktopItem = VLTextStyle.nunito.creamColored.size(14);
  static final betHistoryDesktopField =
      VLTextStyle.nunito.creamColored.size(14).bold;
  static final betHistoryDesktopTime =
      VLTextStyle.nunito.greenColored.size(14).bold;

  /// --> BET SLIP
  static final betSlipBoxNormalText =
      VLTextStyle.nunito.creamColored.size(18).w200;
  static final betSlipBoxLargeText =
      VLTextStyle.nunito.creamColored.size(24).bold;
  static final betSlipSmallText = VLTextStyle.nunito.creamColored.size(16);
  static final betSlipSmallBoldText =
      VLTextStyle.nunito.creamColored.size(12).bold;
  static final betSlipButtonText =
      VLTextStyle.nunito.creamColored.size(13).bold;
  static final betSlipHomeTeam = VLTextStyle.nunito.greenColored.size(14).bold;
  static final betSlipAwayTeam = VLTextStyle.nunito.creamColored.size(14);

  static final betDescriptionText =
      VLTextStyle.nunito.creamColored.size(15).bold;
  static final betNumbersText = VLTextStyle.nunito.creamColored.size(16.5).bold;

  /// --> DRAWER PAGES
  /// --> GAMES

  /// // --> TEAM INFO
  static final teamStatsMain = VLTextStyle.nunito.creamColored.size(28);

  static final teamStatsText = VLTextStyle.nunito.creamColored.size(11).bold;

  /// --> HOME

  /// --> LEADERBOARD
  static final leaderboardDropdown =
      VLTextStyle.nunito.creamColored.size(18).bold;
  static final leaderboardUsername =
      VLTextStyle.nunito.creamColored.size(20).bold;
  static final leaderboardDesktopItem =
      VLTextStyle.nunito.creamColored.size(14);
  static final leaderboardDesktopField =
      VLTextStyle.nunito.creamColored.size(14).bold;

  /// --> OPEN BETS
  static final openBetsTextButton = VLTextStyle.nunito.greenColored.bold;

  static final openBetsNormalText =
      VLTextStyle.nunito.creamColored.size(18).w300;
  static final openBetsEmpty = VLTextStyle.nunito.creamColored.size(18).w300;
  static final openBetsCardNormal = VLTextStyle.nunito.creamColored.size(14);
  static final openBetsCardBold = VLTextStyle.nunito.creamColored.size(12).bold;
  static final openBetsCardBoldGreen =
      VLTextStyle.nunito.greenColored.size(12).bold;
  static final openBetsCardBoldRed =
      VLTextStyle.nunito.redColored.size(12).bold;
  static final openBetsCardTime = VLTextStyle.nunito.redColored.size(14).bold;

  static final openBetsCardBetText =
      VLTextStyle.nunito.creamColored.size(14).bold;

  static final openBetsCardBetMoney =
      VLTextStyle.nunito.creamColored.size(24).bold;

  static final openBetsDesktopField =
      VLTextStyle.nunito.creamColored.size(14).bold;

  static final openBetsDesktopItem = VLTextStyle.nunito.creamColored.size(14);
  static final openBetsDesktopTime = VLTextStyle.nunito.redColored.size(14);

  /// --> PROFILE
  static final profileUsernameLetter =
      VLTextStyle.nunito.creamColored.size(60).bold;
  static final profileUsername = VLTextStyle.nunito.creamColored.size(24).bold;
  static final profileFieldDescription =
      VLTextStyle.nunito.greenColored.size(14).withShadows(<Shadow>[
    Shadow(
      offset: const Offset(0, 2),
      blurRadius: 2,
      color: const Color(0xFF000000).withOpacity(0.25),
    ),
  ]);

  static final profileFieldValue = VLTextStyle.nunito.creamColored.size(20);

  /// --> GROUPS
  /// // --> CREATE GROUP
  static final groupFieldHeading =
      VLTextStyle.nunito.creamColored.size(18).w700;
  static final groupFieldDescription = VLTextStyle.nunito.creamColored.size(14);

  static const groupFieldBorder = OutlineInputBorder();
  static const groupFieldFocusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Palette.cream),
  );

  /// --> SHARED WIDGETS
  /// // --> BOTTOM BAR
  static final bottomBarHeading = VLTextStyle.nunito.greenColored.size(18).w600;
  static final bottomBarType = VLTextStyle.nunito.creamColored.size(16).w700;
  static final bottomBarNormal =
      VLTextStyle.nunito.creamColored.size(16).semiBold;

  ///
}
