import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/shared_widgets/auth_socials.dart';
import 'package:vegas_lit/shared_widgets/auth_logo.dart';
import 'package:vegas_lit/shared_widgets/default_button.dart';

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
                  'Sign Up Failure',
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
                _UsernameInput(),
                _EmailInput(),
                _PasswordInput(),
                _ConfirmPasswordInput(),
                _StateInput(),
                _MobileNumberInput(),
                _AgeCheckbox(),
                _RulesCheckbox(),
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
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  isDense: true,
                  hintText: 'Username',
                  helperText: '',
                  errorText:
                      state.username.invalid ? 'Should be less than 10' : null,
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
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  errorStyle: GoogleFonts.nunito(fontSize: 10),
                  isDense: true,
                  hintText: 'Email Address',
                  helperText: '',
                  // errorText: state.email.invalid ? 'Write Correct E-mail' : '',
                ),
              ),
            ),
          ],
        );
      },
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
                  isDense: true,
                  errorMaxLines: 3,
                  errorStyle: GoogleFonts.nunito(
                    fontSize: 10,
                  ),
                  hintText: 'Password',
                  helperText: '',
                  // errorText: state.password.invalid
                  //     ? 'Password should be 8 characters and include at least one number'
                  //     : null,
                ),
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
                  errorStyle: GoogleFonts.nunito(
                    fontSize: 10,
                  ),
                  isDense: true,
                  hintText: 'Verify Password',
                  helperText: '',
                  errorText: state.confirmedPassword.invalid
                      ? 'Passwords do not match'
                      : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StateInput extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  GlobalKey _dropdownButtonKey;

  void openDropdown() {
    GestureDetector detector;
    void searchForGestureDetector(BuildContext element) {
      element.visitChildElements((element) {
        if (element.widget != null && element.widget is GestureDetector) {
          detector = element.widget;
          return false;
        } else {
          searchForGestureDetector(element);
        }

        return true;
      });
    }

    searchForGestureDetector(_dropdownButtonKey.currentContext);
    assert(detector != null);

    detector.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.americanState != current.americanState,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'State',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 80,
                      child: TextField(
                        controller: textEditingController,
                        onChanged: (americanState) {
                          context
                              .read<SignUpCubit>()
                              .americanStateChanged(americanState);
                        },
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                        cursorColor: Palette.cream,
                        key: const Key('signUpForm_stateInput_textField'),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIconConstraints:
                              const BoxConstraints(maxHeight: 10, maxWidth: 25),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.5,
                            horizontal: 8,
                          ),
                          hintStyle: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Palette.cream,
                          ),
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4),
                            ),
                          ),
                          isDense: true,
                          hintText: 'State',
                          helperText: '',
                          errorText: state.americanState.invalid
                              ? 'Wrong State'
                              : null,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22),
                    child: Container(
                      height: 30,
                      width: 33,
                      decoration: const BoxDecoration(
                        color: Palette.green,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                      child: DropdownButton<String>(
                        key: _dropdownButtonKey,
                        items: [
                          DropdownMenuItem(
                            value: '1',
                            child: Text('1'),
                          ),
                          DropdownMenuItem(
                            value: '2',
                            child: Text('2'),
                          ),
                          DropdownMenuItem(
                            value: '3',
                            child: Text('3'),
                          ),
                        ],
                        onChanged: (String value) {},
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                    ),
                  )
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
                inputFormatters: [MaskedInputFormater('(###) ###-####')],
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
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  isDense: true,
                  hintText: 'Mobile Number',
                  helperText: '',
                  errorText:
                      state.number.invalid ? 'Wrong Mobile Number' : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AgeCheckbox extends StatefulWidget {
  @override
  __AgeCheckboxState createState() => __AgeCheckboxState();
}

class __AgeCheckboxState extends State<_AgeCheckbox> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          fillColor: MaterialStateProperty.all(Palette.green),
          value: isSelected,
          onChanged: (value) {
            setState(
              () {
                isSelected = value;
              },
            );
          },
        ),
        Text(
          'I am 18 years or older',
          style: GoogleFonts.nunito(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _RulesCheckbox extends StatefulWidget {
  @override
  __RulesCheckboxState createState() => __RulesCheckboxState();
}

class __RulesCheckboxState extends State<_RulesCheckbox> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          fillColor: MaterialStateProperty.all(Palette.green),
          value: isSelected,
          onChanged: (value) {
            setState(
              () {
                isSelected = value;
              },
            );
          },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: GoogleFonts.nunito(fontSize: 11, color: Palette.cream),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'I have read and agree to the official Vegas Lit contest rules and conditions found ',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: 'here',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Palette.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
                    state.status.isValidated
                        ? context.read<SignUpCubit>().signUpFormSubmitted()
                        : null;
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
            "Already have an account?",
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
