part of 'nfl_cubit.dart';

enum NflStatus {
  initial,
  opened,
}

class NflState extends Equatable {
  const NflState._({
    this.games,
    this.league = 'NFL',
    this.parsedTeamData,
    this.estTimeZone,
    this.status = NflStatus.initial,
  });

  const NflState.initial() : this._();

  const NflState.opened({
    @required List<NflGame> games,
    @required String league,
    @required List<NflTeam> parsedTeamData,
    @required DateTime estTimeZone,
  }) : this._(
          games: games,
          league: league,
          parsedTeamData: parsedTeamData,
          estTimeZone: estTimeZone,
          status: NflStatus.opened,
        );

  final List<NflGame> games;
  final String league;
  final List<NflTeam> parsedTeamData;
  final DateTime estTimeZone;
  final NflStatus status;

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
