part of 'matchup_card_cubit.dart';

abstract class NcaabMatchupCardState {
  const NcaabMatchupCardState();
}

class MatchupCardInitial extends NcaabMatchupCardState {}

class MatchupCardOpened extends NcaabMatchupCardState {
  MatchupCardOpened({
    @required this.game,
    @required this.league,
    @required this.awayTeamData,
    @required this.homeTeamData,
  });

  final NcaabGame game;
  final String league;
  final NcaabTeam awayTeamData;
  final NcaabTeam homeTeamData;
}
