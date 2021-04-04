import 'package:formz/formz.dart';

enum PhoneNumberValidationError { invalid }

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneRegExp = RegExp(r'\d');

  @override
  PhoneNumberValidationError validator(String value) {
    return value.length == 14 && _phoneRegExp.hasMatch(value) || value.isEmpty
        ? null
        : PhoneNumberValidationError.invalid;
  }
}
