enum Routes {
  // Main Screens
  sportsbook,
  betSlip,
  leaderboard,
  openBets,
  betHistory,

  profile,
  leaderboardProfile,

  rules,
}

extension RoutesExtension on Routes {
  String get screenClass {
    switch (this) {
      case Routes.sportsbook:
        return 'SportsbookRoute';
      case Routes.betSlip:
        return 'BetSlipRoute';
      case Routes.leaderboard:
        return 'LeaderboardRoute';
      case Routes.openBets:
        return 'OpenBetsRoute';
      case Routes.betHistory:
        return 'BetHistoryRoute';
      case Routes.profile:
        return 'ProfileRoute';
      case Routes.leaderboardProfile:
        return 'LeaderboardProfileRoute';
      case Routes.rules:
        return 'RulesRoute';
    }
  }

  String get screenName {
    switch (this) {
      case Routes.sportsbook:
        return 'Sportsbook';
      case Routes.betSlip:
        return 'BetSlip';
      case Routes.leaderboard:
        return 'Leaderboard';
      case Routes.openBets:
        return 'OpenBets';
      case Routes.betHistory:
        return 'BetHistory';
      case Routes.profile:
        return 'Profile';
      case Routes.leaderboardProfile:
        return 'LeaderboardProfile';
      case Routes.rules:
        return 'Rules';
    }
  }
}
