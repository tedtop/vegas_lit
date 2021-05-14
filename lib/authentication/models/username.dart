import 'package:formz/formz.dart';

enum UsernameValidationError { invalid, empty, exist }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure({this.externalError}) : super.pure('username');
  const Username.dirty(this.externalError, [String value = ''])
      : super.dirty(value);

  final UsernameValidationError externalError;

  @override
  UsernameValidationError validator(String value) {
    if (externalError != null) {
      return externalError;
    } else if (value.length <= 15 && value.length >= 5) {
      return null;
    } else if (value.isEmpty) {
      return UsernameValidationError.empty;
    } else {
      return UsernameValidationError.invalid;
    }
  }
}
