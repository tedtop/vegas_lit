import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/features/games/basketball/ncaab/models/ncaab_team.dart';

import '../../../../../../config/enum.dart';
import '../../../../../../config/extensions.dart';
import '../../../../../../config/palette.dart';
import '../../../../../../config/styles.dart';
import '../../../../../../data/models/ncaab/ncaab_game.dart';
import '../../views/team_info/team_info.dart';
import '../bet_button/bet_button.dart';

class MatchupCard extends StatelessWidget {
  const MatchupCard._({
    Key? key,
    required this.gameName,
    required this.game,
    required this.homeTeamData,
    required this.awayTeamData,
  }) : super(key: key);

  final String gameName;
  final NcaabGame game;
  final NcaabTeam homeTeamData;
  final NcaabTeam awayTeamData;

  static Builder route({
    required NcaabGame game,
    required String gameName,
    required NcaabTeam homeTeamData,
    required NcaabTeam awayTeamData,
  }) {
    return Builder(
      builder: (_) {
        return MatchupCard._(
          gameName: gameName,
          game: game,
          awayTeamData: awayTeamData,
          homeTeamData: homeTeamData,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPointSpreadNegative =
        game.pointSpread == null ? true : game.pointSpread!.isNegative;
    late String awayTeamPointSpread;
    late String homeTeamPointSpread;
    if (game.pointSpread != null) {
      awayTeamPointSpread = isPointSpreadNegative
          ? '+${game.pointSpread!.abs()}'
          : '-${game.pointSpread!.abs()}';
      homeTeamPointSpread = isPointSpreadNegative
          ? '-${game.pointSpread!.abs()}'
          : '+${game.pointSpread!.abs()}';
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
                                          teamData: awayTeamData,
                                          gameName: gameName)),
                                  child: Column(
                                    children: [
                                      Text(
                                        awayTeamData.school!,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunito(
                                          fontSize: 12,
                                          color: Palette.cream,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        awayTeamData.name!.toUpperCase(),
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
                                  if (game.awayTeamMoneyLine == null)
                                    Container()
                                  else
                                    BetButton.route(
                                      winTeam: BetButtonWin.away,
                                      mainOdds:
                                          game.awayTeamMoneyLine.toString(),
                                      spread: 0,
                                      betType: Bet.ml,
                                      awayTeamData: awayTeamData,
                                      homeTeamData: homeTeamData,
                                      text: positiveNumber(
                                          game.awayTeamMoneyLine),
                                      game: game,
                                      league: whichGame(
                                        gameName: gameName,
                                      ),
                                    ),
                                  if (game.pointSpreadAwayTeamMoneyLine == null)
                                    Container()
                                  else
                                    BetButton.route(
                                      winTeam: BetButtonWin.away,
                                      mainOdds: game
                                          .pointSpreadAwayTeamMoneyLine
                                          .toString(),
                                      spread: double.parse(awayTeamPointSpread),
                                      betType: Bet.pts,
                                      league: whichGame(
                                        gameName: gameName,
                                      ),
                                      awayTeamData: awayTeamData,
                                      homeTeamData: homeTeamData,
                                      game: game,
                                      text:
                                          '$awayTeamPointSpread     ${positiveNumber(game.pointSpreadAwayTeamMoneyLine)}',
                                    ),
                                  if (game.overPayout == null)
                                    Container()
                                  else
                                    BetButton.route(
                                      winTeam: BetButtonWin.away,
                                      league: whichGame(
                                        gameName: gameName,
                                      ),
                                      spread: game.overUnder!,
                                      mainOdds: game.overPayout.toString(),
                                      betType: Bet.tot,
                                      awayTeamData: awayTeamData,
                                      homeTeamData: homeTeamData,
                                      game: game,
                                      text:
                                          'o${game.overUnder}     ${positiveNumber(game.overPayout)}',
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
                            if (game.homeTeamMoneyLine == null)
                              Container()
                            else
                              _betButtonSeparator(text: 'ML'),
                            const SizedBox(height: 2),
                            if (game.pointSpreadHomeTeamMoneyLine == null)
                              Container()
                            else
                              _betButtonSeparator(text: 'PTS'),
                            const SizedBox(height: 1),
                            if (game.underPayout == null)
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
                                        teamData: homeTeamData,
                                        gameName: gameName)),
                                child: Column(
                                  children: [
                                    Text(
                                      homeTeamData.school!,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunito(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Palette.green,
                                      ),
                                    ),
                                    Text(
                                      homeTeamData.name!.toUpperCase(),
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
                                  if (game.homeTeamMoneyLine == null)
                                    Container()
                                  else
                                    BetButton.route(
                                      winTeam: BetButtonWin.home,
                                      league: whichGame(
                                        gameName: gameName,
                                      ),
                                      mainOdds:
                                          game.homeTeamMoneyLine.toString(),
                                      betType: Bet.ml,
                                      game: game,
                                      spread: 0,
                                      awayTeamData: awayTeamData,
                                      homeTeamData: homeTeamData,
                                      text: positiveNumber(
                                          game.homeTeamMoneyLine),
                                    ),
                                  if (game.pointSpreadHomeTeamMoneyLine == null)
                                    Container()
                                  else
                                    BetButton.route(
                                      winTeam: BetButtonWin.home,
                                      spread: double.parse(homeTeamPointSpread),
                                      league: whichGame(
                                        gameName: gameName,
                                      ),
                                      mainOdds: game
                                          .pointSpreadHomeTeamMoneyLine
                                          .toString(),
                                      betType: Bet.pts,
                                      awayTeamData: awayTeamData,
                                      homeTeamData: homeTeamData,
                                      game: game,
                                      text:
                                          '$homeTeamPointSpread     ${positiveNumber(game.pointSpreadHomeTeamMoneyLine)}',
                                    ),
                                  if (game.underPayout == null)
                                    Container()
                                  else
                                    BetButton.route(
                                      winTeam: BetButtonWin.home,
                                      league: whichGame(
                                        gameName: gameName,
                                      ),
                                      mainOdds: game.underPayout.toString(),
                                      betType: Bet.tot,
                                      spread: game.overUnder!,
                                      awayTeamData: awayTeamData,
                                      homeTeamData: homeTeamData,
                                      game: game,
                                      text:
                                          'u${game.overUnder}     ${positiveNumber(game.underPayout)}',
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
                              game.dateTime!.toLocal(),
                            ),
                            style: Styles.matchupTime,
                          ),
                        ],
                      ),
                    ),
                    CountdownTimer(
                      endTime: ESTDateTime.getESTmillisecondsSinceEpoch(
                          game.dateTime!),
                      widgetBuilder: (_, CurrentRemainingTime? time) {
                        if (time == null) {
                          return Text(
                            game.status!,
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
  }

  String positiveNumber(int? number) {
    final value =
        number!.isNegative ? number.toString() : '+${number.toString()}';
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
