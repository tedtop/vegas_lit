import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../../config/extensions.dart';
import '../../../../../../../data/models/mlb/mlb_player.dart';
import '../../../../../../../data/models/mlb/mlb_team_stats.dart';
import '../../../../../../../data/repositories/sport_repository.dart';

part 'team_info_state.dart';

class TeamInfoCubit extends Cubit<TeamInfoState> {
  TeamInfoCubit(this.sportsRepository) : super(TeamInfoInitial());
  final SportRepository sportsRepository;

  Future<void> getTeamDetails(String? teamKey, String? gameName) async {
    final players = await sportsRepository.fetchMLBPlayers(
      teamKey: teamKey,
    );
    final teamStats = await sportsRepository.fetchMLBTeamStats(
        dateTime: ESTDateTime.fetchTimeEST());
    emit(TeamInfoOpened(
        players.where((element) => element.status == 'Active').toList(),
        teamStats.where((element) => element.team == teamKey).first));
  }
}
