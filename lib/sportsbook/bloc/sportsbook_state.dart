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
    @required this.timeZone,
  });

  final List<Game> games;
  final String gameName;
  final Map gameNumbers;
  final DateTime timeZone;
}
