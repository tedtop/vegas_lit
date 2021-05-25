part of 'ncaaf_bet_slip_card_cubit.dart';

enum NcaafBetSlipCardStatus { initial, opened, updated }

class NcaafBetSlipCardState extends Equatable {
  const NcaafBetSlipCardState._({
    this.status = NcaafBetSlipCardStatus.initial,
    this.toWinAmount,
    this.betSlipCardData,
  });

  const NcaafBetSlipCardState.initial() : this._();

  const NcaafBetSlipCardState.opened({
    @required int toWinAmount,
    @required BetSlipCardData betSlipCardData,
  }) : this._(
          toWinAmount: toWinAmount,
          status: NcaafBetSlipCardStatus.opened,
          betSlipCardData: betSlipCardData,
        );

  final NcaafBetSlipCardStatus status;
  final int toWinAmount;
  final BetSlipCardData betSlipCardData;

  @override
  List<Object> get props => [status, toWinAmount, betSlipCardData];
}
