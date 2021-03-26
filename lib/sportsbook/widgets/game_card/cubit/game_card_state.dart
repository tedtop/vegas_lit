part of 'game_card_cubit.dart';

abstract class GameCardState {
  const GameCardState();
}

class GameCardInitial extends GameCardState {}

class GameCardOpened extends GameCardState {
  GameCardOpened({
    @required this.game,
  });

  final Game game;
}
