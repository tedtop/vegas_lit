part of 'matchup_card_cubit.dart';

abstract class NcaafMatchupCardState {
  const NcaafMatchupCardState();
}

class MatchupCardInitial extends NcaafMatchupCardState {}

class MatchupCardOpened extends NcaafMatchupCardState {
  MatchupCardOpened({
    @required this.game,
    @required this.league,
    @required this.awayTeamData,
    @required this.homeTeamData,
  });

  final Game game;
  final String league;
  final NcaafTeam awayTeamData;
  final NcaafTeam homeTeamData;
}
