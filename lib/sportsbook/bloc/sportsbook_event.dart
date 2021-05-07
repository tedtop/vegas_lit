part of 'sportsbook_bloc.dart';

abstract class SportsbookEvent extends Equatable {
  const SportsbookEvent();

  @override
  List<Object> get props => [];
}

class SportsbookOpen extends SportsbookEvent {
  SportsbookOpen({@required this.league});
  final String league;

  @override
  List<Object> get props => [league];
}

class SportsbookLeagueChange extends SportsbookEvent {
  SportsbookLeagueChange({@required this.league});
  final String league;

  @override
  List<Object> get props => [league];
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
