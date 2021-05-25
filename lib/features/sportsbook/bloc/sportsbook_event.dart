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
