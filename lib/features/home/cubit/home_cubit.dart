import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rxdart/rxdart.dart';

import '../../../data/models/user.dart';
import '../../../data/models/wallet.dart';
import '../../../data/repositories/device_repository.dart';
import '../../../data/repositories/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
      {required UserRepository userRepository,
      required DeviceRepository deviceRepository})
      : _deviceRepository = deviceRepository,
        _userRepository = userRepository,
        super(
          const HomeState.initial(),
        );

  final UserRepository _userRepository;
  final DeviceRepository _deviceRepository;
  StreamSubscription? _homeDataSubscription;

  Future<void> openHome({required String uid}) async {
    final userStream = _userRepository.fetchUserData(uid: uid);
    final walletStream = _userRepository.fetchWalletData(uid: uid);
    await _homeDataSubscription?.cancel();
    _homeDataSubscription = Rx.combineLatest2(
      userStream,
      walletStream,
      (UserData userData, Wallet userWallet) async {
        var askReview = false;
        if (userWallet.totalBets! > 25) {
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
