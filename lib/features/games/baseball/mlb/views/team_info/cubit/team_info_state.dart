part of 'team_info_cubit.dart';

abstract class TeamInfoState extends Equatable {
  const TeamInfoState();

  @override
  List<Object> get props => [];
}

class TeamInfoInitial extends TeamInfoState {}

class TeamInfoOpened extends TeamInfoState {
  TeamInfoOpened(this.players, this.teamStats);
  final List<MlbPlayer> players;
  final MlbTeamStats teamStats;
}
