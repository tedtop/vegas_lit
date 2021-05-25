part of 'ncaab_bet_slip_card_cubit.dart';

enum NcaabBetSlipCardStatus { initial, opened, updated }

class NcaabBetSlipCardState extends Equatable {
  const NcaabBetSlipCardState._({
    this.status = NcaabBetSlipCardStatus.initial,
    this.toWinAmount,
    this.betSlipCardData,
  });

  const NcaabBetSlipCardState.initial() : this._();

  const NcaabBetSlipCardState.opened({
    @required int toWinAmount,
    @required BetSlipCardData betSlipCardData,
  }) : this._(
          toWinAmount: toWinAmount,
          status: NcaabBetSlipCardStatus.opened,
          betSlipCardData: betSlipCardData,
        );

  final NcaabBetSlipCardStatus status;
  final int toWinAmount;
  final BetSlipCardData betSlipCardData;

  @override
  List<Object> get props => [status, toWinAmount, betSlipCardData];
}
