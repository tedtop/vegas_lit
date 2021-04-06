import 'package:formz/formz.dart';

enum PhoneNumberValidationError { invalid, empty }

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('8839261479');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneNumberValidationError validator(String value) {
    if (value.length == 10) {
      return null;
    } else if (value.isEmpty) {
      return PhoneNumberValidationError.empty;
    } else {
      return PhoneNumberValidationError.invalid;
    }
  }
}
