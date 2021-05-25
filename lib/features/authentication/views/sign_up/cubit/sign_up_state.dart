part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.americanState = const AmericanState.pure(),
    this.number = const PhoneNumber.pure(),
    this.agreement = const Agreement.pure(),
    this.username = const Username.pure(),
    this.emailValue = '',
    this.passwordValue = '',
    this.confirmedPasswordValue = '',
    this.usernameValue = '',
    this.americanStateValue = '',
    this.numberValue = '',
    this.agreementValue = false,
  });

  final Email email;
  final String emailValue;
  final Password password;
  final String passwordValue;
  final ConfirmedPassword confirmedPassword;
  final String confirmedPasswordValue;
  final Username username;
  final String usernameValue;
  final AmericanState americanState;
  final String americanStateValue;
  final PhoneNumber number;
  final String numberValue;
  final Agreement agreement;
  final bool agreementValue;

  final FormzStatus status;

  @override
  List<Object> get props => [
        emailValue,
        passwordValue,
        confirmedPasswordValue,
        usernameValue,
        americanStateValue,
        numberValue,
        agreementValue,
        email,
        password,
        agreement,
        confirmedPassword,
        status,
        americanState,
        number,
        username
      ];

  SignUpState copyWith({
    Email email,
    String emailValue,
    Password password,
    String passwordValue,
    ConfirmedPassword confirmedPassword,
    String confirmedPasswordValue,
    Username username,
    String usernameValue,
    AmericanState americanState,
    String americanStateValue,
    PhoneNumber number,
    String numberValue,
    Agreement agreement,
    bool agreementValue,
    FormzStatus status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      emailValue: emailValue ?? this.emailValue,
      password: password ?? this.password,
      passwordValue: passwordValue ?? this.passwordValue,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      confirmedPasswordValue:
          confirmedPasswordValue ?? this.confirmedPasswordValue,
      username: username ?? this.username,
      usernameValue: usernameValue ?? this.usernameValue,
      americanState: americanState ?? this.americanState,
      americanStateValue: americanStateValue ?? this.americanStateValue,
      number: number ?? this.number,
      numberValue: numberValue ?? this.numberValue,
      agreement: agreement ?? this.agreement,
      agreementValue: agreementValue ?? this.agreementValue,
      status: status ?? this.status,
    );
  }
}
