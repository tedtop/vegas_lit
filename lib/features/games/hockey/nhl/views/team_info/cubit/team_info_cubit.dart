import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/models/nhl/nhl_player.dart';
import 'package:vegas_lit/data/models/nhl/nhl_team_stats.dart';
import '../../../../../../../data/repositories/sports_repository.dart';

part 'team_info_state.dart';

class TeamInfoCubit extends Cubit<TeamInfoState> {
  TeamInfoCubit(this.sportsRepository) : super(TeamInfoInitial());
  final SportsRepository sportsRepository;

  void getTeamDetails(String teamKey, String gameName) async {
    final players = await sportsRepository.fetchNHLPlayers(
      teamKey: teamKey,
    );
    final teamStats = await sportsRepository.fetchNHLTeamStats(
        dateTime: ESTDateTime.fetchTimeEST());
    emit(TeamInfoOpened(
        players.where((element) => element.status == 'Active').toList(),
        teamStats.where((element) => element.team == teamKey).first));
  }
}
