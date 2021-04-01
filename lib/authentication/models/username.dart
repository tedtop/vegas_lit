import 'package:formz/formz.dart';

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  Username.dirty(String value) : super.dirty(value);
  const Username.pure() : super.pure('');

  @override
  UsernameValidationError validator(String value) {
    return value.length == 10 ? null : UsernameValidationError.invalid;
  }
}
