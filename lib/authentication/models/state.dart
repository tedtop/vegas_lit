import 'package:formz/formz.dart';

enum AmericanStateValidationError { invalid }

class AmericanState extends FormzInput<String, AmericanStateValidationError> {
  const AmericanState.pure() : super.pure('');
  const AmericanState.dirty([String value = '']) : super.dirty(value);

  static final List<String> _americanStates = ['Ted'];

  @override
  AmericanStateValidationError validator(String value) {
    return null;
  }
}
