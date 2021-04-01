import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:vegas_lit/authentication/models/username.dart';

import '../../../authentication.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
          state.username,
          state.americanState,
          state.number,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        // confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          password,
          state.confirmedPassword,
          state.username,
          state.americanState,
          state.number,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          state.password,
          confirmedPassword,
          state.username,
          state.americanState,
          state.number,
        ]),
      ),
    );
  }

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([
          state.email,
          state.password,
          state.confirmedPassword,
          username,
          state.americanState,
          state.number,
        ]),
      ),
    );
  }

  void numberChanged(String value) {
    final phoneNumber = PhoneNumber.dirty(value);
    emit(
      state.copyWith(
        number: phoneNumber,
        status: Formz.validate([
          state.email,
          state.password,
          state.confirmedPassword,
          state.username,
          state.americanState,
          phoneNumber,
        ]),
      ),
    );
  }

  void americanStateChanged(String value) {
    final americanState = AmericanState.dirty(value);
    emit(
      state.copyWith(
        americanState: americanState,
        status: Formz.validate([
          state.email,
          state.password,
          state.confirmedPassword,
          state.username,
          americanState,
          state.number,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
