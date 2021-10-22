part of 'nhl_cubit.dart';

enum NhlStatus {
  initial,
  opened,
}

class NhlState extends Equatable {
  const NhlState._({
    this.games,
    this.league = 'NHL',
    this.parsedTeamData,
    this.estTimeZone,
    this.localTimeZone,
    this.status = NhlStatus.initial,
  });

  const NhlState.initial() : this._();

  const NhlState.opened({
    @required List<NhlGame> games,
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
          status: NhlStatus.opened,
        );

  final List<NhlGame> games;
  final String league;
  final List parsedTeamData;
  final DateTime estTimeZone;
  final DateTime localTimeZone;
  final NhlStatus status;

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
