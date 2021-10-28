part of 'cricket_matchup_card_cubit.dart';

abstract class CricketMatchupCardState {
  const CricketMatchupCardState();
}

class CricketMatchupCardInitial extends CricketMatchupCardState {}

class CricketMatchupCardOpened extends CricketMatchupCardState {
  CricketMatchupCardOpened({
    required this.game,
    required this.league,
    required this.awayTeamData,
    required this.homeTeamData,
  });

  final CricketDatum game;
  final String league;
  final CricketTeam awayTeamData;
  final CricketTeam homeTeamData;
}
