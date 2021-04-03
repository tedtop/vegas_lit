import 'dart:convert';

import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vegas_lit/sportsbook/models/team.dart';

part 'matchup_card_state.dart';

class MatchupCardCubit extends Cubit<MatchupCardState> {
  MatchupCardCubit() : super(MatchupCardInitial());

  void openMatchupCard({
    @required Game game,
    @required String gameName,
  }) async {
    final teamData = await getData(gameName: gameName);
    final awayTeamData =
        teamData.singleWhere((element) => element.key == game.awayTeam);
    final homeTeamData =
        teamData.singleWhere((element) => element.key == game.homeTeam);

    emit(
      MatchupCardOpened(
        game: game,
        awayTeamData: awayTeamData,
        homeTeamData: homeTeamData,
        league: gameName,
      ),
    );
  }

  Future<List<Team>> getData({@required String gameName}) async {
    final newGame = whichGame(gameName: gameName);

    final jsonData = await rootBundle.loadString('assets/json/$newGame.json');
    final parsedTeamData = await json.decode(jsonData);
    final teamData = parsedTeamData
        .map<Team>(
          (json) => Team.fromMap(json),
        )
        .toList();

    return teamData;
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
