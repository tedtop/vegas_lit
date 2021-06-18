import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/user_repository.dart';

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

  void changeUsername({
    @required String username,
  }) {
    final editedUserData = state.userData.copyWith(username: username);
    emit(
      ProfileState.opened(userData: editedUserData),
    );
  }

  void changeEmail({
    @required String email,
  }) {
    final editedUserData = state.userData.copyWith(email: email);
    emit(
      ProfileState.opened(userData: editedUserData),
    );
  }

  void changeLocation({
    @required String location,
  }) {
    final editedUserData = state.userData.copyWith(location: location);
    emit(
      ProfileState.opened(userData: editedUserData),
    );
  }

  Future<void> updateProfile(
      {@required String currentUserId, @required UserData user}) async {
    emit(
      const ProfileState.loading(),
    );
    // print(state.userData);
    await _userRepository.updateUserDetails(user: user, uid: currentUserId);
  }

  @override
  Future<void> close() async {
    await _userDataSubscription?.cancel();
    return super.close();
  }
}
