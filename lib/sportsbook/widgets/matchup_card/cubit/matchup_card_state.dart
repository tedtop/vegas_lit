part of 'matchup_card_cubit.dart';

abstract class MatchupCardState {
  const MatchupCardState();
}

class MatchupCardInitial extends MatchupCardState {}

class MatchupCardOpened extends MatchupCardState {
  MatchupCardOpened({
    @required this.game,
  });

  final Game game;
}
