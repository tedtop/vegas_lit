import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../../../data/models/nhl/nhl_game.dart';
import '../../../../../data/repositories/sports_repository.dart';

part 'nhl_state.dart';

class NhlCubit extends Cubit<NhlState> {
  NhlCubit({@required SportsRepository sportsfeedRepository})
      : assert(sportsfeedRepository != null),
        _sportsfeedRepository = sportsfeedRepository,
        super(
          const NhlState.initial(),
        );
  final SportsRepository _sportsfeedRepository;

  Future<void> fetchNhlGames() async {
    const league = 'NHL';
    final localTimeZone = DateTime.now();
    final estTimeZone = fetchTimeEST();

    List<NhlGame> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchNHL(
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

    emit(NhlState.opened(
      localTimeZone: localTimeZone,
      estTimeZone: estTimeZone,
      games: totalGames,
      league: league,
      parsedTeamData: await getNHLParsedTeamData(),
    ));
  }
}

dynamic getNHLParsedTeamData() async {
  final jsonData = await rootBundle.loadString('assets/json/nhl.json');
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
