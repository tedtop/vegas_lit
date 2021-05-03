part of 'sportsbook_bloc.dart';

abstract class SportsbookEvent {
  const SportsbookEvent();
}

class SportsbookOpen extends SportsbookEvent {
  SportsbookOpen({@required this.league});
  final String league;
}

class GolfTournamentsOpen extends SportsbookEvent {}

class GolfDetailOpen extends SportsbookEvent {
  GolfDetailOpen({@required this.tournamentID});
  final int tournamentID;
}

class GolfPlayerOpen extends SportsbookEvent {
  GolfPlayerOpen({this.player, this.tournament});
  final GolfTournament tournament;
  final GolfPlayer player;
}
