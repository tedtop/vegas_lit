import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/data/repositories/sportsfeed_repository.dart';

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

    final gameNumberMap = <String, int>{};

    await Future.wait(
      list
          .map(
            (e) async => await _sportsfeedRepository
                .fetchGameListByGame(
              gameName: e,
            )
                .then(
              (value) {
                gameNumberMap[e] = value.length;
              },
            ),
          )
          .toList(),
    );

    final games = await _sportsfeedRepository.fetchGameListByGame(
      gameName: event.gameName,
    );

    yield SportsbookOpened(
      games: games,
      gameName: event.gameName,
      gameNumbers: gameNumberMap,
    );
  }
}
