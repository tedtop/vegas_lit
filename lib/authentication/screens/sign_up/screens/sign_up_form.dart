import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/authentication/authentication.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/shared_widgets/auth_logo.dart';
import 'package:vegas_lit/shared_widgets/default_button.dart';
import 'package:vegas_lit/shared_widgets/dropdown.dart';

import '../sign_up.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'Registration Error',
                ),
              ),
            );
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TopLogo(),
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
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 5),
                  child: _MobileNumberInput(),
                ),
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
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                cursorColor: Palette.cream,
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                key: const Key('signUpForm_usernameInput_textField'),
                onChanged: (username) =>
                    context.read<SignUpCubit>().usernameChanged(username),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 2.5,
                    horizontal: 8,
                  ),
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Palette.cream,
                  ),
                  errorStyle: const TextStyle(
                    fontSize: 10,
                    // height: 0.3,
                  ),
                  filled: true,
                  fillColor: Palette.lightGrey,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  isDense: true,
                  hintText: 'Username',
                  helperText: '',
                  errorText: usernameError(state.username.error),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

String usernameError(UsernameValidationError validationError) {
  if (validationError == UsernameValidationError.invalid) {
    return 'Username should be 5-15 chars';
  } else if (validationError == UsernameValidationError.empty) {
    return 'Required';
  } else if (validationError == UsernameValidationError.exist) {
    return 'Username already exists';
  } else {
    return null;
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
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                cursorColor: Palette.cream,
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                key: const Key('signUpForm_emailInput_textField'),
                onChanged: (email) =>
                    context.read<SignUpCubit>().emailChanged(email),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 2.5,
                    horizontal: 8,
                  ),
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Palette.cream,
                  ),
                  filled: true,
                  fillColor: Palette.lightGrey,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  errorStyle: const TextStyle(
                    fontSize: 10,
                    // height: 0.3,
                  ),
                  isDense: true,
                  hintText: 'Email Address',
                  helperText: '',
                  errorText: emailError(state.email.error),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

String emailError(EmailValidationError validationError) {
  if (validationError == EmailValidationError.invalid) {
    return 'Invalid email address';
  } else if (validationError == EmailValidationError.empty) {
    return 'Required';
  } else {
    return null;
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
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
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
                  errorStyle: const TextStyle(
                    fontSize: 10,
                    // height: 0.3,
                  ),
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Palette.cream,
                  ),
                  filled: true,
                  fillColor: Palette.lightGrey,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  isDense: true,
                  errorMaxLines: 3,
                  hintText: 'Password',
                  helperText: '',
                  errorText: passwordError(state.password.error),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

String passwordError(PasswordValidationError validationError) {
  if (validationError == PasswordValidationError.invalid) {
    return 'More than 8 with numbers';
  } else if (validationError == PasswordValidationError.empty) {
    return 'Required';
  } else {
    return null;
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
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
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
                  errorStyle: const TextStyle(
                    fontSize: 10,
                    // height: 0.3,
                  ),
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Palette.cream,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  errorMaxLines: 3,
                  filled: true,
                  fillColor: Palette.lightGrey,
                  isDense: true,
                  hintText: 'Verify Password',
                  helperText: '',
                  errorText:
                      confirmedPasswordError(state.confirmedPassword.error),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

String confirmedPasswordError(
    ConfirmedPasswordValidationError validationError) {
  if (validationError == ConfirmedPasswordValidationError.invalid) {
    return 'Passwords do not match';
  } else if (validationError == ConfirmedPasswordValidationError.empty) {
    return 'Required';
  } else {
    return null;
  }
}

class _StateInput extends StatelessWidget {
  final stateList = [
    'International',
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
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
    'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    'Montana',
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
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    'Washington',
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
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                ),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      state.americanState.invalid
                          ? Text(
                              'Required',
                              style: GoogleFonts.nunito(
                                color: Colors.red,
                                fontSize: 10,
                                // height: 0.3,
                              ),
                            )
                          : Container(),
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

class _MobileNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.number != current.number,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Mobile Number',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                autocorrect: false,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  // MaskedInputFormater('(###) ###-####'),
                ],
                onChanged: (mobileNumber) =>
                    context.read<SignUpCubit>().numberChanged(mobileNumber),
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                key: const Key('signUpForm_mobileNumberInput_textField'),
                cursorColor: Palette.cream,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 2.5,
                    horizontal: 8,
                  ),
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Palette.cream,
                  ),
                  errorStyle: const TextStyle(
                    fontSize: 10,
                    // height: 0.3,
                  ),
                  filled: true,
                  fillColor: Palette.lightGrey,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  isDense: true,
                  hintText: 'Mobile Number',
                  helperText: '',
                  errorText: mobileNumberError(state.number.error),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

String mobileNumberError(PhoneNumberValidationError validationError) {
  if (validationError == PhoneNumberValidationError.invalid) {
    return 'Invalid mobile number';
  } else if (validationError == PhoneNumberValidationError.empty) {
    return 'Required';
  } else {
    return null;
  }
}

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
//                     Text(
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
//                     ? Text(
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

class _AgreementCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                            style: GoogleFonts.nunito(
                                fontSize: 11, color: Palette.cream),
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
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  state.agreement.invalid
                      ? Text(
                          'Required',
                          style: GoogleFonts.nunito(
                            color: Colors.red,
                            fontSize: 10,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : DefaultButton(
                  text: 'SIGN UP',
                  action: () {
                    context.read<SignUpCubit>().signUpFormSubmitted();
                  },
                );
        },
      ),
    );
  }
}

class _ExistingAccountSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          TextButton(
            key: const Key('loginForm_createAccount_flatButton'),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Log In',
              style: GoogleFonts.nunito(
                color: Palette.green,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
