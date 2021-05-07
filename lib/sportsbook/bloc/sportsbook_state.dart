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

  const SportsbookState.golfTournamentOpened({
    @required List<GolfTournament> tournaments,
    @required String league,
    @required Map gameNumbers,
    @required DateTime estTimeZone,
    @required DateTime localTimeZone,
  }) : this._(
          tournaments: tournaments,
          league: league,
          games: const [],
          gameNumbers: gameNumbers,
          estTimeZone: estTimeZone,
          localTimeZone: localTimeZone,
          status: SportsbookStatus.golfOpen,
        );

  const SportsbookState.golfDetailOpened({
    @required List<GolfPlayer> players,
    @required GolfTournament tournament,
    @required String league,
    @required Map gameNumbers,
    @required DateTime estTimeZone,
    @required DateTime localTimeZone,
  }) : this._(
            players: players,
            tournament: tournament,
            league: league,
            games: const [],
            gameNumbers: gameNumbers,
            estTimeZone: estTimeZone,
            localTimeZone: localTimeZone,
            status: SportsbookStatus.golfDetailOpen);

  const SportsbookState.golfPlayerOpened({
    @required GolfPlayer player,
    @required String name,
    venue,
    location,
    @required int tournamentID,
    @required String league,
    @required Map gameNumbers,
    @required DateTime estTimeZone,
    @required DateTime localTimeZone,
  }) : this._(
            player: player,
            name: name,
            venue: venue,
            location: location,
            league: league,
            games: const [],
            gameNumbers: gameNumbers,
            estTimeZone: estTimeZone,
            localTimeZone: localTimeZone,
            tournamentID: tournamentID,
            status: SportsbookStatus.golfPlayerOpened);

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
      tournamentID,
      name,
      venue,
      location,
      player,
      tournament,
      players,
      tournaments,
      league,
      gameNumbers,
      parsedTeamData,
      estTimeZone,
      status,
      localTimeZone,
    ];
  }
}
