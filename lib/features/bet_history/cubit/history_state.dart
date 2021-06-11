part of 'history_cubit.dart';

enum HistoryStatus { initial, loading, success, failure }

class HistoryState extends Equatable {
  const HistoryState({
    this.status = HistoryStatus.initial,
    this.bets = const [],
    this.userWallet,
    this.weeks = const [],
    this.week = 'Current Week',
    this.uid,
  });

  final HistoryStatus status;
  final List<BetData> bets;
  final Wallet userWallet;
  final List<String> weeks;
  final String week;
  final String uid;

  @override
  List<Object> get props => [status, bets, userWallet, weeks, week, uid];
}
