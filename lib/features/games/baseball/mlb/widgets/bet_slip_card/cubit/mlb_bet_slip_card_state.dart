part of 'mlb_bet_slip_card_cubit.dart';

enum MlbBetSlipCardStatus { initial, opened, updated }

class MlbBetSlipCardState extends Equatable {
  const MlbBetSlipCardState._({
    this.status = MlbBetSlipCardStatus.initial,
    this.toWinAmount,
    this.betSlipCardData,
  });

  const MlbBetSlipCardState.initial() : this._();

  const MlbBetSlipCardState.opened({
    @required int toWinAmount,
    @required BetSlipCardData betSlipCardData,
  }) : this._(
          toWinAmount: toWinAmount,
          status: MlbBetSlipCardStatus.opened,
          betSlipCardData: betSlipCardData,
        );

  final MlbBetSlipCardStatus status;
  final int toWinAmount;
  final BetSlipCardData betSlipCardData;

  @override
  List<Object> get props => [status, toWinAmount, betSlipCardData];
}
