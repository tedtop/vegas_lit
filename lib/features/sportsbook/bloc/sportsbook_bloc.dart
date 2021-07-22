import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/config/extensions.dart';

import '../../../data/repositories/sports_repository.dart';

part 'sportsbook_event.dart';
part 'sportsbook_state.dart';

class SportsbookBloc extends Bloc<SportsbookEvent, SportsbookState> {
  SportsbookBloc({@required SportsRepository sportsfeedRepository})
      : assert(sportsfeedRepository != null),
        _sportsfeedRepository = sportsfeedRepository,
        super(
          const SportsbookState.initial(),
        );

  final SportsRepository _sportsfeedRepository;

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
    yield const SportsbookState.initial();
    final list = <String>[
      'NFL',
      'NBA',
      'OLYMPICS',
      'MLB',
      'NHL',
      'NCAAF',
      'NCAAB',
      'GOLF',
      'CRICKET',
    ];

    final gameNumberMap = <String, String>{};

    final estTimeZone = ESTDateTime.fetchTimeEST();

    await Future.wait(
      list.map(
        (e) async {
          if (e == 'NFL' || e == 'NCAAF' || e == 'GOLF') {
            gameNumberMap[e] = 'OFF-SEASON';
          } else {
            final todayGamesLength =
                await mapGameLength(dateTime: estTimeZone, league: e);

            gameNumberMap[e] = todayGamesLength.toString();
          }
        },
      ).toList(),
    );

    yield SportsbookState.opened(
      league: event.league,
      gameNumbers: gameNumberMap,
      estTimeZone: estTimeZone,
    );
  }

  Stream<SportsbookState> _mapSportsbookLeagueChangeToState(
      SportsbookLeagueChange event) async* {
    yield SportsbookState.opened(
      league: event.league,
      gameNumbers: state.gameNumbers,
      estTimeZone: state.estTimeZone,
    );
  }

  // ignore: missing_return
  String whichGame({String league}) {
    switch (league) {
      case 'NBA':
        return 'nba';
        break;
      case 'MLB':
        return 'mlb';
        break;
      case 'NHL':
        return 'nhl';
        break;
      case 'NCAAB':
        return 'cbb';
        break;
      case 'NCAAF':
        return 'cfb';
        break;
      case 'NFL':
        return 'nfl';
        break;
      case 'OLYMPICS':
        return 'olympics';
      default:
        break;
    }
  }

  Future<int> mapGameLength(
      {@required DateTime dateTime, @required String league}) async {
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
                    element.dateTime.isAfter(ESTDateTime.fetchTimeEST()))
                .where((element) => element.isClosed == false)
                .length;
          },
        );
        break;
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
                    element.dateTime.isAfter(ESTDateTime.fetchTimeEST()))
                .where((element) => element.isClosed == false)
                .length;
          },
        );
        break;
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
                    element.dateTime.isAfter(ESTDateTime.fetchTimeEST()))
                .where((element) => element.isClosed == false)
                .length;
          },
        );
        break;
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
                    element.dateTime.isAfter(ESTDateTime.fetchTimeEST()))
                .where((element) => element.isClosed == false)
                .length;
          },
        );
        break;
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
                    element.dateTime.isAfter(ESTDateTime.fetchTimeEST()))
                .where((element) => element.isClosed == false)
                .length;
          },
        );
        break;
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
                    element.dateTime.isAfter(ESTDateTime.fetchTimeEST()))
                .where((element) => element.isClosed == false)
                .length;
          },
        );
        break;
      case 'CRICKET':
        return 0;
        break;
      case 'GOLF':
        return 0;
        break;
      case 'OLYMPICS':
        return await _sportsfeedRepository.fetchOlympicsGame().first.then(
          (value) {
            return kDebugMode
                ? value.length
                : value
                    .where(
                      (game) =>
                          game.startTime.isAfter(ESTDateTime.fetchTimeEST()) &&
                          (ESTDateTime.fetchTimeEST()
                                  .isSameDate(game.startTime) ||
                              ESTDateTime.fetchTimeEST()
                                  .add(const Duration(days: 1))
                                  .isSameDate(game.startTime)),
                    )
                    .toList()
                    .length;
          },
        );

        break;
      default:
        return 0;
        break;
    }
  }
}
