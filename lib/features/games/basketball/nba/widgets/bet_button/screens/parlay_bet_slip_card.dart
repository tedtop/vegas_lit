import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vegas_lit/config/assets.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../config/palette.dart';
import '../../../../../../../config/styles.dart';
import '../../../../../../bet_slip/cubit/bet_slip_cubit.dart';
import '../cubit/bet_button_cubit.dart';

class NbaParlayBetSlipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final NbaBetButtonState betButtonState =
            context.watch<NbaBetButtonCubit>().state;

        final isMoneyline = betButtonState.betType == Bet.ml;
        final isPointSpread = betButtonState.betType == Bet.pts;

        return Container(
          width: 390,
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: InkWell(
                  onTap: () {
                    context.read<NbaBetButtonCubit>().unclickBetButton();
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
              Expanded(
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                    decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.srcOver,
                      image: const DecorationImage(
                        image:
                            AssetImage('${Images.betGameBGPath}nba-parlay.png'),
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.centerRight,
                      ),
                      color: Palette.lightGrey,
                      border: Border.all(
                        color: Palette.cream,
                      ),
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: isMoneyline || isPointSpread
                                ? '${betButtonState.winTeam == BetButtonWin.home ? '${betButtonState.homeTeamData!.city ?? ''} ${betButtonState.homeTeamData!.name}' : '${betButtonState.awayTeamData!.city ?? ''} ${betButtonState.awayTeamData!.name}'}'
                                : '',
                            style: Styles.betSlipAwayTeam,
                            children: <TextSpan>[
                              isMoneyline
                                  ? TextSpan(
                                      text:
                                          ' (${betButtonState.text!.split(' ').last})',
                                      //style: Styles.betSlipHomeTeam,
                                    )
                                  : isPointSpread
                                      ? TextSpan(
                                          text:
                                              ' (${betButtonState.text!.split(' ').first})'
                                          //     PTS (${betButtonState.text.split(' ').last})',
                                          //style: Styles.betSlipHomeTeam,
                                          )
                                      : TextSpan(
                                          text:
                                              '${betButtonState.winTeam == BetButtonWin.away ? 'OVER' : 'UNDER'} ${betButtonState.text!.split(' ').first.substring(1)}',
                                          //     TOT ${betButtonState.text.split(' ').last}',
                                          style: Styles.betSlipHomeTeam,
                                        ),
                            ],
                          ),
                        ),
                        Text(
                          whichBetSystemFromEnum(betButtonState.betType)
                              .toUpperCase(),
                          style: Styles.betSlipHomeTeam,
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                '${betButtonState.winTeam == BetButtonWin.home ? betButtonState.homeTeamData!.name!.toUpperCase() : betButtonState.awayTeamData!.name!.toUpperCase()}',
                            style: Styles.betSlipHomeTeam,
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    ' @ ${betButtonState.winTeam == BetButtonWin.away ? betButtonState.homeTeamData!.name!.toUpperCase() : betButtonState.awayTeamData!.name!.toUpperCase()}',
                                style: Styles.betSlipAwayTeam,
                              ),
                            ],
                          ),
                        ),
                      ],
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

String getRemainingTimeText({required CurrentRemainingTime time}) {
  final days = time.days == null ? '' : '${time.days}d ';
  final hours = time.hours == null ? '' : '${time.hours}hr';
  final min = time.min == null ? '' : ' ${time.min}m';
  final sec = time.sec == null ? '' : ' ${time.sec}s';
  return days + hours + min + sec;
}

String whichBetSystemFromEnum(Bet? betType) {
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
