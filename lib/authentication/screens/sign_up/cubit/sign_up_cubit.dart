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
        confirmedPassword: confirmedPassword,
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

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        usernameValue: value,
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
    final email = Email.dirty(state.emailValue);
    final agreement = Agreement.dirty(state.agreementValue);
    final password = Password.dirty(state.passwordValue);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.passwordValue,
      value: state.confirmedPasswordValue,
    );
    final username = Username.dirty(state.usernameValue);
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
          accountBalance: 500,
          biggestWin: 0,
          correctBets: 0,
          lastWeeksRank: 0,
          numberBets: 0,
          openBets: 0,
          potentialWinnings: 0,
          profit: 0,
          rank: 0,
        ).toMap(),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
