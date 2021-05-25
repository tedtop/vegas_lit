part of 'nhl_cubit.dart';

enum NhlStatus {
  initial,
  opened,
}

class NhlState extends Equatable {
  const NhlState._({
    this.games,
    this.league = 'NHL',
    // this.gameNumbers,
    this.parsedTeamData,
    this.estTimeZone,
    this.localTimeZone,
    this.status = NhlStatus.initial,
  });

  const NhlState.initial() : this._();

  const NhlState.opened({
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
          status: NhlStatus.opened,
        );

  // const NhlState.loading({
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
  final NhlStatus status;

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
