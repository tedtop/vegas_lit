part of 'history_cubit.dart';

enum HistoryStatus { initial, loading, success, failure }

class HistoryState extends Equatable {
  const HistoryState({
    this.status = HistoryStatus.initial,
    this.bets = const [],
    this.userWallet,
  });

  final HistoryStatus status;
  final List<BetData> bets;
  final Wallet userWallet;

  @override
  List<Object> get props => [status, bets, userWallet];
}
