import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

import 'open_bet_card.dart';

class OpenBetRow extends StatelessWidget {
  const OpenBetRow({
    Key key,
    @required this.openBets,
  })  : assert(openBets != null),
        super(key: key);

  final BetData openBets;

  @override
  Widget build(BuildContext context) {
    final odd = openBets.odds.isNegative
        ? openBets.odds.toString()
        : '+${openBets.odds}';

    var isMoneyline = true;
    var betSpread = 0.0;
    var spread = '0';

    if (openBets.betOverUnder != null || openBets.betPointSpread != null) {
      isMoneyline = openBets.betType == 'moneyline';
      betSpread = openBets.betType == 'total'
          ? openBets.betOverUnder
          : openBets.betPointSpread;
      spread = betSpread == 0
          ? ''
          : betSpread.isNegative
              ? betSpread.toString()
              : '+$betSpread';
    }

    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      color: Palette.lightGrey,
      child: Row(
        children: columnNames.keys
            .map((entry) => SizedBox(
                  child: Builder(builder: (context) {
                    switch (entry) {
                      case 'Game':
                        return Stack(
                          fit: StackFit.passthrough,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          topLeft: Radius.circular(8)),
                                      color: Palette.darkGrey,
                                    ),
                                    width: (columnNames[entry] / 2) - 15,
                                    child: Center(
                                      child: Text(
                                        '${openBets.awayTeamName.toUpperCase()}',
                                        style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      color: Palette.darkGrey,
                                    ),
                                    width: (columnNames[entry] / 2) - 15,
                                    child: Center(
                                      child: Text(
                                        '${openBets.homeTeamName.toUpperCase()}',
                                        style: GoogleFonts.nunito(
                                          color: Palette.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 23, vertical: 18),
                              child: Center(child: Text('@')),
                            )
                          ],
                        );
                      // case 'Bet Type':
                      //   return Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 23, vertical: 18),
                      //     child: Text(openBets.betType,
                      //         style: GoogleFonts.nunito(
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.w300,
                      //           color: Palette.cream,
                      //         )),
                      //   );
                      case 'Bet':
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 18),
                          child: Text(
                              '${whichBetSystem(openBets.betType)}  ${isMoneyline ? '' : spread}  $odd',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Palette.cream,
                              )),
                        );
                      case 'Risking':
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 18),
                          child: Text('\$${openBets.betAmount}',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Palette.cream,
                              )),
                        );
                      case 'To Win':
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 18),
                          child: Text('\$${openBets.betProfit}',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Palette.cream,
                              )),
                        );
                      case 'Time Remaining':
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 18),
                          child: CountdownTimer(
                            endTime: DateTime.parse(openBets.gameDateTime)
                                .millisecondsSinceEpoch,
                            widgetBuilder: (_, CurrentRemainingTime time) {
                              if (time == null) {
                                return Text(
                                  'In Progress',
                                  style: GoogleFonts.nunito(
                                    color: Palette.red,
                                    fontSize: 15,
                                  ),
                                );
                              }

                              final hours =
                                  time.hours == null ? '' : '${time.hours}hr';
                              final min =
                                  time.min == null ? '' : '${time.min}m';
                              final sec =
                                  time.sec == null ? '' : '${time.sec}s';

                              return Text(
                                'Starting in $hours $min $sec',
                                style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  color: Palette.red,
                                ),
                              );
                            },
                          ),
                        );
                      default:
                        return const SizedBox();
                    }
                  }),
                  width: columnNames[entry].toDouble(),
                ))
            .toList(),
      ),
    );
  }
}

class OpenBetColumns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      color: Palette.lightGrey,
      child: Row(
        children: columnNames.keys
            .map((entry) => SizedBox(
                  child: Text(
                    entry,
                    style: Styles.normalTextBold
                        .copyWith(color: Palette.cream, fontSize: 16),
                  ),
                  width: columnNames[entry].toDouble(),
                ))
            .toList(),
      ),
    );
  }
}

const columnNames = {
  '': 20,
  'Game': 300,
  'Bet': 300,
  'Risking': 150,
  'To Win': 160,
  'Time Remaining': 280
};
