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
}
