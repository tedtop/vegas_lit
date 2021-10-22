

part of 'paralympics_bet_button_cubit.dart';

enum ParalympicsBetButtonStatus {
  loading,
  clicked,
  unclicked,
  placing,
  placed,
  alreadyPlaced,
}

enum BetButtonWin { player, rival }

class ParalympicsBetButtonState extends Equatable {
  const ParalympicsBetButtonState({
    this.status = ParalympicsBetButtonStatus.loading,
    this.game,
    this.uniqueId,
    this.league,
    this.uid,
    this.betAmount = 100,
    this.toWinAmount,
    this.mainOdds = 100,
    this.winTeam,
  });

  final ParalympicsBetButtonStatus status;
  final ParalympicsGame? game;
  final String? uniqueId;
  final String? league;
  final String? uid;
  final int betAmount;
  final int? toWinAmount;
  final BetButtonWin? winTeam;
  final int mainOdds;

  @override
  List<Object?> get props => [
        status,
        game,
        uniqueId,
        league,
        uid,
        betAmount,
        mainOdds,
        toWinAmount,
        winTeam,
      ];

  ParalympicsBetButtonState copyWith({
    ParalympicsBetButtonStatus? status,
    ParalympicsGame? game,
    String? uniqueId,
    String? league,
    String? uid,
    int? mainOdds,
    int? betAmount,
    int? toWinAmount,
    BetButtonWin? winTeam,
  }) {
    return ParalympicsBetButtonState(
      status: status ?? this.status,
      game: game ?? this.game,
      uniqueId: uniqueId ?? this.uniqueId,
      league: league ?? this.league,
      mainOdds: mainOdds ?? this.mainOdds,
      uid: uid ?? this.uid,
      betAmount: betAmount ?? this.betAmount,
      toWinAmount: toWinAmount ?? this.toWinAmount,
      winTeam: winTeam ?? this.winTeam,
    );
  }
}
