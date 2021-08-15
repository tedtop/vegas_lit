import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

import 'package:vegas_lit/data/models/nfl/nfl_bet.dart';

class NflOpenBetCard extends StatelessWidget {
  const NflOpenBetCard({
    Key key,
    @required this.openBets,
  })  : assert(openBets != null),
        super(key: key);

  final NflBetData openBets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 2),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 390,
            height: 124,
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
                            height: 3,
                          ),
                          RichText(
                            text: TextSpan(
                              style: Styles.openBetsCardNormal,
                              children: [
                                TextSpan(
                                  text:
                                      '${openBets.awayTeamName.toUpperCase()}',
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: Palette.cream,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '  @  ',
                                  style: GoogleFonts.nunito(
                                    color: Palette.cream,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${openBets.homeTeamName.toUpperCase()}',
                                  style: GoogleFonts.nunito(
                                    color: Palette.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          whichBetTextWidget(openBets),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Max Payout ${openBets.betAmount + openBets.betProfit}',
                            style: Styles.openBetsCardNormal,
                          ),

                          // Last Row
                          Row(
                            children: [
                              Expanded(
                                child: CountdownTimer(
                                  endTime:
                                      ESTDateTime.getESTmillisecondsSinceEpoch(
                                    DateTime.parse(openBets.gameStartDateTime),
                                  ),
                                  widgetBuilder:
                                      (_, CurrentRemainingTime time) {
                                    if (time == null) {
                                      final startTime = DateTime.parse(
                                          openBets.gameStartDateTime);
                                      return Center(
                                        child: Text(
                                          'Started at ${DateFormat('hh:mm a').format(
                                            startTime,
                                          )} EST',
                                          style: Styles.openBetsCardTime,
                                        ),
                                      );
                                    }

                                    return Center(
                                      child: Text(
                                        'Starting in  ${getRemainingTimeText(time: time)}',
                                        style: Styles.openBetsCardTime,
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
                        height: 61,
                        decoration: const BoxDecoration(
                          color: Palette.green,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ticket cost',
                                style: Styles.openBetsCardBetText),
                            Text('${openBets.betAmount}',
                                style: Styles.openBetsCardBetMoney),
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 61,
                        decoration: const BoxDecoration(
                          color: Palette.cream,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'max win',
                              style: Styles.openBetsCardBetText.copyWith(
                                color: Palette.green,
                              ),
                            ),
                            Text(
                              '${openBets.betProfit}',
                              style: Styles.openBetsCardBetMoney
                                  .copyWith(color: Palette.green),
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
                  whichBetSystemFromString(openBets.betType),
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

String getRemainingTimeText({CurrentRemainingTime time}) {
  final days = time.days == null ? '' : '${time.days}d ';
  final hours = time.hours == null ? '' : '${time.hours}hr';
  final min = time.min == null ? '' : ' ${time.min}m';
  final sec = time.sec == null ? '' : ' ${time.sec}s';
  return days + hours + min + sec;
}

Widget whichBetTextWidget(dynamic betData) {
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
            '(ML) ${whichBetSystemFromString(betData.betType)}  ($odds)',
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
