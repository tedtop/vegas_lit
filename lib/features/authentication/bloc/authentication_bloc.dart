import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

import '../../../data/models/user.dart';
import '../../../data/repositories/device_repository.dart';
import '../../../data/repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {@required UserRepository userRepository,
      @required DeviceRepository deviceRepository})
      : assert(userRepository != null),
        assert(deviceRepository != null),
        _userRepository = userRepository,
        _deviceRepository = deviceRepository,
        super(
          const AuthenticationState.splashscreen(),
        ) {
    _userSubscription = _userRepository.getUser.listen(
      (user) => add(
        AuthenticationUserChanged(user),
      ),
    );
  }

  final UserRepository _userRepository;
  final DeviceRepository _deviceRepository;
  StreamSubscription<User> _userSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChanged) {
      if (event.user != null) {
        add(
          CheckProfileComplete(event.user),
        );
      } else {
        _userSubscription?.pause();
        final isFirstTime = await _deviceRepository.isFirstTime();

        if (isFirstTime) {
          yield const AuthenticationState.firstOpen();
        } else {
          yield const AuthenticationState.unauthenticated();
        }
      }
    } else if (event is CheckProfileComplete) {
      yield* _checkProfileComplete(event);
    } else if (event is AuthenticationLogoutRequested) {
      unawaited(
        _userRepository.signOutUser(),
      );
    } else if (event is AuthenticationEmailVerification) {
      yield const AuthenticationState.verification();
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Stream<AuthenticationState> _checkProfileComplete(
      CheckProfileComplete event) async* {
    yield const AuthenticationState.splashscreen();
    _userSubscription?.resume();
    // final isUserExist =
    //     await _userRepository.isProfileComplete(uid: event.user.uid);
    // if (isUserExist) {
    yield AuthenticationState.authenticated(event.user);
    // }
  }
}
