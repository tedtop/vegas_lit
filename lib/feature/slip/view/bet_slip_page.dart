import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/widgets/abstract_card.dart';

import '../cubit/bet_slip_cubit.dart';

class BetSlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<BetSlipCubit, BetSlipState>(
          builder: (context, state) {
            switch (state.status) {
              case BetSlipStatus.opened:
                return state.games.isEmpty ? EmptyBetSlip() : BetSlipList();
                break;
              default:
                return const CircularProgressIndicator(
                  backgroundColor: Palette.green,
                );
                break;
            }
          },
        ),
      ],
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
      child: Text('BET SLIP',
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            fontSize: 36,
            color: Palette.green,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: const Offset(0, 4.0),
                blurRadius: 4.0,
                color: const Color(0xFF000000).withOpacity(0.25),
              ),
            ],
          )),
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

class EmptyBetSlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BetSlipUpper(),
        AbstractCard(
          crossAxisAlignment: CrossAxisAlignment.start,
          widgets: [
            Text(
              'Your Bet List is\ncurrently Empty.',
              style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Palette.cream),
            ),
            const SizedBox(
              height: 20,
            ),
            textPoints(
              '1. Find a game you are interested in',
            ),
            textPoints(
              '2. Click on the link you\'d like to bet on',
            ),
            textPoints(
              // ignore: lines_longer_than_80_chars
              '3. Your bet will show up in this area where you can place your bet',
            ),
          ],
        ),
      ],
    );
  }

  Widget textPoints(String text) {
    return Column(
      children: [
        Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w200,
            color: Palette.cream,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class BetSlipList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 10;
    final betSlipState = context.watch<BetSlipCubit>().state;
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: kIsWeb ? width / 2 : 0,
        ),
        key: Key(
          '${betSlipState.games.length}',
        ),
        shrinkWrap: true,
        children: [
          BetSlipUpper(),
          ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: betSlipState.games,
          )
        ],
      ),
    );
  }
}
