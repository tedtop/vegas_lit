import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:api_client/api_client.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
    } else if (event is GolfTournamentsOpen) {
      yield* _mapGolfTournamentsOpenToState(event);
    } else if (event is GolfDetailOpen) {
      yield* _mapGolfDetailOpenToState(event);
    } else if (event is GolfPlayerOpen) {
      yield* _mapGolfPlayerOpenToState(event);
    }
    if (event is SportsbookLeagueChange) {
      yield* _mapSportsbookLeagueChangeToState(event);
    }
  }

  Stream<SportsbookState> _mapSportsbookOpenToState(
      SportsbookOpen event) async* {
    yield const SportsbookState.initial();
    final list = <String>['NFL', 'NBA', 'MLB', 'NHL', 'NCAAF', 'NCAAB', 'GOLF'];

    final gameNumberMap = <String, String>{};
    // final localTimeZone = DateTime.now();
    final estTimeZone = fetchTimeEST();
    // final tomorrowEstTimeZone =
    //     DateTime(estTimeZone.year, estTimeZone.month, estTimeZone.day + 1);

    await Future.wait(
      list.map(
        (e) async {
          if (e == 'NFL' || e == 'NCAAF' || e == 'GOLF') {
            gameNumberMap[e] = 'OFF-SEASON';
          } else {
            final todayGamesLength =
                await mapGameLength(dateTime: estTimeZone, league: e);

            // if (greeting(dateTime: estTimeZone) == 'evening') {
            //   final tomorrowGamesLength = await mapGameLength(
            //     dateTime: tomorrowEstTimeZone,
            //     league: e,
            //   );
            //   gameNumberMap[e] =
            //       (todayGamesLength + tomorrowGamesLength).toString();
            // } else {
            gameNumberMap[e] = todayGamesLength.toString();
            // }
          }
        },
      ).toList(),
    );

    switch (event.league) {
      case 'NFL':
        yield* _mapGameNFL(gameNumberMap: gameNumberMap);
        break;
      case 'NBA':
        yield* _mapGameNBA(gameNumberMap: gameNumberMap);
        break;
      case 'MLB':
        yield* _mapGameMLB(gameNumberMap: gameNumberMap);
        break;
      case 'NHL':
        yield* _mapGameNHL(gameNumberMap: gameNumberMap);
        break;
      case 'NCAAF':
        yield* _mapGameNCAAF(gameNumberMap: gameNumberMap);
        break;
      case 'NCAAB':
        yield* _mapGameNCAAB(gameNumberMap: gameNumberMap);
        break;
      default:
    }
  }

  Stream<SportsbookState> _mapSportsbookLeagueChangeToState(
      SportsbookLeagueChange event) async* {
    yield SportsbookState.loading(
      league: state.league,
      gameNumbers: state.gameNumbers,
      estTimeZone: state.estTimeZone,
      localTimeZone: state.localTimeZone,
    );

    switch (event.league) {
      case 'NFL':
        yield* _mapGameNFL(gameNumberMap: state.gameNumbers);
        break;
      case 'NBA':
        yield* _mapGameNBA(gameNumberMap: state.gameNumbers);
        break;
      case 'MLB':
        yield* _mapGameMLB(gameNumberMap: state.gameNumbers);
        break;
      case 'NHL':
        yield* _mapGameNHL(gameNumberMap: state.gameNumbers);
        break;
      case 'NCAAF':
        yield* _mapGameNCAAF(gameNumberMap: state.gameNumbers);
        break;
      case 'NCAAB':
        yield* _mapGameNCAAB(gameNumberMap: state.gameNumbers);
        break;
      default:
    }
  }

  DateTime fetchTimeEST() {
    tz.initializeTimeZones();
    final locationNY = tz.getLocation('America/New_York');
    final nowNY = tz.TZDateTime.now(locationNY);
    return nowNY;
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
      default:
        break;
    }
  }

  dynamic getParsedTeamData({@required String league}) async {
    final newLeague = whichGame(league: league);
    final jsonData = await rootBundle.loadString('assets/json/$newLeague.json');
    final parsedTeamData = await json.decode(jsonData);
    return parsedTeamData;
  }

  Stream<SportsbookState> _mapGolfTournamentsOpenToState(
      GolfTournamentsOpen event) async* {
    yield SportsbookState.loading(
      league: state.league,
      gameNumbers: state.gameNumbers,
      estTimeZone: state.estTimeZone,
      localTimeZone: state.localTimeZone,
    );

    final estTimeZone = fetchTimeEST();
    final localTimeZone = DateTime.now();

    List<GolfTournament> tournaments;
    tournaments = await _sportsfeedRepository.fetchGolfTournaments(
        dateTimeEastern: estTimeZone);
    yield SportsbookState.golfTournamentOpened(
      tournaments: tournaments,
      league: 'GOLF',
      gameNumbers: state.gameNumbers,
      estTimeZone: estTimeZone,
      localTimeZone: localTimeZone,
    );
  }

  Stream<SportsbookState> _mapGolfDetailOpenToState(
      GolfDetailOpen event) async* {
    yield SportsbookState.loading(
      league: state.league,
      gameNumbers: state.gameNumbers,
      estTimeZone: state.estTimeZone,
      localTimeZone: state.localTimeZone,
    );

    final estTimeZone = fetchTimeEST();
    final localTimeZone = DateTime.now();
    GolfLeaderboard leaderboard;
    leaderboard = await _sportsfeedRepository.fetchGolfLeaderboard(
        tournamentID: event.tournamentID);
    yield SportsbookState.golfDetailOpened(
      tournament: leaderboard.tournament,
      players: leaderboard.players,
      league: 'GOLF',
      gameNumbers: state.gameNumbers,
      estTimeZone: estTimeZone,
      localTimeZone: localTimeZone,
    );
  }

  Stream<SportsbookState> _mapGolfPlayerOpenToState(
      GolfPlayerOpen event) async* {
    yield SportsbookState.loading(
      league: state.league,
      gameNumbers: state.gameNumbers,
      estTimeZone: state.estTimeZone,
      localTimeZone: state.localTimeZone,
    );

    final estTimeZone = fetchTimeEST();
    final localTimeZone = DateTime.now();
    yield SportsbookState.golfPlayerOpened(
      player: event.player,
      tournamentID: event.tournament.tournamentId,
      name: event.tournament.name,
      venue: event.tournament.venue,
      location: event.tournament.location,
      league: 'GOLF',
      gameNumbers: state.gameNumbers,
      estTimeZone: estTimeZone,
      localTimeZone: localTimeZone,
    );
  }

  Future<int> mapGameLength(
      {@required DateTime dateTime, @required String league}) async {
    switch (league) {
      case 'NFL':
        return await _sportsfeedRepository
            .fetchNFL(
          dateTime: dateTime,
        )
            .then(
          (value) {
            return value
                .where((element) => element.status == 'Scheduled')
                .where((element) =>
                    element.dateTime.toUtc().isAfter(fetchTimeEST().toUtc()))
                .where((element) => element.isClosed == false)
                .length;
          },
        );
        break;
      case 'NBA':
        return await _sportsfeedRepository
            .fetchNBA(
          dateTime: dateTime,
        )
            .then(
          (value) {
            return value
                .where((element) => element.status == 'Scheduled')
                .where((element) =>
                    element.dateTime.toUtc().isAfter(fetchTimeEST().toUtc()))
                .where((element) => element.isClosed == false)
                .length;
          },
        );
        break;
      case 'MLB':
        return await _sportsfeedRepository
            .fetchMLB(
          dateTime: dateTime,
        )
            .then(
          (value) {
            return value
                .where((element) => element.status == 'Scheduled')
                .where((element) =>
                    element.dateTime.toUtc().isAfter(fetchTimeEST().toUtc()))
                .where((element) => element.isClosed == false)
                .length;
          },
        );
        break;
      case 'NHL':
        return await _sportsfeedRepository
            .fetchNHL(
          dateTime: dateTime,
        )
            .then(
          (value) {
            return value
                .where((element) => element.status == 'Scheduled')
                .where((element) =>
                    element.dateTime.toUtc().isAfter(fetchTimeEST().toUtc()))
                .where((element) => element.isClosed == false)
                .length;
          },
        );
        break;
      case 'NCAAF':
        return await _sportsfeedRepository
            .fetchNCAAF(
          dateTime: dateTime,
        )
            .then(
          (value) {
            return value
                .where((element) => element.status == 'Scheduled')
                .where((element) =>
                    element.dateTime.toUtc().isAfter(fetchTimeEST().toUtc()))
                .where((element) => element.isClosed == false)
                .length;
          },
        );
        break;
      case 'NCAAB':
        return await _sportsfeedRepository
            .fetchNCAAB(
          dateTime: dateTime,
        )
            .then(
          (value) {
            return value
                .where((element) => element.status == 'Scheduled')
                .where((element) =>
                    element.dateTime.toUtc().isAfter(fetchTimeEST().toUtc()))
                .where((element) => element.isClosed == false)
                .length;
          },
        );
        break;
      default:
        return 0;
        break;
    }
  }

  // MLB Game
  Stream<SportsbookState> _mapGameMLB({
    @required Map<String, String> gameNumberMap,
  }) async* {
    const league = 'MLB';
    final localTimeZone = DateTime.now();
    final estTimeZone = fetchTimeEST();
    // final tomorrowEstTimeZone =
    //     DateTime(estTimeZone.year, estTimeZone.month, estTimeZone.day + 1);
    List<Game> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchMLB(
          dateTime: estTimeZone,
        )
        .then(
          (value) => value
              .where((element) => element.status == 'Scheduled')
              .where((element) =>
                  element.dateTime.toUtc().isAfter(fetchTimeEST().toUtc()))
              .where((element) => element.isClosed == false)
              .toList(),
        );

    // if (greeting(dateTime: estTimeZone) == 'evening') {
    //   final tomorrowGames = await _sportsfeedRepository
    //       .fetchMLB(
    //         dateTime: tomorrowEstTimeZone,
    //       )
    //       .then(
    //         (value) => value
    //             .where((element) => element.status == 'Scheduled')
    //            .where((element) => element.dateTime.isAfter(fetchTimeEST()))
    //             .where((element) => element.isClosed == false)
    //             .toList(),
    //       );

    //   totalGames = todayGames + tomorrowGames;
    // } else {
    totalGames = todayGames;
    // }

    yield SportsbookState.opened(
      localTimeZone: localTimeZone,
      estTimeZone: estTimeZone,
      games: totalGames,
      league: league,
      parsedTeamData: await getParsedTeamData(league: league),
      gameNumbers: gameNumberMap,
    );
  }

  // NFL Game
  Stream<SportsbookState> _mapGameNFL({
    @required Map<String, String> gameNumberMap,
  }) async* {
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
    //            .where((element) =>element.dateTime.toUtc().isAfter(fetchTimeEST().toUtc()))
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
    //            .where((element) => element.dateTime.isAfter(fetchTimeEST()))
    //             .where((element) => element.isClosed == false)
    //             .toList(),
    //       );

    //   totalGames = todayGames + tomorrowGames;
    // } else {
    //   totalGames = todayGames;
    // }

    yield SportsbookState.opened(
      localTimeZone: localTimeZone,
      estTimeZone: estTimeZone,
      games: [],
      league: league,
      parsedTeamData: await getParsedTeamData(league: 'MLB'),
      gameNumbers: gameNumberMap,
    );
  }

  // NBA Game
  Stream<SportsbookState> _mapGameNBA({
    @required Map<String, String> gameNumberMap,
  }) async* {
    const league = 'NBA';
    final localTimeZone = DateTime.now();
    final estTimeZone = fetchTimeEST();
    // final tomorrowEstTimeZone =
    //     DateTime(estTimeZone.year, estTimeZone.month, estTimeZone.day + 1);
    List<Game> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchNBA(
          dateTime: estTimeZone,
        )
        .then(
          (value) => value
              .where((element) => element.status == 'Scheduled')
              .where((element) =>
                  element.dateTime.toUtc().isAfter(fetchTimeEST().toUtc()))
              .where((element) => element.isClosed == false)
              .toList(),
        );

    // if (greeting(dateTime: estTimeZone) == 'evening') {
    //   final tomorrowGames = await _sportsfeedRepository
    //       .fetchNBA(
    //         dateTime: tomorrowEstTimeZone,
    //       )
    //       .then(
    //         (value) => value
    //             .where((element) => element.status == 'Scheduled')
    //            .where((element) => element.dateTime.isAfter(fetchTimeEST()))
    //             .where((element) => element.isClosed == false)
    //             .toList(),
    //       );

    //   totalGames = todayGames + tomorrowGames;
    // } else {
    totalGames = todayGames;
    // }

    yield SportsbookState.opened(
      localTimeZone: localTimeZone,
      estTimeZone: estTimeZone,
      games: totalGames,
      league: league,
      parsedTeamData: await getParsedTeamData(league: league),
      gameNumbers: gameNumberMap,
    );
  }

  // NHL Game
  Stream<SportsbookState> _mapGameNHL({
    @required Map<String, String> gameNumberMap,
  }) async* {
    const league = 'NHL';
    final localTimeZone = DateTime.now();
    final estTimeZone = fetchTimeEST();
    // final tomorrowEstTimeZone =
    //     DateTime(estTimeZone.year, estTimeZone.month, estTimeZone.day + 1);
    List<Game> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchNHL(
          dateTime: estTimeZone,
        )
        .then(
          (value) => value
              .where((element) => element.status == 'Scheduled')
              .where((element) =>
                  element.dateTime.toUtc().isAfter(fetchTimeEST().toUtc()))
              .where((element) => element.isClosed == false)
              .toList(),
        );

    // if (greeting(dateTime: estTimeZone) == 'evening') {
    //   final tomorrowGames = await _sportsfeedRepository
    //       .fetchNHL(
    //         dateTime: tomorrowEstTimeZone,
    //       )
    //       .then(
    //         (value) => value
    //             .where((element) => element.status == 'Scheduled')
    //            .where((element) => element.dateTime.isAfter(fetchTimeEST()))
    //             .where((element) => element.isClosed == false)
    //             .toList(),
    //       );

    //   totalGames = todayGames + tomorrowGames;
    // } else {
    totalGames = todayGames;
    // }

    yield SportsbookState.opened(
      localTimeZone: localTimeZone,
      estTimeZone: estTimeZone,
      games: totalGames,
      league: league,
      parsedTeamData: await getParsedTeamData(league: league),
      gameNumbers: gameNumberMap,
    );
  }

  // NCAAF Game
  Stream<SportsbookState> _mapGameNCAAF({
    @required Map<String, String> gameNumberMap,
  }) async* {
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
    //           .where((element) => element.dateTime.toUtc().isAfter(fetchTimeEST().toUtc()))
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
    //            .where((element) => element.dateTime.isAfter(fetchTimeEST()))
    //             .where((element) => element.isClosed == false)
    //             .toList(),
    //       );

    //   totalGames = todayGames + tomorrowGames;
    // } else {
    //   totalGames = todayGames;
    // }

    yield SportsbookState.opened(
      localTimeZone: localTimeZone,
      estTimeZone: estTimeZone,
      games: [],
      league: league,
      parsedTeamData: await getParsedTeamData(league: 'MLB'),
      gameNumbers: gameNumberMap,
    );
  }

  // NCAAB Game
  Stream<SportsbookState> _mapGameNCAAB({
    @required Map<String, String> gameNumberMap,
  }) async* {
    const league = 'NCAAB';
    final localTimeZone = DateTime.now();
    final estTimeZone = fetchTimeEST();
    // final tomorrowEstTimeZone =
    //     DateTime(estTimeZone.year, estTimeZone.month, estTimeZone.day + 1);
    List<Game> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchNCAAB(
          dateTime: estTimeZone,
        )
        .then(
          (value) => value
              .where((element) => element.status == 'Scheduled')
              .where((element) =>
                  element.dateTime.toUtc().isAfter(fetchTimeEST().toUtc()))
              .where((element) => element.isClosed == false)
              .toList(),
        );

    // if (greeting(dateTime: estTimeZone) == 'evening') {
    //   final tomorrowGames = await _sportsfeedRepository
    //       .fetchNCAAB(
    //         dateTime: tomorrowEstTimeZone,
    //       )
    //       .then(
    //         (value) => value
    //             .where((element) => element.status == 'Scheduled')
    //            .where((element) => element.dateTime.isAfter(fetchTimeEST()))
    //             .where((element) => element.isClosed == false)
    //             .toList(),
    //       );

    //   totalGames = todayGames + tomorrowGames;
    // } else {
    totalGames = todayGames;
    // }

    yield SportsbookState.opened(
      localTimeZone: localTimeZone,
      estTimeZone: estTimeZone,
      games: totalGames,
      league: league,
      parsedTeamData: await getParsedTeamData(league: league),
      gameNumbers: gameNumberMap,
    );
  }

  // Additional Functions

  // String greeting({@required DateTime dateTime}) {
  //   final hour = dateTime.hour;
  //   if (hour < 12) {
  //     return 'morning';
  //   }
  //   if (hour < 17) {
  //     return 'afternoon';
  //   }
  //   return 'evening';
  // }
}
