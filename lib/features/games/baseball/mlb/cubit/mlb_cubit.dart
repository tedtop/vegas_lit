import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../config/extensions.dart';
import '../../../../../data/models/mlb/mlb_game.dart';
import '../../../../../data/repositories/sport_repository.dart';
import '../models/mlb_team.dart';

part 'mlb_state.dart';

class MlbCubit extends Cubit<MlbState> {
  MlbCubit({required SportRepository sportsfeedRepository})
      : _sportsfeedRepository = sportsfeedRepository,
        super(
          const MlbState.initial(),
        );

  final SportRepository _sportsfeedRepository;

  Future<void> fetchMlbGames() async {
    const league = 'MLB';
    final estTimeZone = ESTDateTime.fetchTimeEST();
    List<MlbGame> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchMLB(
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

    final teamData = await _sportsfeedRepository.fetchMLBTeams();

    emit(
      MlbState.opened(
        estTimeZone: estTimeZone,
        games: totalGames,
        league: league,
        teamData: teamData,
      ),
    );
  }
}
