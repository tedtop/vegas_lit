import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../../../data/models/ncaab/ncaab_game.dart';
import '../../../../../data/repositories/sports_repository.dart';

part 'ncaab_state.dart';

class NcaabCubit extends Cubit<NcaabState> {
  NcaabCubit({@required SportsRepository sportsfeedRepository})
      : assert(sportsfeedRepository != null),
        _sportsfeedRepository = sportsfeedRepository,
        super(
          const NcaabState.initial(),
        );
  final SportsRepository _sportsfeedRepository;

  Future<void> fetchNcaabGames() async {
    const league = 'NCAAB';
    final localTimeZone = DateTime.now();
    final estTimeZone = fetchTimeEST();

    List<NcaabGame> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchNCAAB(
          dateTime: estTimeZone,
        )
        .then(
          (value) => value
              .where((element) => element.status == 'Scheduled')
              .where((element) => element.dateTime.isAfter(fetchTimeEST()))
              .where((element) => element.isClosed == false)
              .toList(),
        );

    totalGames = todayGames;

    emit(NcaabState.opened(
      localTimeZone: localTimeZone,
      estTimeZone: estTimeZone,
      games: totalGames,
      league: league,
      parsedTeamData: await getNcaabParsedTeamData(),
    ));
  }
}

dynamic getNcaabParsedTeamData() async {
  final jsonData = await rootBundle.loadString('assets/json/cbb.json');
  final parsedTeamData = await json.decode(jsonData);
  return parsedTeamData;
}

DateTime fetchTimeEST() {
  tz.initializeTimeZones();
  final locationNY = tz.getLocation('America/New_York');
  final nowNY = tz.TZDateTime.now(locationNY);
  final dateTimeNY = DateTime(nowNY.year, nowNY.month, nowNY.day, nowNY.hour,
      nowNY.minute, nowNY.second);
  return dateTimeNY;
}
