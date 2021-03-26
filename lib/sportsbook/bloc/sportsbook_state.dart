part of 'sportsbook_bloc.dart';

abstract class SportsbookState {
  const SportsbookState();
}

class SportsbookInitial extends SportsbookState {}

class SportsbookOpened extends SportsbookState {
  SportsbookOpened({
    @required this.games,
    @required this.gameName,
    @required this.gameNumbers,
  });

  final List<Game> games;
  final String gameName;
  final Map<String, int> gameNumbers;
}
