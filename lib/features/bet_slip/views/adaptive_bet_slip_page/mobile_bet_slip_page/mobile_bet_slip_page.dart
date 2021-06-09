import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/palette.dart';
import '../../../../../config/styles.dart';
import '../../../../open_bets/cubit/open_bets_cubit.dart';
import '../../../../shared_widgets/bottom_bar.dart';
import '../../../bet_slip.dart';
import '../../../widgets/bet_slip_ad.dart';
import '../../../widgets/bet_slip_empty.dart';
import '../../../widgets/bet_slip_list.dart';

class MobileBetSlipPage extends StatelessWidget {
  const MobileBetSlipPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isBetPlaced = context.read<OpenBetsCubit>().state.bets.isNotEmpty;
    return Scaffold(
      body: ListView(children: [
        const MobileBetSlipUpper(),
        BlocBuilder<BetSlipCubit, BetSlipState>(
          builder: (context, state) {
            switch (state.status) {
              case BetSlipStatus.opened:
                return Column(
                  children: [
                    state.betSlipCard.isEmpty
                        ? isBetPlaced && !kIsWeb
                            ? RewardedBetSlip()
                            : EmptyBetSlip()
                        : BetSlipList(),
                    const BottomBar()
                  ],
                );
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

class MobileBetSlipUpper extends StatelessWidget {
  const MobileBetSlipUpper({Key key}) : super(key: key);
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
