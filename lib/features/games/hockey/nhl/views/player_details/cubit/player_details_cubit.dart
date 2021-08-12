import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/models/nhl/nfl_player_stats.dart';
import 'package:vegas_lit/data/repositories/sports_repository.dart';

part 'player_details_state.dart';

class PlayerDetailsCubit extends Cubit<PlayerDetailsState> {
  PlayerDetailsCubit({this.sportsRepository}) : super(PlayerDetailsInitial());
  final SportsRepository sportsRepository;
  void getPlayerDetails({String playerId}) async {
    final playerStats = await sportsRepository.fetchNHLPlayerStats(
        playerId: playerId, dateTime: ESTDateTime.fetchTimeEST());
    emit(PlayerDetailsOpened(playerStats));
  }
}
