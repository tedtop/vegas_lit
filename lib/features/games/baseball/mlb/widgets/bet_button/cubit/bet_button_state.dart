

part of 'bet_button_cubit.dart';

enum MlbBetButtonStatus {
  loading,
  clicked,
  unclicked,
  placing,
  placed,
}

enum BetButtonWin { away, home }

class MlbBetButtonState extends Equatable {
  const MlbBetButtonState({
    this.text,
    this.game,
    this.uniqueId,
    this.mainOdds,
    this.status = MlbBetButtonStatus.loading,
    this.betType,
    this.betAmount = 100,
    this.toWinAmount,
    this.awayTeamData,
    this.spread,
    this.uid,
    this.league,
    this.homeTeamData,
    this.winTeam,
  });

  final MlbBetButtonStatus status;
  final String? text;
  final MlbGame? game;
  final String? uniqueId;
  final Bet? betType;
  final String? mainOdds;
  final double? spread;
  final MlbTeam? awayTeamData;
  final String? league;
  final String? uid;
  final int betAmount;
  final int? toWinAmount;
  final MlbTeam? homeTeamData;
  final BetButtonWin? winTeam;

  @override
  List<Object?> get props => [
        status,
        text,
        league,
        winTeam,
        betAmount,
        toWinAmount,
        spread,
        game,
        uniqueId,
        betType,
        uid,
        mainOdds,
        awayTeamData,
        homeTeamData
      ];

  MlbBetButtonState copyWith({
    MlbBetButtonStatus? status,
    String? text,
    MlbGame? game,
    String? uniqueId,
    Bet? betType,
    String? mainOdds,
    double? spread,
    MlbTeam? awayTeamData,
    String? league,
    String? uid,
    int? betAmount,
    int? toWinAmount,
    MlbTeam? homeTeamData,
    BetButtonWin? winTeam,
  }) {
    return MlbBetButtonState(
      status: status ?? this.status,
      text: text ?? this.text,
      game: game ?? this.game,
      uniqueId: uniqueId ?? this.uniqueId,
      betType: betType ?? this.betType,
      mainOdds: mainOdds ?? this.mainOdds,
      spread: spread ?? this.spread,
      awayTeamData: awayTeamData ?? this.awayTeamData,
      league: league ?? this.league,
      uid: uid ?? this.uid,
      betAmount: betAmount ?? this.betAmount,
      toWinAmount: toWinAmount ?? this.toWinAmount,
      homeTeamData: homeTeamData ?? this.homeTeamData,
      winTeam: winTeam ?? this.winTeam,
    );
  }
}
