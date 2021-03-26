part of 'open_bets_cubit.dart';

enum OpenBetsStatus { initial, opened, updated }

class OpenBetsState extends Equatable {
  const OpenBetsState._({
    this.status = OpenBetsStatus.initial,
    this.openBetsDataList,
  });

  const OpenBetsState.initial() : this._();

  const OpenBetsState.opened({@required List<OpenBetsData> openBetsDataList})
      : this._(
          status: OpenBetsStatus.opened,
          openBetsDataList: openBetsDataList,
        );

  final OpenBetsStatus status;
  final List<OpenBetsData> openBetsDataList;

  @override
  List<Object> get props => [status, openBetsDataList];
}