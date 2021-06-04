import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../home/widgets/bottombar.dart';
import '../../open_bets/cubit/open_bets_cubit.dart';

import '../cubit/bet_slip_cubit.dart';
import 'bet_slip_ad.dart';
import 'bet_slip_empty.dart';

class BetSlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isBetPlaced = context.read<OpenBetsCubit>().state.bets.isNotEmpty;
    return Scaffold(
      body: ListView(children: [
        BlocBuilder<BetSlipCubit, BetSlipState>(
          builder: (context, state) {
            switch (state.status) {
              case BetSlipStatus.opened:
                return state.betSlipCard.isEmpty
                    ? isBetPlaced
                        ? RewardedBetSlip()
                        : EmptyBetSlip()
                    : BetSlipList();
                break;
              default:
                return const CircularProgressIndicator(
                  color: Palette.cream,
                );
                break;
            }
          },
        ),
      ]),
    );
  }
}

class BetSlipUpper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        0,
        20,
        20,
      ),
      child: Text(
        'BET SLIP',
        textAlign: TextAlign.center,
        style: Styles.pageTitle,
      ),
    );
  }
}

class BetSlipList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width / 10;
    final betSlipState = context.watch<BetSlipCubit>().state;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ListView(
        key: Key(
          '${betSlipState.betSlipCard.length}',
        ),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        children: [
          BetSlipUpper(),
          ListView.builder(
            reverse: true,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: betSlipState.betSlipCard.length,
            itemBuilder: (context, index) {
              return betSlipState.betSlipCard[index];
            },
          ),
          kIsWeb ? const BottomBar() : const SizedBox(),
        ],
      ),
    );
  }
}
