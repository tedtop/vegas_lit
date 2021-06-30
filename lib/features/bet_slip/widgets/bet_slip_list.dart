import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bet_slip.dart';

class BetSlipList extends StatelessWidget {
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
          '${betSlipState.betSlipCard.length}',
        ),
        reverse: true,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: betSlipState.betSlipCard.length,
        itemBuilder: (context, index) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: betSlipState.betSlipCard[index],
            ),
          );
        },
      ),
    );
  }
}
