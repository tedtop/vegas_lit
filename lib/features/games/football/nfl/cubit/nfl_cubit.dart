import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vegas_lit/data/models/game.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:vegas_lit/data/repositories/sports_repository.dart';

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
    final localTimeZone = DateTime.now();
    final estTimeZone = fetchTimeEST();
    // final tomorrowEstTimeZone =
    //     DateTime(estTimeZone.year, estTimeZone.month, estTimeZone.day + 1);
    // List<Game> totalGames;

    // final todayGames = await _sportsfeedRepository
    //     .fetchNFL(
    //       dateTime: estTimeZone,
    //     )
    //     .then(
    //       (value) => value
    //           .where((element) => element.status == 'Scheduled')
    //           .where((element) =>element.dateTime.isAfter(fetchTimeEST()))
    //           .where((element) => element.isClosed == false)
    //           .toList(),
    //     );

    // if (greeting(dateTime: estTimeZone) == 'evening') {
    //   final tomorrowGames = await _sportsfeedRepository
    //       .fetchNFL(
    //         dateTime: tomorrowEstTimeZone,
    //       )
    //       .then(
    //         (value) => value
    //             .where((element) => element.status == 'Scheduled')
    //             .where((element) => element.isClosed == false)
    //             .toList(),
    //       );

    //   totalGames = todayGames + tomorrowGames;
    // } else {
    //   totalGames = todayGames;
    // }

    emit(NflState.opened(
      localTimeZone: localTimeZone,
      estTimeZone: estTimeZone,
      games: [],
      league: league,
      parsedTeamData: await getNflParsedTeamData(),
    ));
  }
}

dynamic getNflParsedTeamData() async {
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
