part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.username,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final Username username;
  final FormzStatus status;

  @override
  List<Object> get props => [email, password, confirmedPassword, status];

  SignUpState copyWith({
    Email email,
    Password password,
    ConfirmedPassword confirmedPassword,
    FormzStatus status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
    );
  }
}
