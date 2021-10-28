

part of 'matchup_card_cubit.dart';

abstract class NflMatchupCardState {
  const NflMatchupCardState();
}

class MatchupCardInitial extends NflMatchupCardState {}

class MatchupCardOpened extends NflMatchupCardState {
  MatchupCardOpened({
    required this.game,
    required this.league,
    required this.awayTeamData,
    required this.homeTeamData,
  });

  final NflGame game;
  final String? league;
  final NflTeam awayTeamData;
  final NflTeam homeTeamData;
}
