part of 'bet_slip_cubit.dart';

enum BetSlipStatus { loading, empty, opened, added, removed }

class BetSlipState extends Equatable {
  const BetSlipState._({
    this.singleBetSlipCard,
    this.parlayBetSlipCard,
    this.status = BetSlipStatus.loading,
  });

  const BetSlipState.loading() : this._();

  const BetSlipState.opened({
    @required List<Widget> singleBetSlipCard,
    @required List<Widget> parlayBetSlipCard,
  }) : this._(
          status: BetSlipStatus.opened,
          singleBetSlipCard: singleBetSlipCard,
          parlayBetSlipCard: parlayBetSlipCard,
        );

  final List<Widget> singleBetSlipCard;
  final List<Widget> parlayBetSlipCard;
  final BetSlipStatus status;

  @override
  List<Object> get props => [
        singleBetSlipCard,
        parlayBetSlipCard,
        status,
      ];
}
