part of 'bet_history_cubit.dart';

enum BetHistoryStatus { initial, opened }

class BetHistoryState extends Equatable {
  const BetHistoryState._({
    this.status = BetHistoryStatus.initial,
    this.betHistoryDataList = const [],
  });

  const BetHistoryState.initial() : this._();

  const BetHistoryState.opened({
    @required List<BetHistoryData> betHistoryDataList,
  }) : this._(
          status: BetHistoryStatus.opened,
          betHistoryDataList: betHistoryDataList,
        );

  final BetHistoryStatus status;
  final List<BetHistoryData> betHistoryDataList;

  @override
  List<Object> get props => [status, betHistoryDataList];
}
