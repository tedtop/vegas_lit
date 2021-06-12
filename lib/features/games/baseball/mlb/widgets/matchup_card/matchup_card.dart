import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/extensions.dart';

import '../../../../../../config/enum.dart';
import '../../../../../../config/palette.dart';
import '../../../../../../config/styles.dart';
import '../../../../../../data/models/mlb/mlb_game.dart';
import '../../views/team_info/team_info.dart';
import '../bet_button/bet_button.dart';
import 'cubit/matchup_card_cubit.dart';

class MatchupCard extends StatelessWidget {
  MatchupCard._({Key key, this.gameName}) : super(key: key);
  final String gameName;

  static Builder route({
    @required MlbGame game,
    @required String gameName,
    @required dynamic parsedTeamData,
  }) {
    return Builder(
      builder: (_) {
        return BlocProvider(
          create: (context) => MlbMatchupCardCubit()
            ..openMatchupCard(
              game: game,
              gameName: gameName,
              parsedTeamData: parsedTeamData,
            ),
          child: MatchupCard._(gameName: gameName),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MlbMatchupCardCubit, MlbMatchupCardState>(
      builder: (context, state) {
        if (state is MatchupCardOpened) {
          final gameData = state.game;
          final isPointSpreadNegative = state.game.pointSpread == null
              ? true
              : state.game.pointSpread.isNegative;
          String awayTeamPointSpread;
          String homeTeamPointSpread;
          if (state.game.pointSpread != null) {
            awayTeamPointSpread = isPointSpreadNegative
                ? '+${state.game.pointSpread.abs()}'
                : '-${state.game.pointSpread.abs()}';
            homeTeamPointSpread = isPointSpreadNegative
                ? '-${state.game.pointSpread.abs()}'
                : '+${state.game.pointSpread.abs()}';
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
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

                                      child: GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            TeamInfo.route(
                                                teamData: state.awayTeamData,
                                                gameName: gameName)),
                                        child: Column(
                                          children: [
                                            Text(
                                              state.awayTeamData.city,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.nunito(
                                                fontSize: 12,
                                                color: Palette.cream,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              state.awayTeamData.name
                                                  .toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: Styles.awayTeam,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Column(
                                      children: [
                                        gameData.awayTeamMoneyLine == null
                                            ? Container()
                                            : BetButton.route(
                                                winTeam: BetButtonWin.away,
                                                mainOdds: gameData
                                                    .awayTeamMoneyLine
                                                    .toString(),
                                                spread: 0,
                                                betType: Bet.ml,
                                                awayTeamData:
                                                    state.awayTeamData,
                                                homeTeamData:
                                                    state.homeTeamData,
                                                text: positiveNumber(
                                                    gameData.awayTeamMoneyLine),
                                                game: state.game,
                                                league: whichGame(
                                                  gameName: state.league,
                                                ),
                                              ),
                                        gameData.pointSpreadAwayTeamMoneyLine ==
                                                null
                                            ? Container()
                                            : BetButton.route(
                                                winTeam: BetButtonWin.away,
                                                mainOdds: gameData
                                                    .pointSpreadAwayTeamMoneyLine
                                                    .toString(),
                                                spread: double.parse(
                                                    awayTeamPointSpread),
                                                betType: Bet.pts,
                                                league: whichGame(
                                                  gameName: state.league,
                                                ),
                                                awayTeamData:
                                                    state.awayTeamData,
                                                homeTeamData:
                                                    state.homeTeamData,
                                                game: state.game,
                                                text:
                                                    '$awayTeamPointSpread     ${positiveNumber(gameData.pointSpreadAwayTeamMoneyLine)}',
                                              ),
                                        gameData.overPayout == null
                                            ? Container()
                                            : BetButton.route(
                                                winTeam: BetButtonWin.away,
                                                league: whichGame(
                                                  gameName: state.league,
                                                ),
                                                spread: gameData.overUnder
                                                    .toDouble(),
                                                mainOdds: gameData.overPayout
                                                    .toString(),
                                                betType: Bet.tot,
                                                awayTeamData:
                                                    state.awayTeamData,
                                                homeTeamData:
                                                    state.homeTeamData,
                                                game: state.game,
                                                text:
                                                    'o${gameData.overUnder}     ${positiveNumber(gameData.overPayout)}',
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 2),
                                  Text(
                                    '@',
                                    style: Styles.matchupSeparator,
                                  ),
                                  const SizedBox(height: 16),
                                  gameData.homeTeamMoneyLine == null
                                      ? Container()
                                      : _betButtonSeparator(text: 'ML'),
                                  const SizedBox(height: 2),
                                  gameData.pointSpreadHomeTeamMoneyLine == null
                                      ? Container()
                                      : _betButtonSeparator(text: 'PTS'),
                                  const SizedBox(height: 1),
                                  gameData.underPayout == null
                                      ? Container()
                                      : _betButtonSeparator(text: 'TOT'),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          TeamInfo.route(
                                              teamData: state.homeTeamData,
                                              gameName: state.league)),
                                      child: Column(
                                        children: [
                                          Text(
                                            state.homeTeamData.city,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunito(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.green,
                                            ),
                                          ),
                                          Text(
                                            state.homeTeamData.name
                                                .toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunito(
                                              fontSize: 16,
                                              // fontWeight: FontWeight.bold,
                                              color: Palette.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Column(
                                      children: [
                                        gameData.homeTeamMoneyLine == null
                                            ? Container()
                                            : BetButton.route(
                                                winTeam: BetButtonWin.home,
                                                league: whichGame(
                                                  gameName: state.league,
                                                ),
                                                mainOdds: gameData
                                                    .homeTeamMoneyLine
                                                    .toString(),
                                                betType: Bet.ml,
                                                game: state.game,
                                                spread: 0,
                                                awayTeamData:
                                                    state.awayTeamData,
                                                homeTeamData:
                                                    state.homeTeamData,
                                                text: positiveNumber(
                                                    gameData.homeTeamMoneyLine),
                                              ),
                                        gameData.pointSpreadHomeTeamMoneyLine ==
                                                null
                                            ? Container()
                                            : BetButton.route(
                                                winTeam: BetButtonWin.home,
                                                spread: double.parse(
                                                    homeTeamPointSpread),
                                                league: whichGame(
                                                  gameName: state.league,
                                                ),
                                                mainOdds: gameData
                                                    .pointSpreadHomeTeamMoneyLine
                                                    .toString(),
                                                betType: Bet.pts,
                                                awayTeamData:
                                                    state.awayTeamData,
                                                homeTeamData:
                                                    state.homeTeamData,
                                                game: state.game,
                                                text:
                                                    '$homeTeamPointSpread     ${positiveNumber(gameData.pointSpreadHomeTeamMoneyLine)}',
                                              ),
                                        gameData.underPayout == null
                                            ? Container()
                                            : BetButton.route(
                                                winTeam: BetButtonWin.home,
                                                league: whichGame(
                                                  gameName: state.league,
                                                ),
                                                mainOdds: gameData.underPayout
                                                    .toString(),
                                                betType: Bet.tot,
                                                spread: gameData.overUnder
                                                    .toDouble(),
                                                awayTeamData:
                                                    state.awayTeamData,
                                                homeTeamData:
                                                    state.homeTeamData,
                                                game: state.game,
                                                text:
                                                    'u${gameData.overUnder}     ${positiveNumber(gameData.underPayout)}',
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
                                  DateFormat('E, MMMM, c, y @ hh:mm a').format(
                                    state.game.dateTime.toLocal(),
                                  ),
                                  style: Styles.matchupTime,
                                ),
                              ],
                            ),
                          ),
                          CountdownTimer(
                            endTime: ESTDateTime.getESTmillisecondsSinceEpoch(
                                state.game.dateTime),
                            widgetBuilder: (_, CurrentRemainingTime time) {
                              if (time == null) {
                                return Text(
                                  gameData.status,
                                  style: GoogleFonts.nunito(
                                    color: Palette.red,
                                    fontSize: 15,
                                  ),
                                );
                              }

                              final hours =
                                  time.hours == null ? '' : ' ${time.hours}hr';
                              final min =
                                  time.min == null ? '' : ' ${time.min}m';
                              final sec =
                                  time.sec == null ? '' : ' ${time.sec}s';

                              return Text(
                                'Starting in$hours$min$sec',
                                style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  color: Palette.red,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
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

  String positiveNumber(int number) {
    final value =
        number.isNegative ? number.toString() : '+${number.toString()}';
    return value;
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

  // ignore: missing_return
  String whichGame({String gameName}) {
    switch (gameName) {
      case 'NBA':
        return 'nba';
        break;
      case 'MLB':
        return 'mlb';
        break;
      case 'NHL':
        return 'nhl';
        break;
      case 'NCAAB':
        return 'cbb';
        break;
      default:
        break;
    }
  }
}
