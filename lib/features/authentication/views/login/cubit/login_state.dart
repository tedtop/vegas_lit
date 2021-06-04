part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.emailValue = '',
    this.passwordValue = '',
    this.loginErrorMessage,
  });

  final Email email;
  final String emailValue;
  final Password password;
  final String passwordValue;
  final FormzStatus status;
  final String loginErrorMessage;

  @override
  List<Object> get props => [
        email,
        password,
        status,
        emailValue,
        passwordValue,
        loginErrorMessage,
      ];

  LoginState copyWith({
    Email email,
    String emailValue,
    Password password,
    String passwordValue,
    FormzStatus status,
    String loginErrorMessage,
  }) {
    return LoginState(
      emailValue: emailValue ?? this.emailValue,
      passwordValue: passwordValue ?? this.passwordValue,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
    );
  }
}
