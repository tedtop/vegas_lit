part of 'sportsbook_bloc.dart';

abstract class SportsbookState {
  const SportsbookState();
}

class SportsbookInitial extends SportsbookState {}

class SportsbookOpened extends SportsbookState {
  SportsbookOpened({
    @required this.games,
    @required this.league,
    @required this.gameNumbers,
    @required this.parsedTeamData,
    @required this.estTimeZone,
    @required this.localTimeZone,
  });

  final List<Game> games;
  final String league;
  final Map gameNumbers;
  final dynamic parsedTeamData;
  final DateTime estTimeZone;
  final DateTime localTimeZone;
}
