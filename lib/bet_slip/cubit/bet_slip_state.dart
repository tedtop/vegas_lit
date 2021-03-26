part of 'bet_slip_cubit.dart';

enum BetSlipStatus { loading, empty, opened, added, removed }

class BetSlipState extends Equatable {
  const BetSlipState._({
    this.betSlipCardData,
    this.status = BetSlipStatus.loading,
  });

  const BetSlipState.loading() : this._();

  const BetSlipState.opened({
    @required List<BetSlipCardData> betSlipCardData,
  }) : this._(
          status: BetSlipStatus.opened,
          betSlipCardData: betSlipCardData,
        );

  final List<BetSlipCardData> betSlipCardData;
  final BetSlipStatus status;

  @override
  List<Object> get props => [betSlipCardData, status];
}
