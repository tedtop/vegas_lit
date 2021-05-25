import 'package:formz/formz.dart';

enum AgreementValidationError { invalid }

class Agreement extends FormzInput<bool, AgreementValidationError> {
  const Agreement.pure() : super.pure(false);
  const Agreement.dirty([bool value = false]) : super.dirty(value);

  @override
  AgreementValidationError validator(bool value) {
    return value == true ? null : AgreementValidationError.invalid;
  }
}
