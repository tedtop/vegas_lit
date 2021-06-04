import 'package:formz/formz.dart';
import 'package:regexpattern/regexpattern.dart';

enum UsernameValidationError { invalid, empty, exist, characters }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure({this.externalError}) : super.pure('username12');
  const Username.dirty(this.externalError, [String value = ''])
      : super.dirty(value);

  // static final RegExp _usernameRegExp =
  //     RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]');

  final UsernameValidationError externalError;

  @override
  UsernameValidationError validator(String value) {
    if (externalError != null) {
      return externalError;
    } else if (value.isUsername()) {
      return null;
    } else if (value.length >= 10 && value.length <= 3) {
      return UsernameValidationError.characters;
    } else if (value.isEmpty) {
      return UsernameValidationError.empty;
    } else {
      return UsernameValidationError.invalid;
    }
  }
}
