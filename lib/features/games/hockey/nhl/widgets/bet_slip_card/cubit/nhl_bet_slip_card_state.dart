part of 'nhl_bet_slip_card_cubit.dart';

enum NhlBetSlipCardStatus { initial, opened, updated }

class NhlBetSlipCardState extends Equatable {
  const NhlBetSlipCardState._({
    this.status = NhlBetSlipCardStatus.initial,
    this.toWinAmount,
    this.betSlipCardData,
  });

  const NhlBetSlipCardState.initial() : this._();

  const NhlBetSlipCardState.opened({
    @required int toWinAmount,
    @required BetSlipCardData betSlipCardData,
  }) : this._(
          toWinAmount: toWinAmount,
          status: NhlBetSlipCardStatus.opened,
          betSlipCardData: betSlipCardData,
        );

  final NhlBetSlipCardStatus status;
  final int toWinAmount;
  final BetSlipCardData betSlipCardData;

  @override
  List<Object> get props => [status, toWinAmount, betSlipCardData];
}
