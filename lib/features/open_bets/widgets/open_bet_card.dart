import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/data/models/bet.dart';
import 'package:vegas_lit/features/games/baseball/mlb/widgets/matchup_card/matchup_card.dart';

class OpenBetsSlip extends StatelessWidget {
  const OpenBetsSlip({
    Key key,
    @required this.openBets,
  })  : assert(openBets != null),
        super(key: key);

  final BetData openBets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 2),
      child: Stack(
        clipBehavior: Clip.none,
        // alignment: Alignment.topCenter,
        children: [
          Container(
            width: 390,
            height: 110,
            decoration: BoxDecoration(
              border: Border.all(
                color: Palette.cream,
              ),
              borderRadius: BorderRadius.circular(12),
              color: Palette.cream,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    color: Palette.darkGrey,
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 11,
                        bottom: 3,
                        left: 6,
                        right: 6,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.normal,
                                color: Palette.cream,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '${openBets.awayTeamName.toUpperCase()}',
                                ),
                                const TextSpan(text: '  @  '),
                                TextSpan(
                                  text:
                                      '${openBets.homeTeamName.toUpperCase()}',
                                  style:
                                      GoogleFonts.nunito(color: Palette.green),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          whichBetText(betData: openBets),
                          const SizedBox(
                            height: 6,
                          ),
                          // Last Row
                          Row(
                            children: [
                              Expanded(
                                child: CountdownTimer(
                                  endTime: getESTGameTimeInMS(
                                    openBets.gameStartDateTime,
                                  ),
                                  widgetBuilder:
                                      (_, CurrentRemainingTime time) {
                                    if (time == null) {
                                      return Center(
                                        child: Text(
                                          'In Progress',
                                          style: GoogleFonts.nunito(
                                            color: Palette.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }

                                    final hours = time.hours == null
                                        ? ''
                                        : ' ${time.hours}hr';
                                    final min =
                                        time.min == null ? '' : ' ${time.min}m';
                                    final sec =
                                        time.sec == null ? '' : ' ${time.sec}s';

                                    return Center(
                                      child: Text(
                                        'Starting in$hours$min$sec',
                                        style: GoogleFonts.nunito(
                                          fontSize: 14,
                                          color: Palette.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 1),
                Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 90,
                        height: 54,
                        decoration: const BoxDecoration(
                          color: Palette.green,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'you bet',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${openBets.betAmount}',
                              style: GoogleFonts.nunito(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 54,
                        decoration: const BoxDecoration(
                          color: Palette.cream,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'to win',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                color: Palette.darkGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${openBets.betProfit}',
                              style: GoogleFonts.nunito(
                                fontSize: 24,
                                color: Palette.darkGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -15,
            left: 15,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Palette.cream,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Palette.darkGrey,
              ),
              height: 25,
              width: 80,
              child: Center(
                child: Text(
                  whichBetSystem(openBets.betType),
                  style: GoogleFonts.nunito(
                    fontSize: 10,
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

Widget whichBetText({@required BetData betData}) {
  final textStyle = GoogleFonts.nunito(
    fontSize: 14,
    color: Palette.cream,
  );
  final odds =
      betData.odds.isNegative ? betData.odds.toString() : '+${betData.odds}';
  final pointSpread = betData.betPointSpread.isNegative
      ? betData.betPointSpread.toString()
      : '+${betData.betPointSpread}';
  final overUnder = betData.betTeam == 'away'
      ? '+${betData.betOverUnder}'
      : '-${betData.betOverUnder}';
  switch (betData.betType) {
    case 'moneyline':
      return Column(
        children: [
          Text(
            '${whichBetSystem(betData.betType)}  ($odds)',
            style: textStyle,
          ),
          const SizedBox(
            height: 4,
          ),
          RichText(
            text: TextSpan(
              style: textStyle,
              children: [
                betData.betTeam == 'away'
                    ? TextSpan(
                        text: '${betData.awayTeamName.toUpperCase()} ',
                        style: textStyle,
                      )
                    : TextSpan(
                        text: '${betData.homeTeamName.toUpperCase()} ',
                        style: textStyle.copyWith(color: Palette.green),
                      ),
                const TextSpan(text: 'TO WIN'),
              ],
            ),
          )
        ],
      );
      break;
    case 'pointspread':
      if (!betData.betPointSpread.isNegative) {
        return Column(
          children: [
            betData.betTeam == 'away'
                ? Text(
                    '${betData.awayTeamName.toUpperCase()} TO WIN ($odds)',
                    style: textStyle,
                  )
                : RichText(
                    text: TextSpan(
                      style: textStyle,
                      children: [
                        TextSpan(
                          text: '${betData.homeTeamName.toUpperCase()}',
                          style: textStyle.copyWith(
                            color: Palette.green,
                          ),
                        ),
                        TextSpan(text: ' TO WIN  ($odds)'),
                      ],
                    ),
                  ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'OR LOSE BY LESS THAN $pointSpread POINTS',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ],
        );
      } else {
        return Column(
          children: [
            betData.betTeam == 'away'
                ? RichText(
                    text: TextSpan(
                      style: textStyle,
                      children: [
                        TextSpan(
                          text: '${betData.homeTeamName.toUpperCase()} ',
                          style: textStyle.copyWith(
                            color: Palette.green,
                          ),
                        ),
                        TextSpan(text: 'TO WIN ($odds)'),
                      ],
                    ),
                  )
                : Text(
                    '${betData.awayTeamName.toUpperCase()} TO WIN ($odds)',
                    style: textStyle,
                  ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'BY MORE THAN $pointSpread POINTS',
              style: textStyle,
            ),
          ],
        );
      }
      break;
    case 'total':
      if (betData.betTeam == 'away') {
        return Column(
          children: [
            Text(
              'YOU BET THE COMBINED SCORE',
              style: textStyle,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'WILL BE ABOVE $overUnder @ ($odds)',
              style: textStyle,
            )
          ],
        );
      } else {
        return Column(
          children: [
            Text(
              'YOU BET THE COMBINED SCORE',
              style: textStyle,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'WILL BE BELOW $overUnder @ ($odds)',
              style: textStyle,
            )
          ],
        );
      }
      break;
    default:
      return Center(
        child: Text(
          'NO DATA FOUND',
          style: textStyle,
        ),
      );
  }
}

String whichBetSystem(String betType) {
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
