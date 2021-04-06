import 'package:formz/formz.dart';

enum UsernameValidationError { invalid, empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('username');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError validator(String value) {
    if (value.length < 16 && value.length > 3) {
      return null;
    } else if (value.isEmpty) {
      return UsernameValidationError.empty;
    } else {
      return UsernameValidationError.invalid;
    }
  }
}
