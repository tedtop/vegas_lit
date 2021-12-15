part of 'bet_slip_cubit.dart';

enum BetSlipStatus { loading, opened }

class BetSlipState extends Equatable {
  const BetSlipState._({
    this.singleBetSlipCard = const [],
    this.parlayBetSlipCard = const [],
    this.betDataList = const [],
    this.status = BetSlipStatus.loading,
  });

  const BetSlipState.loading() : this._();

  const BetSlipState.opened({
    required List<Widget> singleBetSlipCard,
    required List<Widget> parlayBetSlipCard,
    required List<BetData> betDataList,
  }) : this._(
          status: BetSlipStatus.opened,
          singleBetSlipCard: singleBetSlipCard,
          parlayBetSlipCard: parlayBetSlipCard,
          betDataList: betDataList,
        );

  final List<Widget>? singleBetSlipCard;
  final List<Widget>? parlayBetSlipCard;
  final List<BetData>? betDataList;
  final BetSlipStatus status;

  @override
  List<Object?> get props => [
        singleBetSlipCard,
        parlayBetSlipCard,
        betDataList,
        status,
      ];
}
