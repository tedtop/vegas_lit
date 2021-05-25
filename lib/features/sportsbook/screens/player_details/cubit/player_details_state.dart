part of 'player_details_cubit.dart';

abstract class PlayerDetailsState extends Equatable {
  const PlayerDetailsState();

  @override
  List<Object> get props => [];
}

class PlayerDetailsInitial extends PlayerDetailsState {}

class PlayerDetailsFetched extends PlayerDetailsState {
  PlayerDetailsFetched(this.playerDetails);
  final PlayerDetails playerDetails;
}
