part of 'mlb_cubit.dart';

enum MlbStatus {
  initial,
  opened,
}

class MlbState extends Equatable {
  const MlbState._({
    this.games,
    this.league = 'MLB',
    this.parsedTeamData,
    this.estTimeZone,
    this.status = MlbStatus.initial,
  });

  const MlbState.initial() : this._();

  const MlbState.opened({
    @required List<Game> games,
    @required String league,
    @required dynamic parsedTeamData,
    @required DateTime estTimeZone,
  }) : this._(
          games: games,
          league: league,
          parsedTeamData: parsedTeamData,
          estTimeZone: estTimeZone,
          status: MlbStatus.opened,
        );

  final List<Game> games;
  final String league;
  final dynamic parsedTeamData;
  final DateTime estTimeZone;
  final MlbStatus status;

  @override
  List<Object> get props {
    return [
      games,
      league,
      parsedTeamData,
      estTimeZone,
      status,
    ];
  }
}
