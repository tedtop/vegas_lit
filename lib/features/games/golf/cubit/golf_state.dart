part of 'golf_cubit.dart';

abstract class GolfState extends Equatable {
  const GolfState();

  @override
  List<Object> get props => [];
}

class GolfInitial extends GolfState {}

class GolfTournamentsOpened extends GolfState {
  GolfTournamentsOpened({@required this.tournaments});
  final List<GolfTournament> tournaments;
}

class GolfDetailOpened extends GolfState {
  GolfDetailOpened({@required this.players, @required this.tournament});
  final GolfTournament tournament;
  final List<GolfPlayer> players;
}

class GolfPlayerOpened extends GolfState {
  GolfPlayerOpened(
      {@required this.player,
      @required this.name,
      @required this.venue,
      @required this.location,
      this.tournamentID});
  final int tournamentID;
  final String name, venue, location;
  final GolfPlayer player;
}
