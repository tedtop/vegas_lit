import 'package:flutter/material.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

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

  // Can be used for bets from sportdata.io for now
  static Widget whichBetTextWidget(dynamic betData) {
    final odds = betData?.odds?.isNegative ?? 0.isNegative
        ? betData.odds.toString()
        : '+${betData.odds}';
    final isPointSpreadNegative =
        betData?.betPointSpread?.isNegative ?? 0.isNegative;
    final overUnder = betData.betTeam == 'away'
        ? '+${betData.betOverUnder}'
        : '-${betData.betOverUnder}';
    final awayTeamPointSpread = isPointSpreadNegative
        ? betData?.betPointSpread?.abs() ?? 0
        : betData?.betPointSpread != null
            ? -betData?.betPointSpread?.abs()
            : 0;
    final homeTeamPointSpread = isPointSpreadNegative
        ? betData?.betPointSpread != null
            ? -betData?.betPointSpread?.abs()
            : 0
        : betData?.betPointSpread?.abs() ?? 0;
    switch (betData.betType) {
      case 'moneyline':
        return Column(
          children: [
            RichText(
              text: TextSpan(
                style: Styles.openBetsCardNormal,
                children: [
                  betData.betTeam == 'away'
                      ? TextSpan(
                          text: '${betData.awayTeamName.toUpperCase()} ',
                          style: Styles.openBetsCardNormal,
                        )
                      : TextSpan(
                          text: '${betData.homeTeamName.toUpperCase()} ',
                          style: Styles.openBetsCardNormal
                              .copyWith(color: Palette.green),
                        ),
                  const TextSpan(text: 'TO WIN'),
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '(ML) ${BetsDataHelper.whichBetSystemFromString(betData.betType)}  ($odds)',
              style: Styles.openBetsCardNormal,
            ),
          ],
        );
        break;
      case 'pointspread':
        if (betData.betTeam == 'away') {
          return Column(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${betData.awayTeamName.toUpperCase()} ',
                      style: Styles.openBetsCardNormal,
                    ),
                    awayTeamPointSpread.isNegative
                        ? TextSpan(
                            text: '(-${awayTeamPointSpread.abs()})',
                            style: Styles.openBetsCardNormal,
                          )
                        : TextSpan(
                            text: '(+${awayTeamPointSpread.abs()})',
                            style: Styles.openBetsCardNormal,
                          ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '(PTS) POINT SPREAD ($odds)',
                style: Styles.openBetsCardNormal,
              )
            ],
          );
        } else {
          return Column(
            children: [
              RichText(
                text: TextSpan(
                  style: Styles.openBetsCardNormal,
                  children: [
                    TextSpan(
                      text: '${betData.homeTeamName.toUpperCase()} ',
                      style: Styles.openBetsCardNormal.copyWith(
                        color: Palette.green,
                      ),
                    ),
                    homeTeamPointSpread.isNegative
                        ? TextSpan(
                            text: '(-${homeTeamPointSpread.abs()})',
                            style: Styles.openBetsCardNormal,
                          )
                        : TextSpan(
                            text: '(+${homeTeamPointSpread.abs()})',
                            style: Styles.openBetsCardNormal,
                          ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '(PTS) POINT SPREAD ($odds)',
                style: Styles.openBetsCardNormal,
              )
            ],
          );
        }
        break;
      case 'total':
        if (betData.betTeam == 'away') {
          return Column(
            children: [
              Text(
                '${betData.awayTeamName.toUpperCase()} OVER ($overUnder)',
                style: Styles.openBetsCardNormal,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '(TOT) TOTAL O/U ($odds)',
                style: Styles.openBetsCardNormal,
              )
            ],
          );
        } else {
          return Column(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${betData.homeTeamName.toUpperCase()}',
                      style: Styles.openBetsCardNormal.copyWith(
                        color: Palette.green,
                      ),
                    ),
                    TextSpan(
                      text: ' UNDER ($overUnder)',
                      style: Styles.openBetsCardNormal,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '(TOT) TOTAL O/U ($odds)',
                style: Styles.openBetsCardNormal,
              )
            ],
          );
        }
        break;
      default:
        return Center(
          child: Text(
            'NO DATA FOUND',
            style: Styles.openBetsCardNormal,
          ),
        );
    }
  }
}
