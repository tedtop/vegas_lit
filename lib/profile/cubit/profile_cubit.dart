import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(
          const ProfileState.loading(),
        );

  final UserRepository _userRepository;
  StreamSubscription _userDataSubscription;

  Future<void> openProfile({
    @required String currentUserId,
  }) async {
    final userDataStream = _userRepository.fetchUserData(
      currentUserId: currentUserId,
    );
    await _userDataSubscription?.cancel();
    _userDataSubscription = userDataStream.listen(
      (event) {
        emit(
          ProfileState.opened(userData: event),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _userDataSubscription?.cancel();
    return super.close();
  }
}
