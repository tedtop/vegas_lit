import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

enum ConfirmedPasswordValidationError { invalid, empty }

class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  const ConfirmedPassword.pure({this.password = 'testing123'})
      : super.pure('testing123');
  const ConfirmedPassword.dirty({@required this.password, String value = ''})
      : super.dirty(value);

  final String password;

  @override
  ConfirmedPasswordValidationError validator(String value) {
    if (password == value) {
      return null;
    } else if (value.isEmpty) {
      return ConfirmedPasswordValidationError.empty;
    } else {
      return ConfirmedPasswordValidationError.invalid;
    }
  }
}
