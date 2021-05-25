part of 'bet_slip_cubit.dart';

enum BetSlipStatus { loading, empty, opened, added, removed }

class BetSlipState extends Equatable {
  const BetSlipState._({
    this.betSlipCardData,
    this.betPlacedCount = 0,
    this.status = BetSlipStatus.loading,
  });

  const BetSlipState.loading() : this._();

  const BetSlipState.opened({
    @required List<BetSlipCardData> betSlipCardData,
    @required int betPlacedCount,
  }) : this._(
          status: BetSlipStatus.opened,
          betSlipCardData: betSlipCardData,
          betPlacedCount: betPlacedCount,
        );

  final List<BetSlipCardData> betSlipCardData;
  final BetSlipStatus status;
  final int betPlacedCount;

  @override
  List<Object> get props => [betSlipCardData, status, betPlacedCount];
}
