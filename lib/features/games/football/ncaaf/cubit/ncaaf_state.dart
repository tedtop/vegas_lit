

part of 'ncaaf_cubit.dart';

enum NcaafStatus {
  initial,
  opened,
}

class NcaafState extends Equatable {
  const NcaafState._({
    this.games,
    this.league = 'NCAAF',
    this.parsedTeamData,
    this.estTimeZone,
    this.status = NcaafStatus.initial,
  });

  const NcaafState.initial() : this._();

  const NcaafState.opened({
    required List<NcaafGame> games,
    required String league,
    required List<NcaafTeam> parsedTeamData,
    required DateTime estTimeZone,
  }) : this._(
          games: games,
          league: league,
          parsedTeamData: parsedTeamData,
          estTimeZone: estTimeZone,
          status: NcaafStatus.opened,
        );

  final List<NcaafGame>? games;
  final String league;
  final List<NcaafTeam>? parsedTeamData;
  final DateTime? estTimeZone;
  final NcaafStatus status;

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
