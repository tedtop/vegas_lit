part of 'nfl_bet_slip_card_cubit.dart';

enum NflBetSlipCardStatus { initial, opened, updated }

class NflBetSlipCardState extends Equatable {
  const NflBetSlipCardState._({
    this.status = NflBetSlipCardStatus.initial,
    this.toWinAmount,
    this.betSlipCardData,
  });

  const NflBetSlipCardState.initial() : this._();

  const NflBetSlipCardState.opened({
    @required int toWinAmount,
    @required BetSlipCardData betSlipCardData,
  }) : this._(
          toWinAmount: toWinAmount,
          status: NflBetSlipCardStatus.opened,
          betSlipCardData: betSlipCardData,
        );

  final NflBetSlipCardStatus status;
  final int toWinAmount;
  final BetSlipCardData betSlipCardData;

  @override
  List<Object> get props => [status, toWinAmount, betSlipCardData];
}
