import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../../../data/models/ncaaf/ncaaf_game.dart';
import '../../../../../data/repositories/sports_repository.dart';

part 'ncaaf_state.dart';

class NcaafCubit extends Cubit<NcaafState> {
  NcaafCubit({@required SportsRepository sportsfeedRepository})
      : assert(sportsfeedRepository != null),
        _sportsfeedRepository = sportsfeedRepository,
        super(
          const NcaafState.initial(),
        );
  // ignore: unused_field
  final SportsRepository _sportsfeedRepository;

  Future<void> fetchNcaafGames() async {
    const league = 'NCAAF';
    final localTimeZone = DateTime.now();
    final estTimeZone = fetchTimeEST();
    // final tomorrowEstTimeZone =
    //     DateTime(estTimeZone.year, estTimeZone.month, estTimeZone.day + 1);
    // List<Game> totalGames;

    // final todayGames = await _sportsfeedRepository
    //     .fetchNCAAF(
    //       dateTime: estTimeZone,
    //     )
    //     .then(
    //       (value) => value
    //           .where((element) => element.status == 'Scheduled')
    //           .where((element) => element.dateTime.isAfter(fetchTimeEST()))
    //           .where((element) => element.isClosed == false)
    //           .toList(),
    //     );

    // if (greeting(dateTime: estTimeZone) == 'evening') {
    //   final tomorrowGames = await _sportsfeedRepository
    //       .fetchNCAAF(
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

    emit(NcaafState.opened(
      localTimeZone: localTimeZone,
      estTimeZone: estTimeZone,
      games: [],
      league: league,
      parsedTeamData: await getNcaafParsedTeamData(),
    ));
  }
}

dynamic getNcaafParsedTeamData() async {
  final jsonData = await rootBundle.loadString('assets/json/mlb.json');
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
