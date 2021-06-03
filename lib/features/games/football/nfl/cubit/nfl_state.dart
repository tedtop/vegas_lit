part of 'nfl_cubit.dart';

enum NflStatus {
  initial,
  opened,
}

class NflState extends Equatable {
  const NflState._({
    this.games,
    this.league = 'NFL',
    // this.gameNumbers,
    this.parsedTeamData,
    this.estTimeZone,
    this.localTimeZone,
    this.status = NflStatus.initial,
  });

  const NflState.initial() : this._();

  const NflState.opened({
    @required List<NflGame> games,
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
          status: NflStatus.opened,
        );

  // const NflState.loading({
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

  final List<NflGame> games;
  final String league;
  // final Map gameNumbers;
  final dynamic parsedTeamData;
  final DateTime estTimeZone;
  final DateTime localTimeZone;
  final NflStatus status;

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
