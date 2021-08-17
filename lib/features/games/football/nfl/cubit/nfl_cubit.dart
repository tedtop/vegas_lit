import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/features/games/football/nfl/models/nfl_team.dart';

import '../../../../../data/models/nfl/nfl_game.dart';
import '../../../../../data/repositories/sports_repository.dart';

part 'nfl_state.dart';

class NflCubit extends Cubit<NflState> {
  NflCubit({@required SportsRepository sportsfeedRepository})
      : assert(sportsfeedRepository != null),
        _sportsfeedRepository = sportsfeedRepository,
        super(
          const NflState.initial(),
        );

  final SportsRepository _sportsfeedRepository;

  Future<void> fetchNflGames() async {
    const league = 'NFL';
    final estTimeZone = ESTDateTime.fetchTimeEST();
    List<NflGame> totalGames;
    final todayGames = await _sportsfeedRepository
        .fetchNFL(
          dateTime: estTimeZone,
          days: 2,
        )
        .then(
          (value) => value
              .where((element) => element.status == Status.SCHEDULED)
              .where((element) =>
                  element.dateTime.isAfter(ESTDateTime.fetchTimeEST()))
              .where((element) => element.closed == false)
              .toList(),
        );
    totalGames = todayGames;

    emit(
      NflState.opened(
        estTimeZone: estTimeZone,
        games: totalGames,
        league: league,
        parsedTeamData: await getNFLTeamData(),
      ),
    );
  }
}

Future<List<NflTeam>> getNFLTeamData() async {
  final jsonData = await rootBundle.loadString('assets/json/nfl.json');

  return compute(parseTeamData, jsonData);
}

List<NflTeam> parseTeamData(String jsonData) {
  final parsedTeamData = json.decode(jsonData);
  final teamData = parsedTeamData
      .map<NflTeam>(
        (json) => NflTeam.fromMap(json),
      )
      .toList();

  return teamData;
}
