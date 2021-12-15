import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../config/extensions.dart';
import '../../../../../../../data/models/ncaaf/ncaaf_player.dart';
import '../../../../../../../data/models/ncaaf/ncaaf_team_stats.dart';
import '../../../../../../../data/repositories/sport_repository.dart';

part 'team_info_state.dart';

class TeamInfoCubit extends Cubit<TeamInfoState> {
  TeamInfoCubit(this.sportsRepository) : super(TeamInfoInitial());
  final SportRepository sportsRepository;

  Future<void> getTeamDetails(String? teamKey, String? gameName) async {
    final players = await sportsRepository.fetchNCAAFPlayers(
      teamKey: teamKey,
    );
    final teamStats = await sportsRepository.fetchNCAAFTeamStats(
        dateTime: ESTDateTime.fetchTimeEST());
    emit(
      TeamInfoOpened(
          players, teamStats.where((element) => element.team == teamKey).first),
    );
  }
}
