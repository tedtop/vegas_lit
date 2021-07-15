import 'package:vegas_lit/config/enum.dart';

class BetsDataHelper {
  static String betHistoryWinningBetsRatioText() {
    return 'Winning Bets';
  }

  static String leaderboardWinningBetsRatio(int betsWon, int betsLost) {
    return 'Wins: ${(betsWon / (betsWon + betsLost)).isNaN ? 0 : (betsWon / (betsWon + betsLost) * 100).toStringAsFixed(0)}%';
  }

  static String betHistoryWinningBetsRatio(int betsWon, int betsLost) {
    return '${(betsWon / (betsWon + betsLost)).isNaN ? 0 : (betsWon / (betsWon + betsLost) * 100).toStringAsFixed(0)}%';
  }

  static String whichBetSystemFromString(String betType) {
    if (betType == 'moneyline') {
      return 'MONEYLINE';
    }
    if (betType == 'pointspread') {
      return 'POINT SPREAD';
    }
    if (betType == 'total') {
      return 'TOTAL O/U';
    } else {
      return 'ERROR';
    }
  }

  static String whichBetSystemFromEnum(Bet betType) {
    if (betType == Bet.ml) {
      return 'MONEYLINE';
    }
    if (betType == Bet.pts) {
      return 'POINT SPREAD';
    }
    if (betType == Bet.tot) {
      return 'TOTAL O/U';
    } else {
      return 'Error';
    }
  }
}
