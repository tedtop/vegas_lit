

part of 'sportsbook_bloc.dart';

enum SportsbookStatus {
  initial,
  opened,
}

class SportsbookState extends Equatable {
  const SportsbookState._({
    this.league = 'OLYMPICS',
    this.gameNumbers = const <String, String>{
      'NFL': '0',
      'NBA': '0',
      'PARALYMPICS': '0',
      'OLYMPICS': '0',
      'MLB': '0',
      'NHL': '0',
      'NCAAF': '0',
      'NCAAB': '0',
      'GOLF': '0',
      'CRICKET': '0',
    },
    this.estTimeZone,
    this.status = SportsbookStatus.initial,
    this.isRulesShown = true,
  });

  const SportsbookState.initial({
    required bool isRulesShown,
  }) : this._(
          isRulesShown: isRulesShown,
        );

  const SportsbookState.opened({
    required String? league,
    required Map<String, String> gameNumbers,
    required DateTime? estTimeZone,
    required bool isRulesShown,
  }) : this._(
          league: league,
          gameNumbers: gameNumbers,
          estTimeZone: estTimeZone,
          status: SportsbookStatus.opened,
          isRulesShown: isRulesShown,
        );

  final String? league;
  final Map<String, String> gameNumbers;
  final DateTime? estTimeZone;
  final bool isRulesShown;
  final SportsbookStatus status;

  @override
  List<Object?> get props {
    return [
      league,
      gameNumbers,
      estTimeZone,
      status,
      isRulesShown,
    ];
  }
}
