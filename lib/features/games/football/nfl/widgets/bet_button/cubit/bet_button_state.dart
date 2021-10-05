part of 'bet_button_cubit.dart';

enum NflBetButtonStatus {
  loading,
  clicked,
  unclicked,
  placing,
  placed,
}

enum BetButtonWin { away, home }

class NflBetButtonState extends Equatable {
  const NflBetButtonState({
    this.text,
    this.game,
    this.uniqueId,
    this.mainOdds,
    this.status = NflBetButtonStatus.loading,
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

  final NflBetButtonStatus status;
  final String text;
  final NflGame game;
  final String uniqueId;
  final Bet betType;
  final String mainOdds;
  final double spread;
  final NflTeam awayTeamData;
  final String league;
  final String uid;
  final int betAmount;
  final int toWinAmount;
  final NflTeam homeTeamData;
  final BetButtonWin winTeam;

  @override
  List<Object> get props => [
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

  NflBetButtonState copyWith({
    NflBetButtonStatus status,
    String text,
    NflGame game,
    String uniqueId,
    Bet betType,
    String mainOdds,
    double spread,
    NflTeam awayTeamData,
    String league,
    String uid,
    int betAmount,
    int toWinAmount,
    NflTeam homeTeamData,
    BetButtonWin winTeam,
  }) {
    return NflBetButtonState(
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
