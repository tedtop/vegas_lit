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
    @required List<Game> games,
    @required String league,
    // @required Map gameNumbers,
    @required dynamic parsedTeamData,
    @required DateTime estTimeZone,
    @required DateTime localTimeZone,
  }) : this._(
          games: games,
          league: league,
          // gameNumbers: gameNumbers,
          parsedTeamData: parsedTeamData,
          estTimeZone: estTimeZone,
          localTimeZone: localTimeZone,
          status: NcaabStatus.opened,
        );

  // const NcaabState.loading({
  //   @required String league,
  //   @required Map gameNumbers,
  //   @required DateTime estTimeZone,
  //   @required DateTime localTimeZone,
  // }) : this._(
  //         league: league,
  //         games: const [],
  //         gameNumbers: gameNumbers,
  //         estTimeZone: estTimeZone,
  //         localTimeZone: localTimeZone,
  //         status: SportsbookStatus.loading,
  //       );

  final List<Game> games;
  final String league;
  // final Map gameNumbers;
  final dynamic parsedTeamData;
  final DateTime estTimeZone;
  final DateTime localTimeZone;
  final NcaabStatus status;

  /// Other

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
