import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:vegas_lit/data/models/paralympics/paralympics.dart';

import '../../../../config/extensions.dart';
import '../../../../data/repositories/sports_repository.dart';

part 'paralympics_state.dart';

class ParalympicsCubit extends Cubit<ParalympicsState> {
  ParalympicsCubit({required SportsRepository sportsRepository})
      : assert(sportsRepository != null),
        _sportsRepository = sportsRepository,
        super(
          const ParalympicsState.initial(),
        );

  final SportsRepository _sportsRepository;
  StreamSubscription? _gamesStream;

  Future<void> fetchParalympicsGames() async {
    const league = 'PARALYMPICS';
    final estTimeZone = ESTDateTime.fetchTimeEST();
    final todayGamesStream = _sportsRepository.fetchParalympicsGame();
    await _gamesStream?.cancel();
    _gamesStream = todayGamesStream.listen(
      (games) {
        var todayGames = <ParalympicsGame>[];
        if (games.isNotEmpty) {
          todayGames = games
              .where(
                (game) =>
                    game.startTime!.isAfter(ESTDateTime.fetchTimeEST()) &&
                    (ESTDateTime.fetchTimeEST().isSameDate(game.startTime!) ||
                        ESTDateTime.fetchTimeEST()
                            .add(const Duration(days: 1))
                            .isSameDate(game.startTime!)),
              )
              .toList();
        }
        emit(
          ParalympicsState.opened(
            estTimeZone: estTimeZone,
            games: kDebugMode ? games : todayGames,
            league: league,
          ),
        );
      },
    );
  }

  Future<void> updateParalympicsGame({required ParalympicsGame game}) async {
    await _sportsRepository.updateParalympicsGame(game: game);
  }

  @override
  Future<void> close() async {
    await _gamesStream?.cancel();
    return super.close();
  }
}
