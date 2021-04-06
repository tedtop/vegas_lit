import 'package:formz/formz.dart';

enum AgeValidationError { invalid }

class Age extends FormzInput<bool, AgeValidationError> {
  const Age.pure() : super.pure(false);
  const Age.dirty([bool value = false]) : super.dirty(value);

  @override
  AgeValidationError validator(bool value) {
    return value == true ? null : AgeValidationError.invalid;
  }
}
