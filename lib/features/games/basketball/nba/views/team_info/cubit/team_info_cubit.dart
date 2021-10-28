

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../config/extensions.dart';
import '../../../../../../../data/models/nba/nba_player.dart';
import '../../../../../../../data/models/nba/nba_team_stats.dart';
import '../../../../../../../data/repositories/sports_repository.dart';

part 'team_info_state.dart';

class TeamInfoCubit extends Cubit<TeamInfoState> {
  TeamInfoCubit(this.sportsRepository) : super(TeamInfoInitial());
  final SportsRepository sportsRepository;

  void getTeamDetails(String? teamKey, String? gameName) async {
    final players = await sportsRepository.fetchNBAPlayers(
      teamKey: teamKey,
    );
    final teamStats = await sportsRepository.fetchNBATeamStats(
        dateTime: ESTDateTime.fetchTimeEST());
    emit(TeamInfoOpened(
        players.where((element) => element.status == Status.active).toList(),
        teamStats.where((element) => element.team == teamKey).first));
  }
}
