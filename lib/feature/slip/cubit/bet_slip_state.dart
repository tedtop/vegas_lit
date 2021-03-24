part of 'bet_slip_cubit.dart';

enum BetSlipStatus { loading, empty, opened, added, removed }

class BetSlipState {
  const BetSlipState._({
    this.games,
    this.status = BetSlipStatus.loading,
  });

  const BetSlipState.loading() : this._();

  const BetSlipState.opened({
    @required List<Widget> games,
  }) : this._(
          status: BetSlipStatus.opened,
          games: games,
        );

  // const BetSlipState.empty() : this._(status: BetSlipStatus.empty);

  // const BetSlipState.added() : this._(status: BetSlipStatus.added);

  // const BetSlipState.removed() : this._(status: BetSlipStatus.removed);

  final List<Widget> games;
  final BetSlipStatus status;
}
