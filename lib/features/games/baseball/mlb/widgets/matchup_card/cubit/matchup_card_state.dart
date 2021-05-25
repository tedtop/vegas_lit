part of 'matchup_card_cubit.dart';

abstract class MatchupCardState {
  const MatchupCardState();
}

class MatchupCardInitial extends MatchupCardState {}

class MatchupCardOpened extends MatchupCardState {
  MatchupCardOpened({
    @required this.game,
    @required this.league,
    @required this.awayTeamData,
    @required this.homeTeamData,
  });

  final Game game;
  final String league;
  final MlbTeam awayTeamData;
  final MlbTeam homeTeamData;
}
