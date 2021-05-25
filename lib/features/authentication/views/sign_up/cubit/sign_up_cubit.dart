import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:vegas_lit/data/models/user.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';

import '../../../authentication.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(const SignUpState());

  final UserRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        emailValue: value,
        status: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
          state.americanState,
          state.number,
          state.agreement,
          state.username,
        ]),
      ),
    );
  }

  void agreementClicked(bool value) {
    final agreement = Agreement.dirty(value);
    emit(
      state.copyWith(
        agreementValue: value,
        status: Formz.validate([
          state.email,
          state.password,
          state.confirmedPassword,
          state.americanState,
          state.number,
          agreement,
          state.username,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        passwordValue: value,
        status: Formz.validate([
          state.email,
          password,
          state.confirmedPassword,
          state.americanState,
          state.number,
          state.agreement,
          state.username,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.passwordValue,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPasswordValue: value,
        status: Formz.validate([
          state.email,
          state.password,
          confirmedPassword,
          state.americanState,
          state.number,
          state.agreement,
          state.username,
        ]),
      ),
    );
  }

  Future<void> usernameChanged(String value) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    final isUsernameExist =
        await _authenticationRepository.isUsernameExist(username: value);
    final usernameValidationError =
        isUsernameExist ? UsernameValidationError.exist : null;
    final username = Username.dirty(usernameValidationError, value);
    emit(
      state.copyWith(
        usernameValue: value,
        username: username,
        status: Formz.validate([
          state.email,
          state.password,
          state.confirmedPassword,
          state.americanState,
          state.number,
          state.agreement,
          username,
        ]),
      ),
    );
  }

  void numberChanged(String value) {
    final number = PhoneNumber.dirty(value);
    emit(
      state.copyWith(
        numberValue: value,
        status: Formz.validate([
          state.email,
          state.password,
          state.confirmedPassword,
          state.americanState,
          number,
          state.agreement,
          state.username,
        ]),
      ),
    );
  }

  void americanStateChanged(String value) {
    final americanState = AmericanState.dirty(value);
    emit(
      state.copyWith(
        americanStateValue: value,
        status: Formz.validate([
          state.email,
          state.password,
          state.confirmedPassword,
          americanState,
          state.number,
          state.agreement,
          state.username,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    final isUsernameExist = await _authenticationRepository.isUsernameExist(
        username: state.usernameValue);
    final usernameValidationError =
        isUsernameExist ? UsernameValidationError.exist : null;
    final email = Email.dirty(state.emailValue);
    final agreement = Agreement.dirty(state.agreementValue);
    final password = Password.dirty(state.passwordValue);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.passwordValue,
      value: state.confirmedPasswordValue,
    );
    final username =
        Username.dirty(usernameValidationError, state.usernameValue);
    final number = PhoneNumber.dirty(state.numberValue);
    final americanState = AmericanState.dirty(state.americanStateValue);

    emit(
      state.copyWith(
        email: email,
        agreement: agreement,
        password: password,
        confirmedPassword: confirmedPassword,
        username: username,
        number: number,
        americanState: americanState,
        status: Formz.validate(
          [
            email,
            password,
            confirmedPassword,
            americanState,
            number,
            agreement,
            username,
          ],
        ),
      ),
    );

    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      final currentUser = await _authenticationRepository.getCurrentUser();
      await _authenticationRepository.saveUserDetails(
        uid: currentUser.uid,
        userDataMap: UserData(
          location: state.americanState.value,
          email: state.email.value,
          phone: int.parse(state.number.value),
          uid: currentUser.uid,
          username: state.username.value,
        ).toMap(),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
