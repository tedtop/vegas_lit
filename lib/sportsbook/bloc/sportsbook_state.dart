part of 'sportsbook_bloc.dart';

enum SportsbookStatus { initial, loading, opened }

class SportsbookState extends Equatable {
  const SportsbookState._({
    this.games,
    this.league = 'MLB',
    this.gameNumbers,
    this.parsedTeamData,
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

  final List<Game> games;
  final String league;
  final Map gameNumbers;
  final dynamic parsedTeamData;
  final DateTime estTimeZone;
  final DateTime localTimeZone;
  final SportsbookStatus status;

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
