import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
    final purseStream = _userRepository.fetchPurseData(uid: uid);
    await _homeDataSubscription?.cancel();
    _homeDataSubscription = Rx.combineLatest2(
      userStream,
      purseStream,
      (UserData userData, Purse userPurse) {
        emit(
          HomeState.openHome(
            pageIndex: state.pageIndex,
            userData: userData,
            userPurse: userPurse,
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
        userPurse: state.userPurse,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _homeDataSubscription?.cancel();
    return super.close();
  }
}
