import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../../../../../data/models/nba/nba_game.dart';
import '../../../../../data/repositories/sports_repository.dart';

part 'nba_state.dart';

class NbaCubit extends Cubit<NbaState> {
  NbaCubit({@required SportsRepository sportsfeedRepository})
      : assert(sportsfeedRepository != null),
        _sportsfeedRepository = sportsfeedRepository,
        super(
          const NbaState.initial(),
        );
  final SportsRepository _sportsfeedRepository;

  Future<void> fetchNbaGames() async {
    const league = 'NBA';
    final estTimeZone = fetchTimeEST();
    List<NbaGame> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchNBA(
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

    emit(NbaState.opened(
      estTimeZone: estTimeZone,
      games: totalGames,
      league: league,
      parsedTeamData: await getNBAParsedTeamData(),
    ));
  }
}

dynamic getNBAParsedTeamData() async {
  final jsonData = await rootBundle.loadString('assets/json/nba.json');
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
