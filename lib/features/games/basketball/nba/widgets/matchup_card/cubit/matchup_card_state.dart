part of 'matchup_card_cubit.dart';

abstract class NbaMatchupCardState {
  const NbaMatchupCardState();
}

class MatchupCardInitial extends NbaMatchupCardState {}

class MatchupCardOpened extends NbaMatchupCardState {
  MatchupCardOpened({
    @required this.game,
    @required this.league,
    @required this.awayTeamData,
    @required this.homeTeamData,
  });

  final NbaGame game;
  final String league;
  final NbaTeam awayTeamData;
  final NbaTeam homeTeamData;
}
