import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../config/extensions.dart';
import '../../../../../../../data/models/ncaab/ncaab_player_stats.dart';
import '../../../../../../../data/repositories/sports_repository.dart';

part 'player_details_state.dart';

class PlayerDetailsCubit extends Cubit<PlayerDetailsState> {
  PlayerDetailsCubit({this.sportsRepository}) : super(PlayerDetailsInitial());
  final SportsRepository sportsRepository;
  void getPlayerDetails({String playerId}) async {
    final playerStats = await sportsRepository.fetchNCAABPlayerStats(
        playerId: playerId, dateTime: ESTDateTime.fetchTimeEST());
    emit(PlayerDetailsOpened(playerStats));
  }
}
