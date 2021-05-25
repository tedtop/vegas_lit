import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/data/models/cricket.dart';
import 'package:vegas_lit/features/bet_slip/bet_slip.dart';
import 'package:vegas_lit/features/bet_slip/models/bet_slip_card.dart';

import '../cubit/cricket_bet_button_cubit.dart';

class BetButton extends StatelessWidget {
  const BetButton._({Key key}) : super(key: key);

  static Builder route({
    @required String text,
    @required CricketDatum game,
    @required Bet betType,
    @required String mainOdds,
    @required awayTeamData,
    @required String league,
    @required homeTeamData,
    @required int gameId,
    @required bool isClosed,
  }) {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (_) => BetButtonCubit()
            ..openBetButton(
              gameId: gameId,
              isClosed: isClosed,
              text: text,
              mainOdds: mainOdds,
              betType: betType,
              homeTeamData: homeTeamData,
              awayTeamData: awayTeamData,
              league: league,
            ),
          child: const BetButton._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final betButtonState = context.watch<BetButtonCubit>().state;
        switch (betButtonState.status) {
          case BetButtonStatus.unclicked:
            return BetButtonUnclicked();
            break;
          case BetButtonStatus.clicked:
            return BetButtonClicked();
            break;
          case BetButtonStatus.done:
            return BetButtonDone();
            break;
          default:
            return const CircularProgressIndicator();
            break;
        }
      },
    );
  }
}

class BetButtonUnclicked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betButtonState = context.watch<BetButtonCubit>().state;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: RaisedButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          color: Palette.darkGrey,
          child: Text(
            betButtonState.text ?? '100',
            maxLines: 1,
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: Palette.cream,
            ),
          ),
          onPressed: () {
            context.read<BetButtonCubit>().clickBetButton();
            context.read<BetSlipCubit>().addBetSlip(
                  betSlipCardData: BetSlipCardData(
                    league: betButtonState.league,
                    id: betButtonState.uniqueId,
                    betType: betButtonState.betType,
                    betAmount: 0,
                    betButtonCubit: context.read<BetButtonCubit>(),
                    toWinAmount: 0,
                  ),
                );
          },
        ),
      ),
    );
  }
}

class BetButtonClicked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betButtonState = context.watch<BetButtonCubit>().state;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: RaisedButton(
          elevation: 4,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          color: Palette.green,
          child: Text(
            betButtonState.text ?? '100',
            maxLines: 1,
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: Palette.cream,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            context.read<BetButtonCubit>().unclickBetButton();
            context.read<BetSlipCubit>().removeBetSlip(
                  uniqueId: betButtonState.uniqueId,
                );
          },
        ),
      ),
    );
  }
}

class BetButtonDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: RaisedButton(
          elevation: 4,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          color: Palette.darkGrey,
          child: Text(
            'BET PLACED',
            maxLines: 1,
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: Palette.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
