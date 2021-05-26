part of 'bet_history_cubit.dart';

enum BetHistoryStatus { initial, opened }

class BetHistoryState extends Equatable {
  const BetHistoryState._({
    this.status = BetHistoryStatus.initial,
    this.betHistoryListData = const [],
  });

  const BetHistoryState.initial() : this._();

  const BetHistoryState.opened({
    @required List<BetData> betHistoryListData,
  }) : this._(
          status: BetHistoryStatus.opened,
          betHistoryListData: betHistoryListData,
        );

  final BetHistoryStatus status;
  final List<BetData> betHistoryListData;

  @override
  List<Object> get props => [status, betHistoryListData];
}
