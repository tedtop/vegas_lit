import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../../data/providers/firebase_auth.dart';
import '../../../../../data/repositories/user_repository.dart';
import '../../../authentication.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required UserRepository userRepository,
    required AuthenticationCubit authenticationBloc,
  })  : _authenticationBloc = authenticationBloc,
        _userRepository = userRepository,
        super(const LoginState());

  final UserRepository _userRepository;
  final AuthenticationCubit _authenticationBloc;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      emailValue: value,
      status: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      passwordValue: value,
      status: Formz.validate([state.email, password]),
    ));
  }

  Future<void> logInWithCredentials() async {
    final email = Email.dirty(state.emailValue);
    final password = Password.dirty(state.passwordValue);

    emit(
      state.copyWith(
        email: email,
        password: password,
        status: Formz.validate(
          [
            email,
            password,
          ],
        ),
      ),
    );

    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _userRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      final currentUser = await _userRepository.getCurrentUser();
      await _authenticationBloc.onUserChanged(user: currentUser);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
            status: FormzStatus.submissionFailure,
            loginErrorMessage: e.errorMessage),
      );
    }
  }

  Future<void> resetPassword({required String email}) async {
    await _userRepository.resetPasswordEmail(email: email);
  }
}
