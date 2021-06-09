import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import '../../../../../data/models/user.dart';
import '../../../../../data/providers/firebase_auth.dart';
import '../../../../../data/repositories/user_repository.dart';
import '../../../authentication.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    @required UserRepository userRepository,
    @required AuthenticationBloc authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        _authenticationBloc = authenticationBloc,
        _userRepository = userRepository,
        super(const SignUpState());
  final UserRepository _userRepository;
  final AuthenticationBloc _authenticationBloc;

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
          agreement,
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
          state.agreement,
          state.username,
        ]),
      ),
    );
  }

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
          state.agreement,
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
          state.agreement,
          state.username,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    final isUsernameExist =
        await _userRepository.isUsernameExist(username: state.usernameValue);
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

    final americanState = AmericanState.dirty(state.americanStateValue);

    emit(
      state.copyWith(
        email: email,
        agreement: agreement,
        password: password,
        confirmedPassword: confirmedPassword,
        username: username,
        americanState: americanState,
        status: Formz.validate(
          [
            email,
            password,
            confirmedPassword,
            americanState,
            agreement,
            username,
          ],
        ),
      ),
    );

    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await _userRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      final currentUser = await _userRepository.getCurrentUser();
      await _userRepository.saveUserDetails(
        uid: currentUser.uid,
        userData: UserData(
          location: state.americanState.value,
          email: state.email.value,
          uid: currentUser.uid,
          username: state.username.value,
        ),
      );
      _authenticationBloc.add(CheckProfileComplete(currentUser));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpFailure catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          signUpErrorMessage: e.errorMessage,
        ),
      );
    }
  }

  Future<void> usernameChanged(String value) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    final isUsernameExist =
        await _userRepository.isUsernameExist(username: value);
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
          state.agreement,
          username,
        ]),
      ),
    );
  }
}
