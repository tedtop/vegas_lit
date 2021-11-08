import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../config/extensions.dart';
import '../../../../../../../data/models/nfl/nfl_player_stats.dart';
import '../../../../../../../data/repositories/sport_repository.dart';

part 'player_details_state.dart';

class PlayerDetailsCubit extends Cubit<PlayerDetailsState> {
  PlayerDetailsCubit({this.sportsRepository}) : super(PlayerDetailsInitial());
  final SportRepository? sportsRepository;
  void getPlayerDetails({String? playerId}) async {
    final playerStats = await sportsRepository!.fetchNFLPlayerStats(
        playerId: playerId, dateTime: ESTDateTime.fetchTimeEST());
    emit(PlayerDetailsOpened(playerStats));
  }
}
