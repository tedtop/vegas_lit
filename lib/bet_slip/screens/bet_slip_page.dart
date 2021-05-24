import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/bet_slip/screens/bet_slip_reward_ad.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/home/widgets/bottombar.dart';
import 'package:vegas_lit/open_bets/cubit/open_bets_cubit.dart';

import '../cubit/bet_slip_cubit.dart';
import '../widgets/bet_slip_card.dart';
import 'bet_slip_empty.dart';

class BetSlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isBetPlaced =
        context.read<OpenBetsCubit>().state.openBetsDataList.isNotEmpty;
    return Scaffold(
      body: ListView(children: [
        BlocBuilder<BetSlipCubit, BetSlipState>(
          builder: (context, state) {
            switch (state.status) {
              case BetSlipStatus.opened:
                return state.betSlipCardData.isEmpty
                    ? isBetPlaced
                        ? RewardedBetSlip()
                        : EmptyBetSlip()
                    : BetSlipList();
                break;
              default:
                return const CircularProgressIndicator();
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

// class BetSlipUpper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final betSlipState = context.watch<BetSlipCubit>().state;
//     return Container(
//       height: 40,
//       color: Palette.green,
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text('BET SLIP'),
//             betSlipState.status == BetSlipStatus.opened
//                 ? Container(
//                     height: 20,
//                     width: 20,
//                     color: betSlipState.games.isEmpty
//                         ? Palette.darkGrey
//                         : Palette.cream,
//                     child: Center(
//                       child: Text(
//                         betSlipState.games.length.toString(),
//                         style: GoogleFonts.nunito(
//                           color: betSlipState.games.isEmpty
//                               ? Palette.cream
//                               : Palette.darkGrey,
//                         ),
//                       ),
//                     ),
//                   )
//                 : const SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
        // padding: EdgeInsets.symmetric(
        //   horizontal: kIsWeb ? width / 2 : 0,
        // ),

        key: Key(
          '${betSlipState.betSlipCardData.length}',
        ),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        children: [
          BetSlipUpper(),
          ListView.builder(
            reverse: true,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: betSlipState.betSlipCardData.length,
            itemBuilder: (context, index) {
              return BetSlipCard.route(
                betSlipCardData: betSlipState.betSlipCardData[index],
              );
            },
          ),
          kIsWeb ? const BottomBar() : const SizedBox(),
        ],
      ),
    );
  }
}
