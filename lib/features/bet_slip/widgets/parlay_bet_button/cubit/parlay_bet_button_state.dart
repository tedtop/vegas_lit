part of 'parlay_bet_button_cubit.dart';

enum ParlayBetButtonStatus {
  initial,
  loading,
  placing,
  placed,
  alreadyPlaced,
}

class ParlayBetButtonState extends Equatable {
  const ParlayBetButtonState({
    this.status = ParlayBetButtonStatus.initial,
    this.betAmount = 100,
    this.toWinAmount,
    this.league,
    this.uid,
    this.uniqueId,
  });

  final ParlayBetButtonStatus status;
  final int betAmount;
  final int toWinAmount;
  final String league;
  final String uid;
  final String uniqueId;

  @override
  List<Object> get props {
    return [
      status,
      betAmount,
      toWinAmount,
      league,
      uid,
      uniqueId,
    ];
  }

  ParlayBetButtonState copyWith({
    ParlayBetButtonStatus status,
    int betAmount,
    int toWinAmount,
    String league,
    String uid,
    String uniqueId,
  }) {
    return ParlayBetButtonState(
      status: status ?? this.status,
      betAmount: betAmount ?? this.betAmount,
      toWinAmount: toWinAmount ?? this.toWinAmount,
      league: league ?? this.league,
      uid: uid ?? this.uid,
      uniqueId: uniqueId ?? this.uniqueId,
    );
  }
}
