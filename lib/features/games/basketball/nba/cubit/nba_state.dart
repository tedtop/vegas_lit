part of 'nba_cubit.dart';

enum NbaStatus {
  initial,
  opened,
}

class NbaState extends Equatable {
  const NbaState._({
    this.games,
    this.league = 'NBA',
    this.parsedTeamData,
    this.estTimeZone,
    this.status = NbaStatus.initial,
  });

  const NbaState.initial() : this._();

  const NbaState.opened({
    required List<NbaGame> games,
    required String league,
    required List<NbaTeam>? parsedTeamData,
    required DateTime estTimeZone,
  }) : this._(
          games: games,
          league: league,
          parsedTeamData: parsedTeamData,
          estTimeZone: estTimeZone,
          status: NbaStatus.opened,
        );

  final List<NbaGame>? games;
  final String league;
  final List<NbaTeam>? parsedTeamData;
  final DateTime? estTimeZone;
  final NbaStatus status;

  @override
  List<Object?> get props {
    return [
      games,
      league,
      parsedTeamData,
      estTimeZone,
      status,
    ];
  }
}
