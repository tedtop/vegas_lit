import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/slip/bet_slip.dart';
import 'package:vegas_lit/features/slip_card/view/slip_card_widget.dart';

import '../cubit/bet_button_cubit.dart';

class BetButton extends StatelessWidget {
  const BetButton._({Key key}) : super(key: key);

  static Builder route({
    @required String text,
    @required Game game,
    @required Bet betType,
  }) {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (_) => BetButtonCubit()
            ..openBetButton(
              text: text,
              game: game,
              betType: betType,
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
    return Expanded(
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          color: Palette.darkGrey,
          child: AutoSizeText(
            betButtonState.text,
            maxLines: 1,
            style: GoogleFonts.nunito(
              fontSize: 18,
              color: Palette.cream,
            ),
          ),
          onPressed: () {
            context.read<BetButtonCubit>().clickBetButton();
            context.read<BetSlipCubit>().addBetSlip(
                  game: BetSlipCard.route(
                    key: Key('${betButtonState.uniqueId}'),
                    betButtonCubit: context.read<BetButtonCubit>(),
                    betType: betButtonState.betType,
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
    return Expanded(
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: RaisedButton(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          color: Palette.green,
          child: AutoSizeText(
            betButtonState.text,
            maxLines: 1,
            style: GoogleFonts.nunito(
              fontSize: 18,
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
    return const Expanded(
      child: Center(
        child: Icon(Icons.thumb_up),
      ),
    );
  }
}
