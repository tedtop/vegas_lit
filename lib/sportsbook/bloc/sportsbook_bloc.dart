import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:api_client/api_client.dart';
import 'package:intl/intl.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'sportsbook_event.dart';
part 'sportsbook_state.dart';

class SportsbookBloc extends Bloc<SportsbookEvent, SportsbookState> {
  SportsbookBloc({@required SportsfeedRepository sportsfeedRepository})
      : assert(sportsfeedRepository != null),
        _sportsfeedRepository = sportsfeedRepository,
        super(
          SportsbookInitial(),
        );

  final SportsfeedRepository _sportsfeedRepository;

  @override
  Stream<SportsbookState> mapEventToState(
    SportsbookEvent event,
  ) async* {
    if (event is SportsbookOpen) {
      yield* _mapSportsbookOpenToState(event);
    }
  }

  Stream<SportsbookState> _mapSportsbookOpenToState(
      SportsbookOpen event) async* {
    yield (SportsbookInitial());
    final list = <String>['NFL', 'NBA', 'MLB', 'NHL', 'NCAAF', 'NCAAB'];

    final gameNumberMap = <String, String>{};

    final estTimeZone = fetchESTZoneNew();
    final currentTimeZone = DateTime.now();

    await Future.wait(
      list.map(
        (e) async {
          if (e == 'NFL' || e == 'NCAAF') {
            gameNumberMap[e] = 'OFF-SEASON';
          } else {
            await _sportsfeedRepository
                .fetchGameListByNewGame(
              dateTime: estTimeZone,
              gameName: e,
            )
                .then(
              (value) {
                gameNumberMap[e] = value.length.toString();
              },
            );
          }
        },
      ).toList(),
    );

    if (event.gameName == 'NFL' || event.gameName == 'NCAAF') {
      yield SportsbookOpened(
        currentTimeZone: currentTimeZone,
        estTimeZone: estTimeZone,
        games: [],
        gameName: event.gameName,
        gameNumbers: gameNumberMap,
      );
    } else {
      final games = await _sportsfeedRepository.fetchGameListByNewGame(
        gameName: event.gameName,
        dateTime: estTimeZone,
      );
      yield SportsbookOpened(
        currentTimeZone: currentTimeZone,
        estTimeZone: estTimeZone,
        games: games,
        gameName: event.gameName,
        gameNumbers: gameNumberMap,
      );
    }
  }

  DateTime fetchESTZone() {
    tz.initializeTimeZones();
    final locationNY = tz.getLocation('America/New_York');

    final nowNY = tz.TZDateTime.now(locationNY);
    return nowNY;
  }

  DateTime fetchESTZoneNew() {
    final result = DateTime.now().toUtc();
    final time = result.add(
      Duration(
        hours: _getESTtoUTCDifference(),
      ),
    );
    return time;
  }

  int _getESTtoUTCDifference() {
    tz.initializeTimeZones();
    final locationNY = tz.getLocation('America/New_York');
    final nowNY = tz.TZDateTime.now(locationNY);
    final _estToUtcDifference = nowNY.timeZoneOffset.inHours;
    return _estToUtcDifference;
  }
}
