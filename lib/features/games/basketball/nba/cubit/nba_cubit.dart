import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import '../../../../../config/extensions.dart';

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
    final estTimeZone = ESTDateTime.fetchTimeEST();
    List<NbaGame> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchNBA(
          dateTime: estTimeZone,
          days: 2,
        )
        .then(
          (value) => value
              .where((element) => element.status == 'Scheduled')
              .where((element) =>
                  element.dateTime.isAfter(ESTDateTime.fetchTimeEST()))
              .where((element) => element.isClosed == false)
              .where((element) {
            return element.awayTeamMoneyLine != null ||
                element.pointSpreadAwayTeamMoneyLine != null ||
                element.overPayout != null ||
                element.homeTeamMoneyLine != null ||
                element.pointSpreadHomeTeamMoneyLine != null ||
                element.underPayout != null;
          }).toList(),
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
  final dynamic parsedTeamData = await json.decode(jsonData);
  return parsedTeamData;
}
