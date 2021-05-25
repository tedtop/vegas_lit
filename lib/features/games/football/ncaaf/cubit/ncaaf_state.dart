part of 'ncaaf_cubit.dart';

enum NcaafStatus {
  initial,
  opened,
}

class NcaafState extends Equatable {
  const NcaafState._({
    this.games,
    this.league = 'NCAAF',
    // this.gameNumbers,
    this.parsedTeamData,
    this.estTimeZone,
    this.localTimeZone,
    this.status = NcaafStatus.initial,
  });

  const NcaafState.initial() : this._();

  const NcaafState.opened({
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
          status: NcaafStatus.opened,
        );

  // const NcaafState.loading({
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
  final NcaafStatus status;

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
