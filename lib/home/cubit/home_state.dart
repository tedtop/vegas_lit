part of 'home_cubit.dart';

enum HomeStatus { initial, changed, user }

class HomeState extends Equatable {
  const HomeState._({
    this.status = HomeStatus.initial,
    this.pageIndex = 0,
    this.userData,
  });

  const HomeState.initial() : this._();

  const HomeState.changed({
    int pageIndex,
    UserData userData,
  }) : this._(
          status: HomeStatus.changed,
          pageIndex: pageIndex,
          userData: userData,
        );
  const HomeState.openHome({
    int pageIndex,
    UserData userData,
  }) : this._(
          status: HomeStatus.user,
          pageIndex: pageIndex,
          userData: userData,
        );

  final HomeStatus status;
  final int pageIndex;
  final UserData userData;

  @override
  List<Object> get props => [status, pageIndex, userData];
}
