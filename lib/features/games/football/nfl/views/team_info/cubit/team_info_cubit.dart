import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/models/nfl/nfl_player.dart';
import 'package:vegas_lit/data/models/nfl/nfl_team_stats.dart';
import '../../../../../../../data/repositories/sports_repository.dart';

part 'team_info_state.dart';

class TeamInfoCubit extends Cubit<TeamInfoState> {
  TeamInfoCubit(this.sportsRepository) : super(TeamInfoInitial());
  final SportsRepository sportsRepository;

  void getTeamDetails(String teamKey, String gameName) async {
    final players = await sportsRepository.fetchNFLPlayers(
      teamKey: teamKey,
    );
    final teamStats = await sportsRepository.fetchNFLTeamStats(
        dateTime: ESTDateTime.fetchTimeEST());
    emit(TeamInfoOpened(
        players
            .where((element) => element.status == StatusEnum.ACTIVE)
            .toList(),
        teamStats.where((element) => element.team == teamKey).first));
  }
}
