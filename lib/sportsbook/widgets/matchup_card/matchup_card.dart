import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/sportsbook/widgets/bet_button/bet_button.dart';

import 'cubit/matchup_card_cubit.dart';

class MatchupCard extends StatelessWidget {
  const MatchupCard._({Key key}) : super(key: key);

  static Builder route({@required Game game}) {
    return Builder(
      builder: (_) {
        return BlocProvider(
          create: (context) => MatchupCardCubit()
            ..openMatchupCard(
              game: game,
            ),
          child: const MatchupCard._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchupCardCubit, MatchupCardState>(
      builder: (context, state) {
        if (state is MatchupCardOpened) {
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
                                    height: 25,
                                    child: Text(
                                      state.game.awayTeam.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: Styles.awayTeam,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Column(
                                    children: [
                                      BetButton.route(
                                        mainOdds: gameData.awayTeamMoneyLine
                                            .toString(),
                                        betType: Bet.ml,
                                        text: gameData.awayTeamMoneyLine
                                            .toString(),
                                        game: state.game,
                                      ),
                                      BetButton.route(
                                        mainOdds: gameData
                                            .pointSpreadAwayTeamMoneyLine
                                            .toString(),
                                        betType: Bet.pts,
                                        game: state.game,
                                        text:
                                            '${gameData.pointSpread}     ${gameData.pointSpreadAwayTeamMoneyLine}',
                                      ),
                                      BetButton.route(
                                        mainOdds:
                                            gameData.overPayout.toString(),
                                        betType: Bet.tot,
                                        game: state.game,
                                        text:
                                            'o${gameData.overUnder}     ${gameData.overPayout}',
                                      ),
                                    ],
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
                                const SizedBox(height: 5),
                                _betButtonSeparator(text: 'ML'),
                                _betButtonSeparator(text: 'PTS'),
                                _betButtonSeparator(text: 'TOT'),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    state.game.homeTeam.toUpperCase(),
                                    // maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.green,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Column(
                                    children: [
                                      BetButton.route(
                                        mainOdds: gameData.homeTeamMoneyLine
                                            .toString(),
                                        betType: Bet.ml,
                                        game: state.game,
                                        text: gameData.homeTeamMoneyLine
                                            .toString(),
                                      ),
                                      BetButton.route(
                                        mainOdds: gameData
                                            .pointSpreadHomeTeamMoneyLine
                                            .toString(),
                                        betType: Bet.pts,
                                        game: state.game,
                                        text:
                                            '${gameData.pointSpread}     ${gameData.pointSpreadHomeTeamMoneyLine}',
                                      ),
                                      BetButton.route(
                                        mainOdds:
                                            gameData.underPayout.toString(),
                                        betType: Bet.tot,
                                        game: state.game,
                                        text:
                                            'u${gameData.overUnder}     ${gameData.underPayout}',
                                      ),
                                    ],
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
                                  state.game.dateTime.toLocal(),
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
    String text,
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

// Column(
//                                           children: [
//                                             BetButton.route(
//                                               mainOdds: '100',
//                                               betType: Bet.ml,
//                                               text: '100',
//                                               game: state.game,
//                                             ),
//                                             BetButton.route(
//                                               mainOdds: '100',
//                                               betType: Bet.pts,
//                                               game: state.game,
//                                               text: '-112   100',
//                                             ),
//                                             BetButton.route(
//                                               mainOdds: '100',
//                                               betType: Bet.tot,
//                                               game: state.game,
//                                               text: 'o-115   100',
//                                             ),
//                                           ],
//                                         )

//  Column(
//                                           children: [
//                                             BetButton.route(
//                                               mainOdds: '100',
//                                               betType: Bet.ml,
//                                               game: state.game,
//                                               text: '134',
//                                             ),
//                                             BetButton.route(
//                                               mainOdds: '100',
//                                               betType: Bet.pts,
//                                               game: state.game,
//                                               text: '-34   143',
//                                             ),
//                                             BetButton.route(
//                                               mainOdds: '100',
//                                               betType: Bet.tot,
//                                               game: state.game,
//                                               text: '-23   156',
//                                             ),
//                                           ],
//                                         )
