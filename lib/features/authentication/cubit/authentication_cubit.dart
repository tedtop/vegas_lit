import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(
          const AuthenticationState.initial(),
        ) {
    _userSubscription = _userRepository.getUser.listen(
      (user) async {
        await checkProfileComplete(user: user);
      },
    );
  }

  final UserRepository _userRepository;
  StreamSubscription<User?>? _userSubscription;

  Future<void> checkProfileComplete({required User? user}) async {
    if (user != null) {
      emit(
        const AuthenticationState.loading(),
      );
      _userSubscription?.resume();
      final isUserDataExist =
          await _userRepository.isProfileComplete(uid: user.uid);
      isUserDataExist
          ? emit(AuthenticationState.success(user))
          : emit(const AuthenticationState.failure());
    } else {
      _userSubscription?.pause();
      emit(const AuthenticationState.failure());
    }
  }

  Future<void> authenticationLogOut() async {
    unawaited(
      _userRepository.signOutUser(),
    );
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
