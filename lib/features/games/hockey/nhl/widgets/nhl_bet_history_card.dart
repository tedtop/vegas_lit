import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../config/palette.dart';
import '../../../../../config/styles.dart';
import '../../../../../data/models/nhl/nhl_bet.dart';

class NhlBetHistoryCard extends StatelessWidget {
  const NhlBetHistoryCard(
      {Key key, @required this.betHistoryData, this.isParlayBet = false})
      : assert(betHistoryData != null),
        super(key: key);

  final NhlBetData betHistoryData;
  final bool isParlayBet;

  @override
  Widget build(BuildContext context) {
    final isWin = betHistoryData.winningTeam == betHistoryData.betTeam;
    final isMoneyline = betHistoryData.betType == 'moneyline';
    final isPointSpread = betHistoryData.betType == 'pointspread';
    final odds = betHistoryData?.odds?.isNegative ?? 0.isNegative
        ? betHistoryData.odds.toString()
        : '+${betHistoryData.odds}';
    final isPointSpreadNegative = betHistoryData?.betPointSpread == null
        ? true
        : betHistoryData?.betPointSpread?.isNegative;
    final pointSpread = betHistoryData.betPointSpread != null
        ? (betHistoryData.betTeam == 'home'
            ? (isPointSpreadNegative
                ? '-${betHistoryData.betPointSpread.abs()}'
                : '+${betHistoryData.betPointSpread.abs()}')
            : (isPointSpreadNegative
                ? '+${betHistoryData.betPointSpread.abs()}'
                : '-${betHistoryData.betPointSpread.abs()}'))
        : '';

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 16, 10, 2),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 390,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Palette.cream,
              ),
              borderRadius: BorderRadius.circular(12),
              color: Palette.cream,
            ),
            child: Card(
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              color: Palette.darkGrey,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 2,
                  left: 6,
                  right: 6,
                ),
                child: Column(
                  children: [
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: TextSpan(
                          text: betHistoryData.betTeam == 'home'
                              ? betHistoryData.homeTeamName.toUpperCase()
                              : betHistoryData.awayTeamName.toUpperCase(),
                          style: isWin
                              ? Styles.betHistoryCardBoldGreen
                              : Styles.betHistoryCardBoldRed,
                          children: <TextSpan>[
                            isMoneyline
                                ? const TextSpan(
                                    text: ' (ML)',
                                  )
                                : isPointSpread
                                    ? TextSpan(
                                        text: ' $pointSpread (PTS)',
                                      )
                                    : TextSpan(
                                        text:
                                            ' @ ${betHistoryData.betTeam == 'away' ? betHistoryData.homeTeamName.toUpperCase() : betHistoryData.awayTeamName.toUpperCase()}',
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                ' ${betHistoryData.betTeam == 'away' ? 'OVER' : 'UNDER'} ${betHistoryData.betOverUnder} (TOT)',
                                          ),
                                        ],
                                      ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        betHistoryData.league.toUpperCase(),
                        style: Styles.betHistoryCardBold,
                      ),
                    ),

                    RichText(
                      text: TextSpan(
                        style: isWin
                            ? Styles.betHistoryCardBoldGreen
                            : Styles.betHistoryCardBoldRed,
                        children: [
                          TextSpan(
                            text:
                                '${betHistoryData.awayTeamName.toUpperCase()} ${betHistoryData.awayTeamScore}',
                          ),
                          const TextSpan(
                            text: '  vs  ',
                          ),
                          TextSpan(
                            text:
                                '${betHistoryData.homeTeamName.toUpperCase()} ${betHistoryData.homeTeamScore}',
                          ),
                        ],
                      ),
                    ),

                    isWin
                        ? Text(
                            'You bet \$${betHistoryData.betAmount} @ $odds and won',
                            style: Styles.betHistoryCardBold,
                          )
                        : Text(
                            'You lost \$${betHistoryData.betAmount} @ $odds',
                            style: Styles.betHistoryCardBold,
                          ),

                    // Last Row
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              DateFormat('E, MMMM, c, y').format(
                                DateTime.parse(betHistoryData.gameStartDateTime)
                                    .toLocal(),
                              ),
                              style: Styles.betHistoryCardBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          !isParlayBet
              ? Positioned(
                  right: 8,
                  bottom: 10,
                  child: Text(
                    '\$${betHistoryData.betProfit}',
                    style: Styles.betHistoryNormal,
                  ),
                )
              : const SizedBox(),
          Positioned(
            top: -12,
            left: 15,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Palette.cream,
                ),
                borderRadius: BorderRadius.circular(12),
                color: isWin ? Palette.green : Palette.red,
              ),
              height: 20,
              width: 90,
              child: Center(
                child: Text(
                  whichBetSystemFromString(betHistoryData.betType),
                  style: GoogleFonts.nunito(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

String whichBetSystemFromString(String betType) {
  if (betType == 'moneyline') {
    return 'MONEYLINE';
  }
  if (betType == 'pointspread') {
    return 'POINT SPREAD';
  }
  if (betType == 'total') {
    return 'TOTAL O/U';
  }
  if (betType == 'olympics') {
    return 'OLYMPICS';
  } else {
    return 'ERROR';
  }
}
