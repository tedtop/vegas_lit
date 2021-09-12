import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta/meta.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../config/palette.dart';
import '../../../../../../../config/styles.dart';
import '../../../../../../bet_slip/cubit/bet_slip_cubit.dart';
import '../cubit/bet_button_cubit.dart';

class NhlParlayBetSlipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final betButtonState = context.watch<NhlBetButtonCubit>().state;
        final isMoneyline = betButtonState.betType == Bet.ml;
        final isPointSpread = betButtonState.betType == Bet.pts;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            children: [
              Container(
                width: 390,
                margin: const EdgeInsets.only(top: 10),
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
                          Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              text: TextSpan(
                                text:
                                    betButtonState.winTeam == BetButtonWin.home
                                        ? betButtonState.homeTeamData.name
                                            .toUpperCase()
                                        : betButtonState.awayTeamData.name
                                            .toUpperCase(),
                                style: Styles.homeTeam,
                                children: <TextSpan>[
                                  isMoneyline
                                      ? const TextSpan(
                                          text: ' (ML)',
                                        )
                                      : isPointSpread
                                          ? TextSpan(
                                              text:
                                                  ' ${betButtonState.text.split(' ').first} (PTS)',
                                            )
                                          : TextSpan(
                                              text:
                                                  ' @ ${betButtonState.winTeam == BetButtonWin.away ? betButtonState.homeTeamData.name.toUpperCase() : betButtonState.awayTeamData.name.toUpperCase()}',
                                              style: Styles.awayTeam,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      ' ${betButtonState.winTeam == BetButtonWin.away ? 'OVER' : 'UNDER'} ${betButtonState.text.split(' ').first.substring(1)} (TOT)',
                                                  style: Styles.homeTeam,
                                                ),
                                              ],
                                            ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              betButtonState.league.toUpperCase(),
                              style: Styles.betSlipBoxNormalText,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '\$ xxx',
                                style: Styles.betSlipSmallBoldText,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '@ ${betButtonState.text.split(' ').last}',
                                style: Styles.betSlipSmallBoldText,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '\$ PAYOUT',
                                style: Styles.awayTeam,
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 8,
                child: InkWell(
                  onTap: () {
                    context.read<NhlBetButtonCubit>().unclickBetButton();
                    context.read<BetSlipCubit>().removeBetSlip(
                          betSlipDataId: betButtonState.uniqueId,
                        );
                  },
                  child: const CircleAvatar(
                    radius: 10,
                    backgroundColor: Palette.cream,
                    child: Icon(
                      Icons.close,
                      color: Palette.darkGrey,
                      size: 16,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 15,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Palette.cream,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Palette.darkGrey,
                  ),
                  height: 20,
                  width: 90,
                  child: Center(
                    child: Text(
                      (whichBetSystemFromEnum(betButtonState.betType)),
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
