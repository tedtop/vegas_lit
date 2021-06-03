part of 'open_bets_cubit.dart';

enum OpenBetsStatus { initial, loading, success, failure }

class OpenBetsState extends Equatable {
  const OpenBetsState({
    this.status = OpenBetsStatus.initial,
    this.bets = const [],
  });

  final OpenBetsStatus status;
  final List<BetData> bets;

  @override
  List<Object> get props => [status, bets];
}
