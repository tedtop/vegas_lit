import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/feature/sportsbook/subfeature/bet_button/bet_button.dart';

import 'cubit/game_card_cubit.dart';

class GameCard extends StatelessWidget {
  const GameCard._({Key key}) : super(key: key);

  static Builder route({@required Game game}) {
    return Builder(
      builder: (_) {
        return BlocProvider(
          create: (context) => GameCardCubit()
            ..openGameCard(
              game: game,
            ),
          child: const GameCard._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCardCubit, GameCardState>(
      builder: (context, state) {
        if (state is GameCardOpened) {
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
                                      state.game.teams.away.mascot
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: Styles.awayTeam,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  state.game.odds == null
                                      ? Column(
                                          children: [
                                            BetButton.route(
                                              mainOdds: '100',
                                              betType: Bet.ml,
                                              text: '100',
                                              game: state.game,
                                            ),
                                            BetButton.route(
                                              mainOdds: '100',
                                              betType: Bet.pts,
                                              game: state.game,
                                              text: '-112   100',
                                            ),
                                            BetButton.route(
                                              mainOdds: '100',
                                              betType: Bet.tot,
                                              game: state.game,
                                              text: 'o-115   100',
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            BetButton.route(
                                              mainOdds:
                                                  '${state.game.odds[0].moneyline.current.awayOdds}',
                                              betType: Bet.ml,
                                              text:
                                                  '${state.game.odds[0].moneyline.current.awayOdds}',
                                              game: state.game,
                                            ),
                                            BetButton.route(
                                              mainOdds:
                                                  '${state.game.odds[0].spread.current.awayOdds}',
                                              betType: Bet.pts,
                                              game: state.game,
                                              text:
                                                  '${state.game.odds[0].spread.current.away}     ${state.game.odds[0].spread.current.awayOdds}',
                                            ),
                                            BetButton.route(
                                              mainOdds:
                                                  '${state.game.odds[0].total.current.overOdds}',
                                              betType: Bet.tot,
                                              game: state.game,
                                              text:
                                                  'o${state.game.odds[0].total.current.total}     ${state.game.odds[0].total.current.overOdds}',
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
                                    state.game.teams.home.mascot.toUpperCase(),
                                    // maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.green,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  state.game.odds == null
                                      ? Column(
                                          children: [
                                            BetButton.route(
                                              mainOdds: '100',
                                              betType: Bet.ml,
                                              game: state.game,
                                              text: '134',
                                            ),
                                            BetButton.route(
                                              mainOdds: '100',
                                              betType: Bet.pts,
                                              game: state.game,
                                              text: '-34   143',
                                            ),
                                            BetButton.route(
                                              mainOdds: '100',
                                              betType: Bet.tot,
                                              game: state.game,
                                              text: '-23   156',
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            BetButton.route(
                                              mainOdds:
                                                  '${state.game.odds[0].moneyline.current.homeOdds}',
                                              betType: Bet.ml,
                                              game: state.game,
                                              text:
                                                  '${state.game.odds[0].moneyline.current.homeOdds}',
                                            ),
                                            BetButton.route(
                                              mainOdds:
                                                  '${state.game.odds[0].spread.current.homeOdds}',
                                              betType: Bet.pts,
                                              game: state.game,
                                              text:
                                                  '${state.game.odds[0].spread.current.home}     ${state.game.odds[0].spread.current.homeOdds}',
                                            ),
                                            BetButton.route(
                                              mainOdds:
                                                  '${state.game.odds[0].total.current.underOdds}',
                                              betType: Bet.tot,
                                              game: state.game,
                                              text:
                                                  'u${state.game.odds[0].total.current.total}     ${state.game.odds[0].total.current.underOdds}',
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
                                  state.game.schedule.date.toLocal(),
                                ),
                                style: Styles.matchupTime,
                              ),
                              // RichText(
                              //   text: TextSpan(
                              //     children: [
                              //       TextSpan(
                              //         text: 'Starting in',
                              //         style: Styles.moreSmallSizeColorCream,
                              //       ),
                              //       TextSpan(
                              //         text: '20hr:17m:18s',
                              //         style: Styles.moreSmallSizeColorRed,
                              //       ),
                              //     ],
                              //   ),
                              // ),
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
