part of 'bet_button_cubit.dart';

enum NhlBetButtonStatus {
  loading,
  clicked,
  unclicked,
  placing,
  placed,
  alreadyPlaced,
}

enum BetButtonWin { away, home }

class NhlBetButtonState extends Equatable {
  const NhlBetButtonState({
    this.text,
    this.game,
    this.uniqueId,
    this.mainOdds,
    this.status = NhlBetButtonStatus.loading,
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

  final NhlBetButtonStatus status;
  final String text;
  final NhlGame game;
  final String uniqueId;
  final Bet betType;
  final String mainOdds;
  final double spread;
  final NhlTeam awayTeamData;
  final String league;
  final String uid;
  final int betAmount;
  final int toWinAmount;
  final NhlTeam homeTeamData;
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

  NhlBetButtonState copyWith({
    NhlBetButtonStatus status,
    String text,
    NhlGame game,
    String uniqueId,
    Bet betType,
    String mainOdds,
    double spread,
    NhlTeam awayTeamData,
    String league,
    String uid,
    int betAmount,
    int toWinAmount,
    NhlTeam homeTeamData,
    BetButtonWin winTeam,
  }) {
    return NhlBetButtonState(
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
