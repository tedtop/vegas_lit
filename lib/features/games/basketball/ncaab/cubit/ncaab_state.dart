part of 'ncaab_cubit.dart';

enum NcaabStatus {
  initial,
  opened,
}

class NcaabState extends Equatable {
  const NcaabState._({
    this.games,
    this.league = 'NCAAB',
    // this.gameNumbers,
    this.parsedTeamData,
    this.estTimeZone,
    this.localTimeZone,
    this.status = NcaabStatus.initial,
  });

  const NcaabState.initial() : this._();

  const NcaabState.opened({
    @required List<NcaabGame> games,
    @required String league,
    @required List parsedTeamData,
    @required DateTime estTimeZone,
    @required DateTime localTimeZone,
  }) : this._(
          games: games,
          league: league,
          parsedTeamData: parsedTeamData,
          estTimeZone: estTimeZone,
          localTimeZone: localTimeZone,
          status: NcaabStatus.opened,
        );

  final List<NcaabGame> games;
  final String league;
  final List parsedTeamData;
  final DateTime estTimeZone;
  final DateTime localTimeZone;
  final NcaabStatus status;

  @override
  List<Object> get props {
    return [
      games,
      league,
      // gameNumbers,
      parsedTeamData,
      estTimeZone,
      status,
      localTimeZone,
    ];
  }
}
