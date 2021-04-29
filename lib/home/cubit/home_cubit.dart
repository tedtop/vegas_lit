import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
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
  StreamSubscription _userDataSubscription;

  Future<void> openHome({@required String uid}) async {
    final userStream = _userRepository.fetchUserData(uid: uid);
    await _userDataSubscription?.cancel();
    _userDataSubscription = userStream.listen(
      (event) {
        emit(
          HomeState.openHome(
            pageIndex: state.pageIndex,
            userData: event,
          ),
        );
      },
    );
  }

  void homeChange(int pageIndex) {
    emit(
      HomeState.changed(
        pageIndex: pageIndex,
        userData: state.userData,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _userDataSubscription?.cancel();
    return super.close();
  }
}
