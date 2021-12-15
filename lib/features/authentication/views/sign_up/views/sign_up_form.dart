import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/assets.dart';
import '../../../../../config/palette.dart';
import '../../../../../config/styles.dart';
import '../../../models/confirmed_password.dart';
import '../../../models/email.dart';
import '../../../models/password.dart';
import '../../../models/username.dart';
import '../../login/login.dart';
import '../sign_up.dart';

String? confirmedPasswordError(
    ConfirmedPasswordValidationError? validationError) {
  if (validationError == ConfirmedPasswordValidationError.invalid) {
    return 'Passwords do not match';
  } else if (validationError == ConfirmedPasswordValidationError.empty) {
    return 'Required';
  } else {
    return null;
  }
}

String? emailError(EmailValidationError? validationError) {
  if (validationError == EmailValidationError.invalid) {
    return 'Invalid email address';
  } else if (validationError == EmailValidationError.empty) {
    return 'Required';
  } else {
    return null;
  }
}

String? passwordError(PasswordValidationError? validationError) {
  if (validationError == PasswordValidationError.invalid) {
    return 'Must be a combination of at least 6 letters and numbers';
  } else if (validationError == PasswordValidationError.empty) {
    return 'Required';
  } else {
    return null;
  }
}

String? usernameError(UsernameValidationError? validationError) {
  if (validationError == UsernameValidationError.invalid) {
    return 'Invalid Format';
  } else if (validationError == UsernameValidationError.empty) {
    return 'Required';
  } else if (validationError == UsernameValidationError.exist) {
    return 'Username already exists';
  } else if (validationError == UsernameValidationError.characters) {
    return 'Username should be 3-10 chars';
  } else {
    return null;
  }
}

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.signUpErrorMessage!,
                ),
              ),
            );
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _TopLogo(),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                _ExistingAccountSignIn(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _UsernameInput(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _EmailInput(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _PasswordInput(),
                ),
                _ConfirmPasswordInput(),
                _StateInput(),
                const SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 4, bottom: 5),
                //   child: _MobileNumberInput(),
                // ),
                // _AgeCheck(),
                _AgreementCheck(),
                _SignUpButton(),
              ],
            ),
          ),
          // const SocialLoginList(
          //   authenticationType: AuthenticationType.signup,
          // ),
        ],
      ),
    );
  }
}

class _AgreementCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  fillColor: MaterialStateProperty.all(Palette.green),
                  value: state.agreementValue,
                  onChanged: (value) =>
                      context.read<SignUpCubit>().agreementClicked(value),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => context
                            .read<SignUpCubit>()
                            .agreementClicked(!state.agreementValue),
                        child: RichText(
                          text: TextSpan(
                            style: Styles.signUpAgreement,
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'I certify that I am at least 18 years of age and the use of this platform and service and participation in the contest is legal in the jurisdiction where I reside',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                ),
                              ),
                              // TextSpan(
                              //   text: 'here',
                              //   style: GoogleFonts.nunito(
                              //     fontSize: 14,
                              //     color: Palette.green,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  if (state.agreement.invalid)
                    Text(
                      'Required',
                      style: Styles.authFieldError.copyWith(color: Palette.red),
                    )
                  else
                    Container(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Verify Password',
                  style: Styles.signUpFieldDescription,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                style: Styles.signUpFieldText,
                key: const Key('signUpForm_confirmedPasswordInput_textField'),
                onChanged: (confirmPassword) => context
                    .read<SignUpCubit>()
                    .confirmedPasswordChanged(confirmPassword),
                obscureText: true,
                cursorColor: Palette.cream,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 2.5,
                    horizontal: 8,
                  ),
                  errorStyle: Styles.authFieldError,
                  hintStyle: Styles.signUpFieldHint,
                  border: Styles.signUpInputFieldBorder,
                  errorMaxLines: 3,
                  filled: true,
                  fillColor: Palette.lightGrey,
                  isDense: true,
                  hintText: 'Verify Password',
                  helperText: '',
                  errorText:
                      confirmedPasswordError(state.confirmedPassword.error),
                  focusedBorder: Styles.signUpInputFieldFocusedBorder,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Email Address',
                  style: Styles.signUpFieldDescription,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                cursorColor: Palette.cream,
                style: Styles.signUpFieldText,
                key: const Key('signUpForm_emailInput_textField'),
                onChanged: (email) =>
                    context.read<SignUpCubit>().emailChanged(email),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 2.5,
                    horizontal: 8,
                  ),
                  hintStyle: Styles.signUpFieldHint,
                  filled: true,
                  fillColor: Palette.lightGrey,
                  border: Styles.signUpInputFieldBorder,
                  errorStyle: Styles.authFieldError,
                  isDense: true,
                  hintText: 'Email Address',
                  helperText: '',
                  errorText: emailError(state.email.error),
                  focusedBorder: Styles.signUpInputFieldFocusedBorder,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ExistingAccountSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: Styles.authNormalText,
          ),
          TextButton(
            key: const Key('loginForm_createAccount_flatButton'),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Log In',
              style: Styles.authButtonText,
            ),
          ),
        ],
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Password',
                  style: Styles.signUpFieldDescription,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                style: Styles.signUpFieldText,
                key: const Key('signUpForm_passwordInput_textField'),
                onChanged: (password) =>
                    context.read<SignUpCubit>().passwordChanged(password),
                obscureText: true,
                cursorColor: Palette.cream,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 2.5,
                    horizontal: 8,
                  ),
                  errorStyle: Styles.authFieldError,
                  hintStyle: Styles.signUpFieldHint,
                  filled: true,
                  fillColor: Palette.lightGrey,
                  border: Styles.signUpInputFieldBorder,
                  isDense: true,
                  errorMaxLines: 3,
                  hintText: 'Password',
                  helperText: '',
                  errorText: passwordError(state.password.error),
                  focusedBorder: Styles.signUpInputFieldFocusedBorder,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// class _MobileNumberInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignUpCubit, SignUpState>(
//       buildWhen: (previous, current) => previous.number != current.number,
//       builder: (context, state) {
//         return Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 20),
//                 child:Text(
//                   'Mobile Number',
//                   style: GoogleFonts.nunito(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w200,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: TextField(
//                 autocorrect: false,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.digitsOnly,
//                   // MaskedInputFormater('(###) ###-####'),
//                 ],
//                 onChanged: (mobileNumber) =>
//                     context.read<SignUpCubit>().numberChanged(mobileNumber),
//                 style: GoogleFonts.nunito(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w300,
//                 ),
//                 key: const Key('signUpForm_mobileNumberInput_textField'),
//                 cursorColor: Palette.cream,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.symmetric(
//                     vertical: 2.5,
//                     horizontal: 8,
//                   ),
//                   hintStyle: GoogleFonts.nunito(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w300,
//                     color: Palette.cream,
//                   ),
//                   errorStyle: const TextStyle(
//                     fontSize: 10,
//                     // height: 0.3,
//                   ),
//                   filled: true,
//                   fillColor: Palette.lightGrey,
//                   border: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(4),
//                     ),
//                   ),
//                   isDense: true,
//                   hintText: 'Mobile Number',
//                   helperText: '',
//                   errorText: mobileNumberError(state.number.error),
//                   focusedBorder: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4)),
//                       borderSide: BorderSide(color: Palette.cream)),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// String mobileNumberError(PhoneNumberValidationError validationError) {
//   if (validationError == PhoneNumberValidationError.invalid) {
//     return 'Invalid mobile number';
//   } else if (validationError == PhoneNumberValidationError.empty) {
//     return 'Required';
//   } else {
//     return null;
//   }
// }

// class _AgeCheck extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignUpCubit, SignUpState>(
//       buildWhen: (previous, current) => previous.age != current.age,
//       builder: (context, state) {
//         return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Checkbox(
//                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   fillColor: MaterialStateProperty.all(Palette.green),
//                   value: state.age.value,
//                   onChanged: (value) =>
//                       context.read<SignUpCubit>().ageClicked(value),
//                 ),
//                 Column(
//                   children: [
//                    Text(
//                       'I am 18 years or older',
//                       style: GoogleFonts.nunito(
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   width: 40,
//                 ),
//                 state.age.invalid
//                     ?Text(
//                         'Required',
//                         style: GoogleFonts.nunito(
//                           color: Colors.red,
//                           fontSize: 10,
//                           // height: 0.3,
//                         ),
//                       )
//                     : Container(),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator(
                  color: Palette.cream,
                )
              : SizedBox(
                  width: 174,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                          ),
                          elevation:
                              MaterialStateProperty.all(Styles.normalElevation),
                          shape: MaterialStateProperty.all(Styles.smallRadius),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(color: Palette.cream),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Palette.green),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      child: Text(
                        'SIGN UP',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        context.read<SignUpCubit>().signUpFormSubmitted();
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class _StateInput extends StatelessWidget {
  final stateList = [
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
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.americanState != current.americanState,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Text(
                'State',
                style: Styles.signUpFieldDescription,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  DropDown(
                    isExpanded: true,
                    showUnderline: true,
                    items: stateList,
                    hint: Text(
                      'State',
                      style: GoogleFonts.nunito(),
                    ),
                    onChanged: (String value) =>
                        context.read<SignUpCubit>().americanStateChanged(value),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      if (state.americanState.invalid)
                        Text(
                          'Required',
                          style: Styles.authFieldError
                              .copyWith(color: Palette.red),
                        )
                      else
                        Container(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TopLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'top_logo',
      child: Image.asset(
        Images.topLogo,
        height: 80,
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Username',
                  style: Styles.signUpFieldDescription,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                cursorColor: Palette.cream,
                style: Styles.signUpFieldText,
                key: const Key('signUpForm_usernameInput_textField'),
                onChanged: (username) =>
                    context.read<SignUpCubit>().usernameChanged(username),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 2.5,
                    horizontal: 8,
                  ),
                  hintStyle: Styles.signUpFieldHint,
                  errorStyle: Styles.authFieldError,
                  filled: true,
                  fillColor: Palette.lightGrey,
                  border: Styles.signUpInputFieldBorder,
                  isDense: true,
                  hintText: 'Username',
                  helperText: '',
                  errorText: usernameError(state.username.error),
                  focusedBorder: Styles.signUpInputFieldFocusedBorder,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DropDown<T> extends StatefulWidget {
  const DropDown({
    required this.items,
    this.customWidgets,
    this.initialValue,
    this.hint,
    this.onChanged,
    this.isExpanded = false,
    this.isCleared = false,
    this.showUnderline = true,
  })  : assert(items != null && items is! Widget),
        assert((customWidgets != null)
            ? items.length == customWidgets.length
            : (customWidgets == null));

  final List<T> items;
  final List<Widget>? customWidgets;
  final T? initialValue;
  final Widget? hint;
  final Function? onChanged;
  final bool isExpanded;
  final bool isCleared;
  final bool showUnderline;

  @override
  _DropDownState createState() => _DropDownState<T>();
}

class _DropDownState<T> extends State<DropDown<T>> {
  T? selectedValue;

  @override
  void initState() {
    selectedValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dropdown = DropdownButton<T>(
      isExpanded: widget.isExpanded,
      onChanged: (T? value) {
        setState(() => selectedValue = value);
        if (widget.onChanged != null) widget.onChanged!(value);
      },
      value: widget.isCleared ? null : selectedValue,
      items: widget.items.map<DropdownMenuItem<T>>(buildDropDownItem).toList(),
      hint: widget.hint,
    );

    return widget.showUnderline
        ? dropdown
        : DropdownButtonHideUnderline(child: dropdown);
  }

  DropdownMenuItem<T> buildDropDownItem(T item) => DropdownMenuItem<T>(
        value: item,
        child: (widget.customWidgets != null)
            ? widget.customWidgets![widget.items.indexOf(item)]
            : Text(
                item.toString(),
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                ),
              ),
      );
}
