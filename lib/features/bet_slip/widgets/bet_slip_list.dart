import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/styles.dart';

import '../bet_slip.dart';
import 'parlay_bet_button/cubit/parlay_bet_button_cubit.dart';

class SingleBetSlipList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width / 10;
    final betSlipState = context.watch<BetSlipCubit>().state;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ListView.builder(
        key: Key(
          '${betSlipState.singleBetSlipCard.length}',
        ),
        reverse: true,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: betSlipState.singleBetSlipCard.length,
        itemBuilder: (context, index) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: betSlipState.singleBetSlipCard[index],
            ),
          );
        },
      ),
    );
  }
}

class ParlayBetSlipList extends StatelessWidget {
  const ParlayBetSlipList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width / 10;
    final betSlipState = context.watch<BetSlipCubit>().state;
    final betButtonState = context.watch<ParlayBetButtonCubit>().state;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ListView.builder(
        key: Key(
          '${betSlipState.parlayBetSlipCard.length}',
        ),
        //reverse: true,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: betSlipState.parlayBetSlipCard.length,
        itemBuilder: (context, index) {
          Widget betSlipCard = Align(
            alignment: Alignment.topCenter,
            heightFactor:
                index == betSlipState.parlayBetSlipCard.length - 1 ? 1.0 : 0.75,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: betSlipState.parlayBetSlipCard[
                  betSlipState.parlayBetSlipCard.length - index - 1],
            ),
          );
          if (index == betSlipState.parlayBetSlipCard.length - 1)
            betSlipCard = Stack(
              alignment: Alignment.bottomCenter,
              children: [
                betSlipCard,
                Positioned(
                  bottom: 5,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        style: Styles.betDescriptionText,
                        text:
                            '${betSlipState.parlayBetSlipCard.length} leg parlay ',
                        children: <TextSpan>[
                          TextSpan(
                              style: Styles.betNumbersText,
                              text: '(${betButtonState.betAmount})'),
                          const TextSpan(text: ' of with a payout of '),
                          TextSpan(
                              style: Styles.betNumbersText,
                              text: '${betButtonState.toWinAmount}'),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          return betSlipCard;
        },
      ),
    );
  }
}
