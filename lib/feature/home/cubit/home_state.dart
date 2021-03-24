part of 'home_cubit.dart';

enum HomeStatus { initial, changed }

class HomeState extends Equatable {
  const HomeState._({
    this.status = HomeStatus.initial,
    this.pageIndex = 0,
  });

  const HomeState.initial() : this._();

  const HomeState.changed({int pageIndex})
      : this._(
          status: HomeStatus.changed,
          pageIndex: pageIndex,
        );

  final HomeStatus status;
  final int pageIndex;

  @override
  List<Object> get props => [status, pageIndex];
}
