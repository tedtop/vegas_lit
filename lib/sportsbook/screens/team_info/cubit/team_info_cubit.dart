import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:api_client/src/models/player.dart';

part 'team_info_state.dart';

class TeamInfoCubit extends Cubit<TeamInfoState> {
  TeamInfoCubit() : super(TeamInfoInitial());
  final _sportsRepository = SportsRepository();

  void listTeamPlayers(String teamKey) async {
    final players = await _sportsRepository.fetchPlayers(teamKey: teamKey);

    emit(TeamInfoOpened(
        players.where((element) => element.status == 'Active').toList()));
  }
}
