import 'package:api_client/api_client.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/home/home.dart';
import 'package:vegas_lit/open_bets/open_bets.dart';
import 'package:vegas_lit/open_bets/widgets/open_bet_table_widgets.dart';

class DesktopOpenBets extends StatelessWidget {
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
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 20.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Palette.cream,
                          ),
                          borderRadius: BorderRadius.circular(8)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 1220),
                          child: Column(
                            children: [
                              OpenBetColumns(),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 1220),
                                height: 8,
                                color: Palette.green,
                              ),
                              Column(
                                children: state.openBetsDataList
                                    .map((entry) => OpenBetRow(
                                          openBets: entry,
                                        ))
                                    .toList(),
                              ),
                              Container(
                                height: 8,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                  color: Palette.lightGrey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
