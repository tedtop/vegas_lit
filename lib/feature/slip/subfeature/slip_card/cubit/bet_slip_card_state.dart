part of 'bet_slip_card_cubit.dart';

enum BetSlipCardStatus { loading, opened, confirmed }

class BetSlipCardState extends Equatable {
  const BetSlipCardState._({
    this.status = BetSlipCardStatus.loading,
    this.betAmount,
    this.betType,
  });

  const BetSlipCardState.loading() : this._();

  const BetSlipCardState.opened({@required Bet betType})
      : this._(
          status: BetSlipCardStatus.opened,
          betType: betType,
        );

  const BetSlipCardState.confirmed({@required String betAmount})
      : this._(
          status: BetSlipCardStatus.confirmed,
          betAmount: betAmount,
        );

  final BetSlipCardStatus status;
  final String betAmount;
  final Bet betType;

  @override
  List<Object> get props => [status, betAmount, betType];
}
