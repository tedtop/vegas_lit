import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:api_client/src/models/player.dart';

part 'team_info_state.dart';

class TeamInfoCubit extends Cubit<TeamInfoState> {
  TeamInfoCubit(this.sportsRepository) : super(TeamInfoInitial());
  final SportsRepository sportsRepository;

  void listTeamPlayers(String teamKey, String gameName) async {
    final players = await sportsRepository.fetchPlayers(
        teamKey: teamKey, gameName: gameName);

    emit(TeamInfoOpened(
        players.where((element) => element.status == 'Active').toList()));
  }
}
