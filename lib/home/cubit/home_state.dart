part of 'home_cubit.dart';

enum HomeStatus { initial, changed, balanceChanged }

class HomeState extends Equatable {
  const HomeState._({
    this.status = HomeStatus.initial,
    this.pageIndex = 0,
    this.balanceAmount = 500,
  });

  const HomeState.initial() : this._();

  const HomeState.changed({
    int pageIndex,
    int balanceAmount,
  }) : this._(
          status: HomeStatus.changed,
          pageIndex: pageIndex,
          balanceAmount: balanceAmount,
        );
  const HomeState.balanceChanged({
    int pageIndex,
    int balanceAmount,
  }) : this._(
          status: HomeStatus.balanceChanged,
          pageIndex: pageIndex,
          balanceAmount: balanceAmount,
        );

  final HomeStatus status;
  final int pageIndex;
  final int balanceAmount;

  @override
  List<Object> get props => [status, pageIndex, balanceAmount];
}
