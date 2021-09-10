import 'package:flutter/material.dart';
import 'package:vegas_lit/config/extensions.dart';

import 'palette.dart';

class Styles {
  static const double normalElevation = 4.0;

  static final ShapeBorder smallRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6.0),
  );

  static final ShapeBorder largeRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  );
  static final versionText = VLTextStyle.nunito.creamColored.size(12);

  static final pageTitle =
      VLTextStyle.nunito.greenColored.size(36).bold.withShadows(<Shadow>[
    Shadow(
      offset: const Offset(0, 4.0),
      blurRadius: 4.0,
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
  static final betHistoryCardNormal = VLTextStyle.nunito.creamColored.size(14);
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
  static final betSlipSmallBoldText =
      VLTextStyle.nunito.creamColored.size(12).bold;
  static final betSlipButtonText =
      VLTextStyle.nunito.creamColored.size(13).bold;

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
      VLTextStyle.nunito.creamColored.size(16).w300;

  static final openBetsEmpty = VLTextStyle.nunito.creamColored.size(18).w300;
  static final openBetsCardNormal = VLTextStyle.nunito.creamColored.size(14);

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
      offset: const Offset(0, 2.0),
      blurRadius: 2.0,
      color: const Color(0xFF000000).withOpacity(0.25),
    ),
  ]);

  static final profileFieldValue = VLTextStyle.nunito.creamColored.size(20);

  /// --> GROUPS
  /// // --> CREATE GROUP
  static final groupFieldHeading =
      VLTextStyle.nunito.creamColored.size(18).w700;
  static final groupFieldDescription = VLTextStyle.nunito.creamColored.size(14);

  static const groupFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(4),
    ),
  );
  static const groupFieldFocusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Palette.cream),
    borderRadius: BorderRadius.all(
      Radius.circular(4),
    ),
  );

  /// --> SHARED WIDGETS
  /// // --> BOTTOM BAR
  static final bottomBarHeading = VLTextStyle.nunito.greenColored.size(18).w600;
  static final bottomBarType = VLTextStyle.nunito.creamColored.size(16).w700;
  static final bottomBarNormal =
      VLTextStyle.nunito.creamColored.size(16).semiBold;

  ///
}
