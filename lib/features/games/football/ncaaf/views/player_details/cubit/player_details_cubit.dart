import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegas_lit/data/models/player_details.dart';
import 'package:vegas_lit/data/repositories/sports_repository.dart';

part 'player_details_state.dart';

class PlayerDetailsCubit extends Cubit<PlayerDetailsState> {
  PlayerDetailsCubit({@required this.sportsRepository, @required this.gameName})
      : super(PlayerDetailsInitial());
  final SportsRepository sportsRepository;
  final String gameName;

  void fetchPlayerDetails({String playerID}) async {
    final playerDetails = await sportsRepository.fetchPlayerDetails(
        playerId: playerID, gameName: gameName);
    emit(PlayerDetailsFetched(playerDetails));
  }
}
