

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../config/palette.dart';
import '../../../../../config/styles.dart';
import '../../../../../data/models/cricket/cricket.dart';
import 'cubit/cricket_matchup_card_cubit.dart';

class CricketMatchupCard extends StatelessWidget {
  const CricketMatchupCard._({Key? key}) : super(key: key);

  static Builder route({
    required CricketDatum gamec,
    required String gameName,
  }) {
    return Builder(
      builder: (_) {
        return BlocProvider(
          create: (context) => CricketMatchupCardCubit()
            ..openCricketMatchupCard(
              gamec: gamec,
              gameName: gameName,
            ),
          child: const CricketMatchupCard._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CricketMatchupCardCubit, CricketMatchupCardState>(
      builder: (context, state) {
        if (state is CricketMatchupCardOpened) {
          final gameData = state.game;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Container(
              width: 390,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Palette.cream,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Card(
                margin: EdgeInsets.zero,
                color: Palette.lightGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    // height: 25,
                                    child: Column(
                                      children: [
                                        //Text(
                                        //   state.awayTeamData.city,
                                        //   textAlign: TextAlign.center,
                                        //   style: GoogleFonts.nunito(
                                        //     fontSize: 12,
                                        //     color: Palette.cream,
                                        //     fontWeight: FontWeight.bold,
                                        //   ),
                                        // ),
                                        Text(
                                          state.awayTeamData.title!
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: Styles.awayTeam,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Column(
                                    
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  '@',
                                  style: Styles.matchupSeparator,
                                ),
                                const SizedBox(height: 22),
                                if (gameData.sites![0].odds == null) Container() else _betButtonSeparator(text: 'ML'),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      //Text(
                                      //   state.homeTeamData.city,
                                      //   textAlign: TextAlign.center,
                                      //   style: GoogleFonts.nunito(
                                      //     fontSize: 12,
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Palette.green,
                                      //   ),
                                      // ),
                                      Text(
                                        state.homeTeamData.title!.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                          color: Palette.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Column(
                                    
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('EEEE, MMMM, c, y @ hh:mm a').format(
                                  state.game.commenceTime!.toLocal(),
                                ),
                                style: Styles.matchupTime,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _betButtonSeparator({
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.5),
      child: Text(
        text,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(
          color: Palette.cream,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
