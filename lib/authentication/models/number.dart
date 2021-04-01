import 'package:formz/formz.dart';

enum NumberValidationError { invalid }

class Number extends FormzInput<String, NumberValidationError> {
  Number.dirty(String value) : super.dirty(value);
  const Number.pure() : super.pure('');

  @override
  NumberValidationError validator(String value) {
    return value.length == 10 ? null : NumberValidationError.invalid;
  }
}
