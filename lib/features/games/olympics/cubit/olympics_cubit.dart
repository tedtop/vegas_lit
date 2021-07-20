import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/models/olympics/olympics.dart';
import 'package:vegas_lit/data/repositories/sports_repository.dart';

part 'olympics_state.dart';

class OlympicsCubit extends Cubit<OlympicsState> {
  OlympicsCubit({@required SportsRepository sportsRepository})
      : assert(sportsRepository != null),
        _sportsRepository = sportsRepository,
        super(
          const OlympicsState.initial(),
        );

  final SportsRepository _sportsRepository;
  StreamSubscription _gamesStream;

  Future<void> fetchOlympicsGames() async {
    const league = 'OLYMPICS';
    final estTimeZone = ESTDateTime.fetchTimeEST();

    final todayGamesStream = _sportsRepository.fetchOlympicsGame();
    await _gamesStream?.cancel();
    _gamesStream = todayGamesStream.listen(
      (games) {
        // final todayGames = <OlympicsGame>[];
        // if (games.isNotEmpty) {
        //   todayGames.addAll(games
        //       .where((game) =>
        //           ESTDateTime.fetchTimeEST().isSameDate(game.startTime))
        //       .toList());
        // }
        emit(
          OlympicsState.opened(
            estTimeZone: estTimeZone,
            games: games,
            league: league,
          ),
        );
      },
    );
  }

  Future<void> updateOlympicsGame({@required OlympicsGame game}) async {
    await _sportsRepository.updateOlympicGame(game: game);
  }

  @override
  Future<void> close() async {
    await _gamesStream?.cancel();
    return super.close();
  }
}
