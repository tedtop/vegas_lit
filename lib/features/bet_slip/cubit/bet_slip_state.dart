part of 'bet_slip_cubit.dart';

enum BetSlipStatus { loading, empty, opened, added, removed }

class BetSlipState extends Equatable {
  const BetSlipState._({
    this.betSlipCard,
    this.status = BetSlipStatus.loading,
  });

  const BetSlipState.loading() : this._();

  const BetSlipState.opened({
    @required List<Widget> betSlipCard,
  }) : this._(
          status: BetSlipStatus.opened,
          betSlipCard: betSlipCard,
        );

  final List<Widget> betSlipCard;
  final BetSlipStatus status;

  @override
  List<Object> get props => [betSlipCard, status];
}
