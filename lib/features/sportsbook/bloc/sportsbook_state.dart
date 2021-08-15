part of 'sportsbook_bloc.dart';

enum SportsbookStatus {
  initial,
  opened,
}

class SportsbookState extends Equatable {
  const SportsbookState._({
    this.league = 'OLYMPICS',
    this.gameNumbers,
    this.estTimeZone,
    this.status = SportsbookStatus.initial,
    this.isRulesShown = true,
  });

  const SportsbookState.initial({
    @required bool isRulesShown,
  }) : this._(
          isRulesShown: isRulesShown,
        );

  const SportsbookState.opened({
    @required String league,
    @required Map gameNumbers,
    @required DateTime estTimeZone,
    @required bool isRulesShown,
  }) : this._(
          league: league,
          gameNumbers: gameNumbers,
          estTimeZone: estTimeZone,
          status: SportsbookStatus.opened,
          isRulesShown: isRulesShown,
        );

  final String league;
  final Map gameNumbers;
  final DateTime estTimeZone;
  final bool isRulesShown;
  final SportsbookStatus status;

  @override
  List<Object> get props {
    return [
      league,
      gameNumbers,
      estTimeZone,
      status,
      isRulesShown,
    ];
  }
}
