import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
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
    final estTimeZone = fetchTimeEST();
    List<MlbGame> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchMLB(
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

    emit(
      MlbState.opened(
        estTimeZone: estTimeZone,
        games: totalGames,
        league: league,
        parsedTeamData: await getMLBParsedTeamData(),
      ),
    );
  }
}

dynamic getMLBParsedTeamData() async {
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
