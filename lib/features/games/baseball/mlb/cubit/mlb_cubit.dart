import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/features/games/baseball/mlb/models/mlb_team.dart';

import '../../../../../data/models/mlb/mlb_game.dart';
import '../../../../../data/repositories/sports_repository.dart';

part 'mlb_state.dart';

class MlbCubit extends Cubit<MlbState> {
  MlbCubit({@required SportsRepository sportsfeedRepository})
      : assert(sportsfeedRepository != null),
        _sportsfeedRepository = sportsfeedRepository,
        super(
          const MlbState.initial(),
        );

  final SportsRepository _sportsfeedRepository;

  Future<void> fetchMlbGames() async {
    const league = 'MLB';
    final estTimeZone = ESTDateTime.fetchTimeEST();
    List<MlbGame> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchMLB(
          dateTime: estTimeZone,
          days: 2,
        )
        .then(
          (value) => value
              .where((element) => element.status == 'Scheduled')
              .where((element) =>
                  element.dateTime.isAfter(ESTDateTime.fetchTimeEST()))
              .where((element) => element.isClosed == false)
              .toList(),
        );
    totalGames = todayGames;

    emit(
      MlbState.opened(
        estTimeZone: estTimeZone,
        games: totalGames,
        league: league,
        parsedTeamData: await getMLBTeamData(),
      ),
    );
  }
}

Future<List<MlbTeam>> getMLBTeamData() async {
  final jsonData = await rootBundle.loadString('assets/json/mlb.json');

  return compute(parseTeamData, jsonData);
}

List<MlbTeam> parseTeamData(String jsonData) {
  final parsedTeamData = json.decode(jsonData);
  final teamData = parsedTeamData
      .map<MlbTeam>(
        (json) => MlbTeam.fromMap(json),
      )
      .toList();

  return teamData;
}
