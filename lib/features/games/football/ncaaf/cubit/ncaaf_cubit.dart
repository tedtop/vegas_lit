

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../config/extensions.dart';
import '../../../../../data/models/ncaaf/ncaaf_game.dart';
import '../../../../../data/repositories/sports_repository.dart';
import '../models/ncaaf_team.dart';

part 'ncaaf_state.dart';

class NcaafCubit extends Cubit<NcaafState> {
  NcaafCubit({required SportsRepository sportsfeedRepository})
      : assert(sportsfeedRepository != null),
        _sportsfeedRepository = sportsfeedRepository,
        super(
          const NcaafState.initial(),
        );

  final SportsRepository _sportsfeedRepository;

  Future<void> fetchNcaafGames() async {
    const league = 'NCAAF';
    final estTimeZone = ESTDateTime.fetchTimeEST();
    List<NcaafGame> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchNCAAF(
          dateTime: estTimeZone,
          days: 2,
        )
        .then(
          (value) => value
              .where((element) => element.status == 'Scheduled')
              .where((element) =>
                  element.dateTime!.isAfter(ESTDateTime.fetchTimeEST()))
              .where((element) => element.isClosed == false)
              .where((element) {
            return element.awayTeamMoneyLine != null ||
                element.awayPointSpreadPayout != null ||
                element.overPayout != null ||
                element.homeTeamMoneyLine != null ||
                element.homePointSpreadPayout != null ||
                element.underPayout != null;
          }).toList(),
        );
    totalGames = todayGames;

    emit(
      NcaafState.opened(
        estTimeZone: estTimeZone,
        games: totalGames,
        league: league,
        parsedTeamData: await getNCAAFTeamData(),
      ),
    );
  }
}

Future<List<NcaafTeam>> getNCAAFTeamData() async {
  final jsonData = await rootBundle.loadString('assets/json/cfb.json');

  return compute(parseTeamData, jsonData);
}

List<NcaafTeam> parseTeamData(String jsonData) {
  final parsedTeamData = json.decode(jsonData) as List;
  final teamData = parsedTeamData
      .map<NcaafTeam>(
        ((Object json) => NcaafTeam.fromMap(json as Map<String, dynamic>)) as NcaafTeam Function(dynamic),
      )
      .toList();

  return teamData;
}
