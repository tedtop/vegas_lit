import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vegas_lit/data/models/nba/nba_player.dart';
import 'package:vegas_lit/data/repositories/sports_repository.dart';

part 'team_info_state.dart';

class TeamInfoCubit extends Cubit<TeamInfoState> {
  TeamInfoCubit(this.sportsRepository) : super(TeamInfoInitial());
  final SportsRepository sportsRepository;

  void listTeamPlayers(String teamKey, String gameName) async {
    final players = await sportsRepository.fetchNBAPlayers(
      teamKey: teamKey,
    );

    emit(TeamInfoOpened(
        players.where((element) => element.status == 'Active').toList()));
  }
}
