import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/extensions.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../../data/models/bet.dart';

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
                              style: Styles.openBetsCardNormal,
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
                        height: 54,
                        decoration: const BoxDecoration(
                          color: Palette.green,
                        ),
                        child: Column(
                          children: [
                            Text('you bet', style: Styles.openBetsCardBetText),
                            Text('\$${openBets.betAmount}',
                                style: Styles.openBetsCardBetMoney),
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
                              style: Styles.openBetsCardBetText.copyWith(
                                color: Palette.darkGrey,
                              ),
                            ),
                            Text(
                              '\$${openBets.betProfit}',
                              style: Styles.openBetsCardBetMoney
                                  .copyWith(color: Palette.darkGrey),
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
  final odds = betData?.odds?.isNegative ?? 0.isNegative
      ? betData.odds.toString()
      : '+${betData.odds}';
  final isPointSpreadNegative =
      betData?.betPointSpread?.isNegative ?? 0.isNegative;
  final overUnder = betData.betTeam == 'away'
      ? '${betData.betOverUnder}'
      : '${betData.betOverUnder}';
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
          Text(
            '${whichBetSystem(betData.betType)}  ($odds)',
            style: Styles.openBetsCardNormal,
          ),
          const SizedBox(
            height: 4,
          ),
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
          )
        ],
      );
      break;
    case 'pointspread':
      if (betData.betTeam == 'away') {
        return Column(
          children: [
            Text(
              '${betData.awayTeamName.toUpperCase()} TO WIN ($odds)',
              style: Styles.openBetsCardNormal,
            ),
            const SizedBox(
              height: 4,
            ),
            awayTeamPointSpread.isNegative
                ? Text(
                    'BY MORE THAN ${awayTeamPointSpread.abs()} POINTS',
                    style: Styles.openBetsCardNormal,
                  )
                : Text(
                    'OR LOSE BY LESS THAN ${awayTeamPointSpread.abs()} POINTS',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: Styles.openBetsCardNormal,
                  ),
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
                  TextSpan(text: 'TO WIN ($odds)'),
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            homeTeamPointSpread.isNegative
                ? Text(
                    'BY MORE THAN ${homeTeamPointSpread.abs()} POINTS',
                    style: Styles.openBetsCardNormal,
                  )
                : Text(
                    'OR LOSE BY LESS THAN ${homeTeamPointSpread.abs()} POINTS',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: Styles.openBetsCardNormal,
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
              style: Styles.openBetsCardNormal,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'WILL BE ABOVE $overUnder @ ($odds)',
              style: Styles.openBetsCardNormal,
            )
          ],
        );
      } else {
        return Column(
          children: [
            Text(
              'YOU BET THE COMBINED SCORE',
              style: Styles.openBetsCardNormal,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'WILL BE BELOW $overUnder @ ($odds)',
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