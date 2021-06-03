part of 'matchup_card_cubit.dart';

abstract class MlbMatchupCardState {
  const MlbMatchupCardState();
}

class MatchupCardInitial extends MlbMatchupCardState {}

class MatchupCardOpened extends MlbMatchupCardState {
  MatchupCardOpened({
    @required this.game,
    @required this.league,
    @required this.awayTeamData,
    @required this.homeTeamData,
  });

  final MlbGame game;
  final String league;
  final MlbTeam awayTeamData;
  final MlbTeam homeTeamData;
}
