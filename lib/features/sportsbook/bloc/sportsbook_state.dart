part of 'sportsbook_bloc.dart';

enum SportsbookStatus {
  initial,
  opened,
}

class SportsbookState extends Equatable {
  const SportsbookState._({
    this.league = 'MLB',
    this.gameNumbers,
    this.estTimeZone,
    this.status = SportsbookStatus.initial,
  });

  const SportsbookState.initial() : this._();

  const SportsbookState.opened({
    @required String league,
    @required Map gameNumbers,
    @required DateTime estTimeZone,
  }) : this._(
          league: league,
          gameNumbers: gameNumbers,
          estTimeZone: estTimeZone,
          status: SportsbookStatus.opened,
        );

  final String league;
  final Map gameNumbers;
  final DateTime estTimeZone;
  final SportsbookStatus status;

  @override
  List<Object> get props {
    return [
      league,
      gameNumbers,
      estTimeZone,
      status,
    ];
  }
}
