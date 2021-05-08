import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:api_client/src/models/player_details.dart';

part 'player_details_state.dart';

class PlayerDetailsCubit extends Cubit<PlayerDetailsState> {
  PlayerDetailsCubit({@required this.sportsRepository})
      : super(PlayerDetailsInitial());
  final SportsRepository sportsRepository;

  void fetchPlayerDetails({String playerID}) async {
    final playerDetails =
        await sportsRepository.fetchPlayerDetails(playerId: playerID);
    emit(PlayerDetailsFetched(playerDetails));
  }
}
