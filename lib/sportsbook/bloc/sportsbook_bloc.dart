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

    await Future.wait(
      list.map(
        (e) async {
          if (e == 'NFL' || e == 'NCAAF') {
            gameNumberMap[e] = 'OFF-SEASON';
          } else {
            await _sportsfeedRepository
                .fetchGameListByNewGame(
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

    // DateTime locationLocal = DateTime.now()

    // final estTimeZone = convertToLocal();
    // final currentTime = DateTime.now();
    // final estTimeZone = DateTimeExtension(currentTime).toESTzone();

    // final estTimeZone = fetchESTZone();
    // print('Cool: $estTimeZone');
    final estTimeZone = fetchESTZoneNew();

    if (event.gameName == 'NFL' || event.gameName == 'NCAAF') {
      yield SportsbookOpened(
        timeZone: estTimeZone,
        games: [],
        gameName: event.gameName,
        gameNumbers: gameNumberMap,
      );
    } else {
      final games = await _sportsfeedRepository.fetchGameListByNewGame(
        gameName: event.gameName,
      );
      yield SportsbookOpened(
        timeZone: estTimeZone,
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

  // TZDateTime convertToLocal(TZDateTime tzDateTime, String locationLocal) {
  //   TZDateTime nowLocal = new TZDateTime.now(getLocation(locationLocal));
  //   int difference = nowLocal.timeZoneOffset.inHours;
  //   TZDateTime newTzDateTime;
  //   newTzDateTime = tzDateTime.add(Duration(hours: difference));
  //   return newTzDateTime;
  // }
}

// extension DateTimeExtension on DateTime {
//   static int _estToUtcDifference;

//   int _getESTtoUTCDifference() {
//     if (_estToUtcDifference == null) {
//       tz.initializeTimeZones();
//       final locationNY = tz.getLocation('America/New_York');
//       tz.TZDateTime nowNY = tz.TZDateTime.now(locationNY);
//       _estToUtcDifference = nowNY.timeZoneOffset.inHours;
//     }

//     return _estToUtcDifference;
//   }

//   DateTime toESTzone() {
//     var result = toUtc(); // local time to UTC
//     result = result
//         .add(Duration(hours: _getESTtoUTCDifference())); // convert UTC to EST
//     return result;
//   }

//   // DateTime fromESTzone() {
//   //   DateTime result = this.subtract(Duration(hours: _getESTtoUTCDifference())); // convert EST to UTC

//   //   String dateTimeAsIso8601String = result.toIso8601String();
//   //   dateTimeAsIso8601String += dateTimeAsIso8601String.characters.last.equalsIgnoreCase('Z') ? '' : 'Z';
//   //   result = DateTime.parse(dateTimeAsIso8601String); // make isUtc to be true

//   //   result = result.toLocal(); // convert UTC to local time
//   //   return result;
//   // }
// }
