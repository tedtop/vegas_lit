import 'package:formz/formz.dart';

enum AmericanStateValidationError { invalid }

class AmericanState extends FormzInput<String, AmericanStateValidationError> {
  const AmericanState.pure() : super.pure('');
  const AmericanState.dirty([String value = '']) : super.dirty(value);

  static final List<String> stateList = [
    'International',
    'Alabama',
    'Alaska',
    // 'Arizona',
    // 'Arkansas',
    'California',
    'Colorado',
    // 'Connecticut',
    // 'Delaware',
    'District Of Columbia',
    'Florida',
    'Georgia',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    // 'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    // 'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    // 'South Carolina',
    // 'South Dakota',
    // 'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    // 'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming'
  ];

  @override
  AmericanStateValidationError? validator(String value) {
    return stateList.contains(value)
        ? null
        : AmericanStateValidationError.invalid;
  }
}
