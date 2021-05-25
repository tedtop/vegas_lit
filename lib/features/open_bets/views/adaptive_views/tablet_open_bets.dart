import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/home/cubit/home_cubit.dart';
import 'package:vegas_lit/features/open_bets/widgets/open_bet_card.dart';

import '../../open_bets.dart';

class TabletOpenBets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'OPEN BETS',
                style: Styles.pageTitle,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 4,
          ),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Palette.cream,
              ),
              children: <TextSpan>[
                const TextSpan(
                  text:
                      // ignore: lines_longer_than_80_chars
                      'Bets shown here cannot be modified and are awaiting the outcome of the event. Once bets have been closed they will appear in your',
                ),
                TextSpan(
                    text: ' BET HISTORY ',
                    style: GoogleFonts.nunito(
                      color: Palette.green,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.read<HomeCubit>().homeChange(4);
                      }),
                const TextSpan(
                  text: 'page.',
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<OpenBetsCubit, OpenBetsState>(
          builder: (context, state) {
            switch (state.status) {
              case OpenBetsStatus.opened:
                if (state.openBetsDataList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 120),
                    child: Text(
                      // ignore: lines_longer_than_80_chars
                      'No bets placed. \nPlace some bets to show them here.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        color: Palette.cream,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                }
                return Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: GridView.count(
                    primary: true,
                    childAspectRatio: 2.5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    key: Key('${state.openBetsDataList.length}'),
                    children: state.openBetsDataList
                        .map((openBets) => FittedBox(
                              child: OpenBetsSlip(openBets: openBets),
                              fit: BoxFit.scaleDown,
                            ))
                        .toList(),
                  ),
                );

                break;
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
