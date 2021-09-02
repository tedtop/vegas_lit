import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bet_slip.dart';

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ListView.builder(
        key: Key(
          '${betSlipState.parlayBetSlipCard.length}',
        ),
        reverse: true,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: betSlipState.parlayBetSlipCard.length,
        itemBuilder: (context, index) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: betSlipState.parlayBetSlipCard[index],
            ),
          );
        },
      ),
    );
  }
}
