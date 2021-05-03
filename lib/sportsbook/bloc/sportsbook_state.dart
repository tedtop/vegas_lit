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

class GolfTournamentsOpened extends SportsbookState {
  GolfTournamentsOpened({@required this.tournaments});
  final List<GolfTournament> tournaments;
}

class GolfDetailOpened extends SportsbookState {
  GolfDetailOpened({this.players, this.tournament});
  final GolfTournament tournament;
  final List<GolfPlayer> players;
}

class GolfPlayerOpened extends SportsbookState {
  GolfPlayerOpened(
      {this.player, this.name, this.venue, this.location, this.tournamentID});
  final int tournamentID;
  final String name, venue, location;
  final GolfPlayer player;
}
