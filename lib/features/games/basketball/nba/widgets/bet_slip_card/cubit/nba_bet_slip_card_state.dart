part of 'nba_bet_slip_card_cubit.dart';

enum NbaBetSlipCardStatus { initial, opened, updated }

class NbaBetSlipCardState extends Equatable {
  const NbaBetSlipCardState._({
    this.status = NbaBetSlipCardStatus.initial,
    this.toWinAmount,
    this.betSlipCardData,
  });

  const NbaBetSlipCardState.initial() : this._();

  const NbaBetSlipCardState.opened({
    @required int toWinAmount,
    @required BetSlipCardData betSlipCardData,
  }) : this._(
          toWinAmount: toWinAmount,
          status: NbaBetSlipCardStatus.opened,
          betSlipCardData: betSlipCardData,
        );

  final NbaBetSlipCardStatus status;
  final int toWinAmount;
  final BetSlipCardData betSlipCardData;

  @override
  List<Object> get props => [status, toWinAmount, betSlipCardData];
}
