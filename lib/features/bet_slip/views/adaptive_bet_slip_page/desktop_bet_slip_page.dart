import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/palette.dart';
import '../../bet_slip.dart';
import '../../widgets/bet_slip_empty.dart';
import '../../widgets/bet_slip_list.dart';

class DesktopBetSlipPage extends StatelessWidget {
  const DesktopBetSlipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
      child: Column(
        children: [
          const DesktopBetSlipUpper(),
          BlocBuilder<BetSlipCubit, BetSlipState>(
            builder: (context, state) {
              switch (state.status) {
                case BetSlipStatus.opened:
                  return state.singleBetSlipCard!.isEmpty
                      ? EmptyBetSlip()
                      // AbstractCard(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     widgets: [
                      //      Text(
                      //         'Your Bet List is\ncurrently Empty.',
                      //         style: GoogleFonts.nunito(
                      //             fontSize: 24,
                      //             fontWeight: FontWeight.bold,
                      //             color: Palette.cream),
                      //       ),
                      //       const SizedBox(
                      //         height: 20,
                      //       ),
                      //       textPoints(
                      //         '1. Find a game you are interested in',
                      //       ),
                      //       textPoints(
                      //         '2. Click on the link you\'d like to bet on',
                      //       ),
                      //       textPoints(
                      //         // ignore: lines_longer_than_80_chars
                      //         '3. Your bet will show up in this area where you can place your bet',
                      //       ),
                      //     ],
                      //   )

                      : SingleBetSlipList();
                // ListView.builder(
                //     reverse: true,
                //     shrinkWrap: true,
                //     physics: const ClampingScrollPhysics(),
                //     itemCount: betSlipState.betSlipCard.length,
                //     itemBuilder: (context, index) {
                //       return betSlipState.betSlipCard[index];
                //     },
                //   );

                default:
                  return const CircularProgressIndicator(
                    color: Palette.cream,
                  );
              }
            },
          ),
        ],
      ),
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

class DesktopBetSlipUpper extends StatelessWidget {
  const DesktopBetSlipUpper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 5),
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Palette.green,
            ),
            child: Center(
              child: Text(
                'BET SLIP',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Palette.cream,
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<BetSlipCubit, BetSlipState>(
          builder: (context, state) {
            switch (state.status) {
              case BetSlipStatus.opened:
                return Container(
                  decoration: BoxDecoration(
                    color: Palette.cream,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  height: 40,
                  width: 42,
                  child: Center(
                    child: Text(
                      state.singleBetSlipCard!.length.toString(),
                      style: GoogleFonts.nunito(
                        color: Palette.darkGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );

              default:
                return const CircularProgressIndicator(
                  color: Palette.cream,
                );
            }
          },
        ),
        const SizedBox(
          width: 5,
        )
      ],
    );
  }
}
