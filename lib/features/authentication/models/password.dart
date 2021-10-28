import 'package:formz/formz.dart';

enum PasswordValidationError { invalid, empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('testing123');
  const Password.dirty([String value = '']) : super.dirty(value);

  // static final _passwordRegExp =
  //     RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    if (value.length > 6) {
      return null;
    } else if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else {
      return PasswordValidationError.invalid;
    }
  }
}
