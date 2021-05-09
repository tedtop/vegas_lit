part of 'home_cubit.dart';

enum HomeStatus { initial, changed, user }

class HomeState extends Equatable {
  const HomeState._({
    this.status = HomeStatus.initial,
    this.pageIndex = 0,
    this.userData,
    this.userPurse,
  });

  const HomeState.initial() : this._();

  const HomeState.changed({
    @required int pageIndex,
    @required UserData userData,
    @required Purse userPurse,
  }) : this._(
          status: HomeStatus.changed,
          pageIndex: pageIndex,
          userData: userData,
          userPurse: userPurse,
        );
  const HomeState.openHome({
    @required int pageIndex,
    @required UserData userData,
    @required Purse userPurse,
  }) : this._(
          status: HomeStatus.user,
          pageIndex: pageIndex,
          userData: userData,
          userPurse: userPurse,
        );

  final HomeStatus status;
  final int pageIndex;
  final UserData userData;
  final Purse userPurse;

  @override
  List<Object> get props => [status, pageIndex, userData, userPurse];
}
