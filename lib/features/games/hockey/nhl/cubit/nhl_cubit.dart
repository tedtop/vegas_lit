import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../../../../../config/extensions.dart';

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
    final estTimeZone = ESTDateTime.fetchTimeEST();

    List<NhlGame> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchNHL(
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

    emit(NhlState.opened(
      localTimeZone: localTimeZone,
      estTimeZone: estTimeZone,
      games: totalGames,
      league: league,
      parsedTeamData: await getNHLParsedTeamData(),
    ));
  }
}

Future<List> getNHLParsedTeamData() async {
  final jsonData = await rootBundle.loadString('assets/json/nhl.json');
  final parsedTeamData = await json.decode(jsonData) as List;
  return parsedTeamData;
}
