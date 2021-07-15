part of 'olympics_bet_button_cubit.dart';

enum OlympicsBetButtonStatus {
  loading,
  clicked,
  unclicked,
  placing,
  placed,
  alreadyPlaced,
}

enum BetButtonWin { player1, player2 }

class OlympicsBetButtonState extends Equatable {
  const OlympicsBetButtonState({
    this.status = OlympicsBetButtonStatus.loading,
    this.text,
    this.game,
    this.uniqueId,
    this.spread,
    this.league,
    this.uid,
    this.betAmount = 100,
    this.toWinAmount,
    this.winTeam,
  });

  final OlympicsBetButtonStatus status;
  final String text;
  final OlympicsGame game;
  final String uniqueId;
  final double spread;
  final String league;
  final String uid;
  final int betAmount;
  final int toWinAmount;
  final BetButtonWin winTeam;

  @override
  List<Object> get props => [];

  OlympicsBetButtonState copyWith({
    OlympicsBetButtonStatus status,
    String text,
    OlympicsGame game,
    String uniqueId,
    double spread,
    String league,
    String uid,
    int betAmount,
    int toWinAmount,
    BetButtonWin winTeam,
  }) {
    return OlympicsBetButtonState(
      status: status ?? this.status,
      text: text ?? this.text,
      game: game ?? this.game,
      uniqueId: uniqueId ?? this.uniqueId,
      spread: spread ?? this.spread,
      league: league ?? this.league,
      uid: uid ?? this.uid,
      betAmount: betAmount ?? this.betAmount,
      toWinAmount: toWinAmount ?? this.toWinAmount,
      winTeam: winTeam ?? this.winTeam,
    );
  }
}
