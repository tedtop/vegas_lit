part of 'sportsbook_bloc.dart';

enum SportsbookStatus {
  initial,
  loading,
  opened,
  golfOpen,
  golfDetailOpen,
  golfPlayerOpened
}

class SportsbookState extends Equatable {
  const SportsbookState._({
    this.games,
    this.league = 'MLB',
    this.gameNumbers,
    this.parsedTeamData,
    this.tournamentID,
    this.name,
    this.venue,
    this.location,
    this.player,
    this.tournament,
    this.players,
    this.tournaments,
    this.estTimeZone,
    this.localTimeZone,
    this.status = SportsbookStatus.initial,
  });

  const SportsbookState.initial() : this._();

  const SportsbookState.opened({
    @required List<Game> games,
    @required String league,
    @required Map gameNumbers,
    @required dynamic parsedTeamData,
    @required DateTime estTimeZone,
    @required DateTime localTimeZone,
  }) : this._(
          games: games,
          league: league,
          gameNumbers: gameNumbers,
          parsedTeamData: parsedTeamData,
          estTimeZone: estTimeZone,
          localTimeZone: localTimeZone,
          status: SportsbookStatus.opened,
        );

  const SportsbookState.loading({
    @required String league,
    @required Map gameNumbers,
    @required DateTime estTimeZone,
    @required DateTime localTimeZone,
  }) : this._(
          league: league,
          games: const [],
          gameNumbers: gameNumbers,
          estTimeZone: estTimeZone,
          localTimeZone: localTimeZone,
          status: SportsbookStatus.loading,
        );

  const SportsbookState.golfTournamentOpened(
      {@required List<GolfTournament> tournaments})
      : this._(tournaments: tournaments);

  const SportsbookState.golfDetailOpened(
      {@required List<GolfPlayer> players, @required GolfTournament tournament})
      : this._(players: players, tournament: tournament);

  const SportsbookState.golfPlayerOpened(
      {@required GolfPlayer player,
      @required String name,
      venue,
      location,
      @required int tournamentID})
      : this._(
            player: player,
            name: name,
            venue: venue,
            location: location,
            tournamentID: tournamentID);

  final List<Game> games;
  final String league;
  final Map gameNumbers;
  final dynamic parsedTeamData;
  final DateTime estTimeZone;
  final DateTime localTimeZone;
  final SportsbookStatus status;

  /// Other
  final int tournamentID;
  final String name, venue, location;
  final GolfPlayer player;
  final GolfTournament tournament;
  final List<GolfPlayer> players;
  final List<GolfTournament> tournaments;

  @override
  List<Object> get props {
    return [
      games,
      league,
      gameNumbers,
      parsedTeamData,
      estTimeZone,
      status,
      localTimeZone,
    ];
  }
}
