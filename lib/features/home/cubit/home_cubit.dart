import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/user.dart';
import '../../../data/models/wallet.dart';
import '../../../data/repositories/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(
          const HomeState.initial(),
        );

  final UserRepository _userRepository;
  StreamSubscription _homeDataSubscription;

  Future<void> openHome({@required String uid}) async {
    final userStream = _userRepository.fetchUserData(uid: uid);
    final walletStream = _userRepository.fetchWalletData(uid: uid);
    await _homeDataSubscription?.cancel();
    _homeDataSubscription = Rx.combineLatest2(
      userStream,
      walletStream,
      (UserData userData, Wallet userWallet) {
        emit(
          HomeState.openHome(
            pageIndex: state.pageIndex,
            userData: userData,
            userWallet: userWallet,
          ),
        );
      },
    ).listen(
      // ignore: avoid_print
      print,
    );
  }

  void homeChange(int pageIndex) {
    emit(
      HomeState.changed(
        pageIndex: pageIndex,
        userData: state.userData,
        userWallet: state.userWallet,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _homeDataSubscription?.cancel();
    return super.close();
  }
}
