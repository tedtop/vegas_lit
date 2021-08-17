import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vegas_lit/data/repositories/device_repository.dart';

import '../../../data/models/user.dart';
import '../../../data/models/wallet.dart';
import '../../../data/repositories/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
      {@required UserRepository userRepository,
      @required DeviceRepository deviceRepository})
      : assert(userRepository != null),
        assert(deviceRepository != null),
        _deviceRepository = deviceRepository,
        _userRepository = userRepository,
        super(
          const HomeState.initial(),
        );

  final UserRepository _userRepository;
  final DeviceRepository _deviceRepository;
  StreamSubscription _homeDataSubscription;

  Future<void> openHome({@required String uid}) async {
    
    final userStream = _userRepository.fetchUserData(uid: uid);
    final walletStream = _userRepository.fetchWalletData(uid: uid);
    await _homeDataSubscription?.cancel();
    _homeDataSubscription = Rx.combineLatest2(
      userStream,
      walletStream,
      (UserData userData, Wallet userWallet) async {
        var askReview = false;
        if (userWallet.totalBets > 25) {
          final shouldAskReview = await _deviceRepository.shouldAskReview();
          if (shouldAskReview) {
            askReview = true;
          }
        }
        emit(
          HomeState.openHome(
            pageIndex: state.pageIndex,
            userData: userData,
            askReview: askReview,
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
        askReview: state.askReview,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _homeDataSubscription?.cancel();
    return super.close();
  }
}
