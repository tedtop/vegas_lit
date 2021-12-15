import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vegas_lit/features/games/basketball/ncaab/models/ncaab_team.dart';
import '../../../../../config/extensions.dart';

import '../../../../../data/models/ncaab/ncaab_game.dart';
import '../../../../../data/repositories/sport_repository.dart';

part 'ncaab_state.dart';

class NcaabCubit extends Cubit<NcaabState> {
  NcaabCubit({required SportRepository sportsfeedRepository})
      : _sportsfeedRepository = sportsfeedRepository,
        super(
          const NcaabState.initial(),
        );
  final SportRepository _sportsfeedRepository;

  Future<void> fetchNcaabGames() async {
    const league = 'NCAAB';
    final localTimeZone = DateTime.now();
    final estTimeZone = ESTDateTime.fetchTimeEST();

    List<NcaabGame> totalGames;

    final todayGames = await _sportsfeedRepository
        .fetchNCAAB(
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
                element.awayTeamMoneyLine != null ||
                element.overPayout != null ||
                element.homeTeamMoneyLine != null ||
                element.homeTeamMoneyLine != null ||
                element.underPayout != null;
          }).toList(),
        );

    totalGames = todayGames;
    final teamData = await _sportsfeedRepository.fetchNCAABTeams();

    emit(
      NcaabState.opened(
        localTimeZone: localTimeZone,
        estTimeZone: estTimeZone,
        games: totalGames,
        league: league,
        teamData: teamData,
      ),
    );
  }
}
