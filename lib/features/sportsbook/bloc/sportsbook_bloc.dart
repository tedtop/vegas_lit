import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../config/extensions.dart';
import '../../../data/repositories/device_repository.dart';

import '../../../data/repositories/sports_repository.dart';

part 'sportsbook_event.dart';
part 'sportsbook_state.dart';

class SportsbookBloc extends Bloc<SportsbookEvent, SportsbookState> {
  SportsbookBloc(
      {required SportsRepository sportsfeedRepository,
      required DeviceRepository deviceRepository})
      : assert(sportsfeedRepository != null),
        assert(deviceRepository != null),
        _sportsfeedRepository = sportsfeedRepository,
        _deviceRepository = deviceRepository,
        super(
          const SportsbookState.initial(isRulesShown: true),
        );

  final SportsRepository _sportsfeedRepository;
  final DeviceRepository _deviceRepository;

  @override
  Stream<SportsbookState> mapEventToState(
    SportsbookEvent event,
  ) async* {
    if (event is SportsbookOpen) {
      yield* _mapSportsbookOpenToState(event);
    }
    if (event is SportsbookLeagueChange) {
      yield* _mapSportsbookLeagueChangeToState(event);
    }
  }

  Stream<SportsbookState> _mapSportsbookOpenToState(
      SportsbookOpen event) async* {
    final isRulesShow = await _deviceRepository.isRulesShown();
    yield SportsbookState.initial(isRulesShown: isRulesShow);
    final list = <String>[
      'NFL',
      'NBA',
      'PARALYMPICS',
      'OLYMPICS',
      'MLB',
      'NHL',
      'NCAAF',
      'NCAAB',
      'GOLF',
      'CRICKET',
    ];
    if (!kIsWeb) {
      await _deviceRepository.setDefaultLeague(league: 'MLB');
      await _deviceRepository.fetchAndActivateRemote();
    }

    final league = _deviceRepository.fetchRemoteLeague();

    final gameNumberMap = <String, String>{};

    final estTimeZone = ESTDateTime.fetchTimeEST();

    await Future.wait(
      list.map(
        (e) async {
          if (e == 'GOLF' || e == 'OLYMPICS' || e == 'PARALYMPICS') {
            gameNumberMap[e] = 'OFF-SEASON';
          } else {
            final todayGamesLength =
                await mapGameLength(dateTime: estTimeZone, league: e);
            if (todayGamesLength is int && todayGamesLength != null) {
              gameNumberMap[e] = todayGamesLength.toString();
            } else {
              gameNumberMap[e] = 'OFFLINE';
            }
          }
        },
      ).toList(),
    );

    yield SportsbookState.opened(
      league: event.league ?? league,
      isRulesShown: state.isRulesShown,
      gameNumbers: gameNumberMap,
      estTimeZone: estTimeZone,
    );
  }

  Stream<SportsbookState> _mapSportsbookLeagueChangeToState(
      SportsbookLeagueChange event) async* {
    yield SportsbookState.opened(
      league: event.league,
      isRulesShown: state.isRulesShown,
      gameNumbers: state.gameNumbers,
      estTimeZone: state.estTimeZone,
    );
  }

  Future<int> mapGameLength(
      {required DateTime dateTime, required String league}) async {
    switch (league) {
      case 'NFL':
        return await _sportsfeedRepository
            .fetchNFL(
          dateTime: dateTime,
          days: 2,
        )
            .then(
          (value) {
            return value
                .where((element) => element.status == 'Scheduled')
                .where((element) =>
                    element.dateTime!.isAfter(ESTDateTime.fetchTimeEST()))
                .where((element) => element.closed == false)
                .where((element) {
              return element.awayTeamMoneyLine != null ||
                  element.pointSpreadAwayTeamMoneyLine != null ||
                  element.overPayout != null ||
                  element.homeTeamMoneyLine != null ||
                  element.pointSpreadHomeTeamMoneyLine != null ||
                  element.underPayout != null;
            }).length;
          },
        ).onError((Object error, stackTrace) => 0);

      case 'NBA':
        return await _sportsfeedRepository
            .fetchNBA(
          dateTime: dateTime,
          days: 2,
        )
            .then(
          (value) {
            return value
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
            }).length;
          },
        ).onError((Object error, stackTrace) => 0);

      case 'MLB':
        return await _sportsfeedRepository
            .fetchMLB(
          dateTime: dateTime,
          days: 2,
        )
            .then(
          (value) {
            return value
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
            }).length;
          },
        ).onError((Object error, stackTrace) => 0);

      case 'NHL':
        return await _sportsfeedRepository
            .fetchNHL(
          dateTime: dateTime,
          days: 2,
        )
            .then(
          (value) {
            return value
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
            }).length;
          },
        ).onError((Object error, stackTrace) => 0);

      case 'NCAAF':
        return await _sportsfeedRepository
            .fetchNCAAF(
          dateTime: dateTime,
          days: 2,
        )
            .then(
          (value) {
            return value
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
            }).length;
          },
        ).onError((Object error, stackTrace) => 0);

      case 'NCAAB':
        return await _sportsfeedRepository
            .fetchNCAAB(
          dateTime: dateTime,
          days: 2,
        )
            .then(
          (value) {
            return value
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
            }).length;
          },
        ).onError((Object error, stackTrace) => 0);

      case 'CRICKET':
        return 0;

      case 'GOLF':
        return 0;

      case 'OLYMPICS':
        return await _sportsfeedRepository.fetchOlympicsGame().first.then(
          (value) {
            return kDebugMode
                ? value.length
                : value
                    .where(
                      (game) =>
                          game.startTime!.isAfter(ESTDateTime.fetchTimeEST()) &&
                          (ESTDateTime.fetchTimeEST()
                                  .isSameDate(game.startTime!) ||
                              ESTDateTime.fetchTimeEST()
                                  .add(const Duration(days: 1))
                                  .isSameDate(game.startTime!)),
                    )
                    .toList()
                    .length;
          },
        );

      case 'PARALYMPICS':
        return await _sportsfeedRepository.fetchParalympicsGame().first.then(
          (value) {
            return kDebugMode
                ? value.length
                : value
                    .where(
                      (game) =>
                          game.startTime!.isAfter(ESTDateTime.fetchTimeEST()) &&
                          (ESTDateTime.fetchTimeEST()
                                  .isSameDate(game.startTime!) ||
                              ESTDateTime.fetchTimeEST()
                                  .add(const Duration(days: 1))
                                  .isSameDate(game.startTime!)),
                    )
                    .toList()
                    .length;
          },
        );

      default:
        return 0;
    }
  }
}
