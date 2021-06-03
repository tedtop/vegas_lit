part of 'matchup_card_cubit.dart';

abstract class NhlMatchupCardState {
  const NhlMatchupCardState();
}

class MatchupCardInitial extends NhlMatchupCardState {}

class MatchupCardOpened extends NhlMatchupCardState {
  MatchupCardOpened({
    @required this.game,
    @required this.league,
    @required this.awayTeamData,
    @required this.homeTeamData,
  });

  final NhlGame game;
  final String league;
  final NhlTeam awayTeamData;
  final NhlTeam homeTeamData;
}
