import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/features/games/football/nfl/models/nfl_team.dart';

import '../../../../../../config/enum.dart';
import '../../../../../../config/extensions.dart';
import '../../../../../../config/palette.dart';
import '../../../../../../config/styles.dart';
import '../../../../../../data/models/nfl/nfl_game.dart';
import '../../views/team_info/team_info.dart';
import '../bet_button/bet_button.dart';
import 'cubit/matchup_card_cubit.dart';

class MatchupCard extends StatelessWidget {
  MatchupCard._({Key? key, this.gameName}) : super(key: key);
  final String? gameName;

  static Builder route({
    required NflGame game,
    required String? gameName,
    required List<NflTeam>? parsedTeamData,
  }) {
    return Builder(
      builder: (_) {
        return BlocProvider(
          create: (context) => NflMatchupCardCubit()
            ..openMatchupCard(
              game: game,
              gameName: gameName,
              parsedTeamData: parsedTeamData!,
            ),
          child: MatchupCard._(gameName: gameName),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NflMatchupCardCubit, NflMatchupCardState>(
      builder: (context, state) {
        if (state is MatchupCardOpened) {
          final gameData = state.game;
          final isPointSpreadNegative = state.game.pointSpread == null
              ? true
              : state.game.pointSpread!.isNegative;
          late String awayTeamPointSpread;
          late String homeTeamPointSpread;
          if (state.game.pointSpread != null) {
            awayTeamPointSpread = isPointSpreadNegative
                ? '+${state.game.pointSpread!.abs()}'
                : '-${state.game.pointSpread!.abs()}';
            homeTeamPointSpread = isPointSpreadNegative
                ? '-${state.game.pointSpread!.abs()}'
                : '+${state.game.pointSpread!.abs()}';
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
                                        onTap: () => Navigator.push<void>(
                                            context,
                                            TeamInfo.route(
                                                teamData: state.awayTeamData,
                                                gameName: gameName)),
                                        child: Column(
                                          children: [
                                            Text(
                                              state.awayTeamData.city!,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.nunito(
                                                fontSize: 12,
                                                color: Palette.cream,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              state.awayTeamData.name!
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
                                        if (gameData.awayTeamMoneyLine == null)
                                          Container()
                                        else
                                          BetButton.route(
                                            winTeam: BetButtonWin.away,
                                            gameId: gameData.globalGameId,
                                            isClosed: gameData.closed,
                                            mainOdds: gameData.awayTeamMoneyLine
                                                .toString(),
                                            spread: 0,
                                            betType: Bet.ml,
                                            awayTeamData: state.awayTeamData,
                                            homeTeamData: state.homeTeamData,
                                            text: positiveNumber(
                                                gameData.awayTeamMoneyLine!),
                                            game: state.game,
                                            league: whichGame(
                                              gameName: state.league,
                                            ),
                                          ),
                                        if (gameData
                                                .pointSpreadAwayTeamMoneyLine ==
                                            null)
                                          Container()
                                        else
                                          BetButton.route(
                                            winTeam: BetButtonWin.away,
                                            gameId: gameData.globalGameId,
                                            isClosed: gameData.closed,
                                            mainOdds: gameData
                                                .pointSpreadAwayTeamMoneyLine
                                                .toString(),
                                            spread: double.parse(
                                                awayTeamPointSpread),
                                            betType: Bet.pts,
                                            league: whichGame(
                                              gameName: state.league,
                                            ),
                                            awayTeamData: state.awayTeamData,
                                            homeTeamData: state.homeTeamData,
                                            game: state.game,
                                            text:
                                                '$awayTeamPointSpread     ${positiveNumber(gameData.pointSpreadAwayTeamMoneyLine!)}',
                                          ),
                                        if (gameData.overPayout == null)
                                          Container()
                                        else
                                          BetButton.route(
                                            winTeam: BetButtonWin.away,
                                            gameId: gameData.globalGameId,
                                            isClosed: gameData.closed,
                                            league: whichGame(
                                              gameName: state.league,
                                            ),
                                            spread: gameData.overUnder!,
                                            mainOdds:
                                                gameData.overPayout.toString(),
                                            betType: Bet.tot,
                                            awayTeamData: state.awayTeamData,
                                            homeTeamData: state.homeTeamData,
                                            game: state.game,
                                            text:
                                                'o${gameData.overUnder}     ${positiveNumber(gameData.overPayout!)}',
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
                                  if (gameData.homeTeamMoneyLine == null)
                                    Container()
                                  else
                                    _betButtonSeparator(text: 'ML'),
                                  const SizedBox(height: 2),
                                  if (gameData.pointSpreadHomeTeamMoneyLine ==
                                      null)
                                    Container()
                                  else
                                    _betButtonSeparator(text: 'PTS'),
                                  const SizedBox(height: 1),
                                  if (gameData.underPayout == null)
                                    Container()
                                  else
                                    _betButtonSeparator(text: 'TOT'),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.push<void>(
                                          context,
                                          TeamInfo.route(
                                              teamData: state.homeTeamData,
                                              gameName: state.league)),
                                      child: Column(
                                        children: [
                                          Text(
                                            state.homeTeamData.city!,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunito(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.green,
                                            ),
                                          ),
                                          Text(
                                            state.homeTeamData.name!
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
                                        if (gameData.homeTeamMoneyLine == null)
                                          Container()
                                        else
                                          BetButton.route(
                                            winTeam: BetButtonWin.home,
                                            gameId: gameData.globalGameId,
                                            isClosed: gameData.closed,
                                            league: whichGame(
                                              gameName: state.league,
                                            ),
                                            mainOdds: gameData.homeTeamMoneyLine
                                                .toString(),
                                            betType: Bet.ml,
                                            game: state.game,
                                            spread: 0,
                                            awayTeamData: state.awayTeamData,
                                            homeTeamData: state.homeTeamData,
                                            text: positiveNumber(
                                                gameData.homeTeamMoneyLine!),
                                          ),
                                        if (gameData
                                                .pointSpreadHomeTeamMoneyLine ==
                                            null)
                                          Container()
                                        else
                                          BetButton.route(
                                            gameId: gameData.globalGameId,
                                            winTeam: BetButtonWin.home,
                                            spread: double.parse(
                                                homeTeamPointSpread),
                                            isClosed: gameData.closed,
                                            league: whichGame(
                                              gameName: state.league,
                                            ),
                                            mainOdds: gameData
                                                .pointSpreadHomeTeamMoneyLine
                                                .toString(),
                                            betType: Bet.pts,
                                            awayTeamData: state.awayTeamData,
                                            homeTeamData: state.homeTeamData,
                                            game: state.game,
                                            text:
                                                '$homeTeamPointSpread     ${positiveNumber(gameData.pointSpreadHomeTeamMoneyLine!)}',
                                          ),
                                        if (gameData.underPayout == null)
                                          Container()
                                        else
                                          BetButton.route(
                                            gameId: gameData.globalGameId,
                                            winTeam: BetButtonWin.home,
                                            isClosed: gameData.closed,
                                            league: whichGame(
                                              gameName: state.league,
                                            ),
                                            mainOdds:
                                                gameData.underPayout.toString(),
                                            betType: Bet.tot,
                                            spread: gameData.overUnder!,
                                            awayTeamData: state.awayTeamData,
                                            homeTeamData: state.homeTeamData,
                                            game: state.game,
                                            text:
                                                'u${gameData.overUnder}     ${positiveNumber(gameData.underPayout!)}',
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
                                    state.game.dateTime!.toLocal(),
                                  ),
                                  style: Styles.matchupTime,
                                ),
                              ],
                            ),
                          ),
                          CountdownTimer(
                            endTime: ESTDateTime.getESTmillisecondsSinceEpoch(
                                state.game.dateTime!),
                            widgetBuilder: (_, CurrentRemainingTime? time) {
                              if (time == null) {
                                return Text(
                                  'Scheduled',
                                  style: GoogleFonts.nunito(
                                    color: Palette.red,
                                    fontSize: 15,
                                  ),
                                );
                              }

                              return Text(
                                'Starting in ${getRemainingTimeText(time: time)}',
                                style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  color: Palette.red,
                                ),
                              );
                            },
                          ),
                          // CountdownTimer(
                          //   endDateTime: state.game.dateTime,
                          // ),
                          // kDebugMode
                          //     ? Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //          Text(
                          //             'Status: ${gameData.status}',
                          //             style: Styles.matchupTime,
                          //           ),
                          //         ],
                          //       )
                          //     : Container(),
                          // kDebugMode
                          //     ? Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //          Text(
                          //             'IsClosed: ${gameData.isClosed}',
                          //             style: Styles.matchupTime,
                          //           ),
                          //         ],
                          //       )
                          //     : Container(),
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

String getRemainingTimeText({required CurrentRemainingTime time}) {
  final days = time.days == null ? '' : '${time.days}d ';
  final hours = time.hours == null ? '' : '${time.hours}hr';
  final min = time.min == null ? '' : ' ${time.min}m';
  final sec = time.sec == null ? '' : ' ${time.sec}s';
  return days + hours + min + sec;
}

String whichGame({String? gameName}) {
  switch (gameName) {
    case 'NBA':
      return 'nba';
    case 'MLB':
      return 'mlb';
    case 'NHL':
      return 'nhl';
    case 'NCAAB':
      return 'cbb';
    case 'NFL':
      return 'nfl';
    case 'NCAAF':
      return 'cfb';
    case 'OLYMPICS':
      return 'olympics';
    default:
      return 'none';
  }
}
