part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.americanState = const AmericanState.pure(),
    this.number = const PhoneNumber.pure(),
    this.username = const Username.pure(),
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final Username username;
  final AmericanState americanState;
  final PhoneNumber number;
  final FormzStatus status;

  @override
  List<Object> get props => [
        email,
        password,
        confirmedPassword,
        status,
        americanState,
        number,
        username
      ];

  SignUpState copyWith({
    Email email,
    Password password,
    ConfirmedPassword confirmedPassword,
    FormzStatus status,
    Username username,
    AmericanState americanState,
    PhoneNumber number,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      username: username ?? this.username,
      number: number ?? this.number,
      americanState: americanState ?? this.americanState,
    );
  }
}
