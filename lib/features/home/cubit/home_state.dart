part of 'home_cubit.dart';

enum HomeStatus { initial, changed, user }

class HomeState extends Equatable {
  const HomeState._({
    this.status = HomeStatus.initial,
    this.pageIndex = 0,
    this.userData,
    this.userWallet,
    this.askReview = false,
  });

  const HomeState.initial() : this._();

  const HomeState.changed({
    @required int pageIndex,
    @required UserData userData,
    @required Wallet userWallet,
    @required bool askReview,
  }) : this._(
          status: HomeStatus.changed,
          pageIndex: pageIndex,
          userData: userData,
          userWallet: userWallet,
          askReview: askReview,
        );
  const HomeState.openHome({
    @required int pageIndex,
    @required UserData userData,
    @required Wallet userWallet,
    @required bool askReview,
  }) : this._(
          status: HomeStatus.user,
          pageIndex: pageIndex,
          userData: userData,
          userWallet: userWallet,
          askReview: askReview,
        );

  final HomeStatus status;
  final int pageIndex;
  final UserData userData;
  final Wallet userWallet;
  final bool askReview;

  @override
  List<Object> get props =>
      [status, pageIndex, userData, userWallet, askReview];
}
