import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/user.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';

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
      uid: currentUserId,
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
