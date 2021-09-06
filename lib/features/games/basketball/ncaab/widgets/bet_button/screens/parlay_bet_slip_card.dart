import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../config/extensions.dart';
import '../../../../../../../config/palette.dart';
import '../../../../../../../config/styles.dart';
import '../../../../../../bet_slip/cubit/bet_slip_cubit.dart';
import '../cubit/bet_button_cubit.dart';

class NcaabParlayBetSlipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final betButtonState = context.watch<NcaabBetButtonCubit>().state;
        final isMoneyline = betButtonState.betType == Bet.ml;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Container(
            width: 390,
            decoration: BoxDecoration(
              border: Border.all(
                color: Palette.cream,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Card(
              margin: EdgeInsets.zero,
              color: Palette.lightGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12.5, 12, 12.5, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          betButtonState.winTeam == BetButtonWin.home
                              ? isMoneyline
                                  ? Text(
                                      '${betButtonState.homeTeamData.name.toUpperCase()} TO WIN',
                                      maxLines: 1,
                                      style: GoogleFonts.nunito(
                                        fontSize: 24,
                                        color: Palette.cream,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Container()
                              : isMoneyline
                                  ? Text(
                                      '${betButtonState.awayTeamData.name.toUpperCase()} TO WIN',
                                      maxLines: 1,
                                      style: GoogleFonts.nunito(
                                        fontSize: 24,
                                        color: Palette.cream,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Container(),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                Text(
                                  betButtonState.awayTeamData.city,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    color: Palette.cream,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  betButtonState.awayTeamData.name
                                      .toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: Styles.awayTeam,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 11.0),
                                  child: Text(
                                    (whichBetSystemFromEnum(
                                        betButtonState.betType)),
                                    maxLines: 1,
                                    style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: Palette.cream,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Text(
                              '@',
                              style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Palette.cream,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              children: [
                                Text(
                                  betButtonState.homeTeamData.city,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.green,
                                  ),
                                ),
                                Text(
                                  betButtonState.homeTeamData.name
                                      .toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: Palette.green,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Text(
                                    betButtonState.text,
                                    maxLines: 1,
                                    style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: Palette.cream,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Center(
                          child: Container(
                            width: 174,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DefaultButton(
                              color: Palette.red,
                              elevation: 0,
                              text: 'CANCEL',
                              action: () {
                                context
                                    .read<NcaabBetButtonCubit>()
                                    .unclickBetButton();
                                context.read<BetSlipCubit>().removeBetSlip(
                                      betSlipDataId: betButtonState.uniqueId,
                                    );
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Center(
                          child: Text(
                              DateFormat('E, MMMM, c, y @ hh:mm a').format(
                                betButtonState.game.dateTime.toLocal(),
                              ),
                              style: GoogleFonts.nunito(
                                color: Palette.cream,
                                fontSize: 14,
                              )),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: CountdownTimer(
                            endTime: ESTDateTime.getESTmillisecondsSinceEpoch(
                                betButtonState.game.dateTime),
                            widgetBuilder: (_, CurrentRemainingTime time) {
                              if (time == null) {
                                return Text(
                                  betButtonState.game.status,
                                  style: GoogleFonts.nunito(
                                    color: Palette.red,
                                    fontSize: 15,
                                  ),
                                );
                              }

                              return Text(
                                'Starting in  ${getRemainingTimeText(time: time)}',
                                style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  color: Palette.red,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}

String getRemainingTimeText({CurrentRemainingTime time}) {
  final days = time.days == null ? '' : '${time.days}d ';
  final hours = time.hours == null ? '' : '${time.hours}hr';
  final min = time.min == null ? '' : ' ${time.min}m';
  final sec = time.sec == null ? '' : ' ${time.sec}s';
  return days + hours + min + sec;
}

String whichBetSystemFromEnum(Bet betType) {
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

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    @required this.text,
    @required this.action,
    this.color = Palette.green,
    this.elevation = Styles.normalElevation,
  })  : assert(text != null),
        super(key: key);

  final String text;
  final Function action;
  final Color color;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 174,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: 10,
                ),
              ),
              elevation: MaterialStateProperty.all(elevation),
              shape: MaterialStateProperty.all(Styles.smallRadius),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Palette.cream),
              ),
              backgroundColor: MaterialStateProperty.all(color),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Text(
            text,
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: action,
        ),
      ),
    );
  }
}
