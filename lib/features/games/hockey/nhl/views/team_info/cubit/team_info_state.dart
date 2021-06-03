part of 'team_info_cubit.dart';

abstract class TeamInfoState extends Equatable {
  const TeamInfoState();

  @override
  List<Object> get props => [];
}

class TeamInfoInitial extends TeamInfoState {}

class TeamInfoOpened extends TeamInfoState {
  TeamInfoOpened(this.player);
  final List<NhlPlayer> player;
}
