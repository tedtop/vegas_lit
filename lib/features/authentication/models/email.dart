import 'package:formz/formz.dart';

enum EmailValidationError { invalid, empty }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('shaan.xaz@gmail.com');
  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    if (_emailRegExp.hasMatch(value)) {
      return null;
    } else if (value.isEmpty) {
      return EmailValidationError.empty;
    } else {
      return EmailValidationError.invalid;
    }
  }
}
