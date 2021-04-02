import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:api_client/api_client.dart';

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

    if (event.gameName == 'NFL' || event.gameName == 'NCAAF') {
      yield SportsbookOpened(
        games: [],
        gameName: event.gameName,
        gameNumbers: gameNumberMap,
      );
    } else {
      final games = await _sportsfeedRepository.fetchGameListByNewGame(
        gameName: event.gameName,
      );
      yield SportsbookOpened(
        games: games,
        gameName: event.gameName,
        gameNumbers: gameNumberMap,
      );
    }
  }
}
