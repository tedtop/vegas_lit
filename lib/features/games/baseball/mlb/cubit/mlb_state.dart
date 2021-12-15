part of 'mlb_cubit.dart';

enum MlbStatus {
  initial,
  opened,
}

class MlbState extends Equatable {
  const MlbState._({
    this.games,
    this.league = 'MLB',
    this.teamData,
    this.estTimeZone,
    this.status = MlbStatus.initial,
  });

  const MlbState.initial() : this._();

  const MlbState.opened({
    required List<MlbGame> games,
    required String league,
    required List<MlbTeam> teamData,
    required DateTime estTimeZone,
  }) : this._(
          games: games,
          league: league,
          teamData: teamData,
          estTimeZone: estTimeZone,
          status: MlbStatus.opened,
        );

  final List<MlbGame>? games;
  final String league;
  final List<MlbTeam>? teamData;
  final DateTime? estTimeZone;
  final MlbStatus status;

  @override
  List<Object?> get props {
    return [
      games,
      league,
      teamData,
      estTimeZone,
      status,
    ];
  }
}
