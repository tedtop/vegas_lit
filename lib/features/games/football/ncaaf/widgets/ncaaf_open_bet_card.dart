import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../config/extensions.dart';
import '../../../../../config/palette.dart';
import '../../../../../config/styles.dart';
import '../../../../../data/models/ncaaf/ncaaf_bet.dart';

class NcaafOpenBetCard extends StatelessWidget {
  const NcaafOpenBetCard(
      {Key key, @required this.openBets, this.isParlayBet = false})
      : assert(openBets != null),
        super(key: key);

  final NcaafBetData openBets;
  final bool isParlayBet;

  @override
  Widget build(BuildContext context) {
    final isTotal = openBets.betType == 'total';
    final isMoneyline = openBets.betType == 'moneyline';
    final isPointSpread = openBets.betType == 'pointspread';
    final odds = openBets?.odds?.isNegative ?? 0.isNegative
        ? openBets.odds.toString()
        : '+${openBets.odds}';
    final isPointSpreadNegative = openBets?.betPointSpread == null
        ? true
        : openBets?.betPointSpread?.isNegative;
    final pointSpread = openBets.betPointSpread != null
        ? (openBets.betTeam == 'home'
            ? (isPointSpreadNegative
                ? '-${openBets.betPointSpread.abs()}'
                : '+${openBets.betPointSpread.abs()}')
            : (isPointSpreadNegative
                ? '+${openBets.betPointSpread.abs()}'
                : '-${openBets.betPointSpread.abs()}'))
        : '';

    return Center(
      child: Padding(
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
                            text: openBets.betTeam == 'home'
                                ? openBets.homeTeamName.toUpperCase()
                                : openBets.awayTeamName.toUpperCase(),
                            style: Styles.openBetsCardBoldGreen,
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
                                              ' @ ${openBets.betTeam == 'away' ? openBets.homeTeamName.toUpperCase() : openBets.awayTeamName.toUpperCase()}',
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  ' ${openBets.betTeam == 'away' ? 'OVER' : 'UNDER'} ${openBets.betOverUnder} (TOT)',
                                            ),
                                          ],
                                        ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          openBets.league.toUpperCase(),
                          style: Styles.openBetsCardBold,
                        ),
                      ),

                      isTotal
                          ? Container()
                          : RichText(
                              text: TextSpan(
                                style: Styles.openBetsCardBoldGreen,
                                children: [
                                  TextSpan(
                                    text:
                                        '${openBets.awayTeamName.toUpperCase()}',
                                  ),
                                  const TextSpan(
                                    text: '  vs  ',
                                  ),
                                  TextSpan(
                                    text:
                                        '${openBets.homeTeamName.toUpperCase()}',
                                  ),
                                ],
                              ),
                            ),

                      RichText(
                        text: TextSpan(
                          children: [
                            isParlayBet
                                ? TextSpan(
                                    text: '',
                                    style: Styles.openBetsCardBold,
                                  )
                                : TextSpan(
                                    text: 'You bet \$${openBets.betAmount} @ ',
                                    style: Styles.openBetsCardBold,
                                  ),
                            TextSpan(
                              text: '$odds',
                              style: Styles.openBetsCardBold,
                            ),
                          ],
                        ),
                      ),

                      // Last Row
                      Row(
                        children: [
                          Expanded(
                            child: CountdownTimer(
                              endTime: ESTDateTime.getESTmillisecondsSinceEpoch(
                                DateTime.parse(openBets.gameStartDateTime),
                              ),
                              widgetBuilder: (_, CurrentRemainingTime time) {
                                if (time == null) {
                                  final startTime = DateTime.parse(
                                      openBets.gameStartDateTime);
                                  return Center(
                                    child: Text(
                                      'Started at ${DateFormat('hh:mm a').format(
                                        startTime,
                                      )} EST',
                                      style: Styles.openBetsCardBoldRed,
                                    ),
                                  );
                                }

                                return Center(
                                  child: Text(
                                    'Starting in  ${getRemainingTimeText(time: time)}',
                                    style: Styles.openBetsCardBold,
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
            !isParlayBet
                ? Positioned(
                    right: 8,
                    bottom: 10,
                    child: Text(
                      '\$${openBets.betProfit}',
                      style: Styles.openBetsNormalText,
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
                  color: Palette.green,
                ),
                height: 22,
                width: 90,
                child: Center(
                  child: Text(
                    whichBetSystemFromString(openBets.betType),
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

String getRemainingTimeText({CurrentRemainingTime time}) {
  final days = time.days == null ? '' : '${time.days}d ';
  final hours = time.hours == null ? '' : '${time.hours}hr';
  final min = time.min == null ? '' : ' ${time.min}m';
  final sec = time.sec == null ? '' : ' ${time.sec}s';
  return days + hours + min + sec;
}
