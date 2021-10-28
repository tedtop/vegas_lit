

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../config/extensions.dart';

import '../../../../../data/models/ncaab/ncaab_game.dart';
import '../../../../../data/repositories/sports_repository.dart';

part 'ncaab_state.dart';

class NcaabCubit extends Cubit<NcaabState> {
  NcaabCubit({required SportsRepository sportsfeedRepository})
      : assert(sportsfeedRepository != null),
        _sportsfeedRepository = sportsfeedRepository,
        super(
          const NcaabState.initial(),
        );
  final SportsRepository _sportsfeedRepository;

  Future<void> fetchNcaabGames() async {
    const league = 'NCAAB';
    final localTimeZone = DateTime.now();
    final estTimeZone = ESTDateTime.fetchTimeEST();

    List<NcaabGame> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchNCAAB(
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
                element.pointSpreadAwayTeamMoneyLine != null ||
                element.overPayout != null ||
                element.homeTeamMoneyLine != null ||
                element.pointSpreadHomeTeamMoneyLine != null ||
                element.underPayout != null;
          }).toList(),
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

Future<List?> getNcaabParsedTeamData() async {
  final jsonData = await rootBundle.loadString('assets/json/cbb.json');
  final parsedTeamData = await json.decode(jsonData) as List?;
  return parsedTeamData;
}
