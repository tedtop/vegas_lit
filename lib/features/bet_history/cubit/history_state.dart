part of 'history_cubit.dart';

enum HistoryStatus { initial, loading, success, failure }

class HistoryState extends Equatable {
  const HistoryState({
    this.status = HistoryStatus.initial,
    this.bets = const [],
  });

  final HistoryStatus status;
  final List<BetData> bets;

  @override
  List<Object> get props => [status, bets];
}
