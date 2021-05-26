import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/features/authentication/views/sign_up/views/sign_up_page.dart';
import 'package:vegas_lit/features/shared_widgets/auth_logo.dart';
import 'package:vegas_lit/features/shared_widgets/default_button.dart';

import '../login.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text(
                    'Authentication Error',
                  ),
                ),
              );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
              ),
              child: Column(
                children: [
                  TopLogo(),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      _EmailInput(),
                      _PasswordInput(),
                      const SizedBox(
                        height: 12,
                      ),
                      _LoginButton(),
                      const SizedBox(
                        height: 8,
                      ),
                      _ResetPassword(),
                      _LinkToSignup(),
                    ],
                  ),
                  SizedBox(height: height / 5),
                  VersionNumber(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return SizedBox(
          width: width > 500 ? 333.34 : width / 1.5,
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: TextField(
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<LoginCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.nunito(color: Palette.cream),
              decoration: InputDecoration(
                labelStyle: GoogleFonts.nunito(color: Palette.cream),
                prefixIcon: const Icon(
                  LineAwesomeIcons.user,
                  color: Palette.cream,
                ),
                labelText: 'Email',
                helperText: '',
                errorText: state.email.invalid ? 'Invalid email' : null,
                focusedBorder: const UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Palette.cream)),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return SizedBox(
          width: width > 500 ? 333.34 : width / 1.5,
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginCubit>().passwordChanged(password),
              obscureText: true,
              style: GoogleFonts.nunito(color: Palette.cream),
              decoration: InputDecoration(
                labelStyle: GoogleFonts.nunito(color: Palette.cream),
                prefixIcon:
                    const Icon(LineAwesomeIcons.lock, color: Palette.cream),
                labelText: 'Password',
                helperText: '',
                errorText: state.password.invalid ? 'Invalid password' : null,
                focusedBorder: const UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Palette.cream)),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator(
                color: Palette.cream,
              )
            : DefaultButton(
                text: 'LOGIN',
                action: () {
                  context.read<LoginCubit>().logInWithCredentials();
                },
              );
      },
    );
  }
}

class _ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext parentContext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Forgot Password?',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w300,
            fontSize: 18,
            color: Palette.cream,
          ),
        ),
        TextButton(
          key: const Key('loginForm_resetPassword_flatButton'),
          onPressed: () {
            showModalBottomSheet(
              context: parentContext,
              isScrollControlled: true,
              builder: (context) => BlocProvider.value(
                value: parentContext.read<LoginCubit>(),
                child: SingleChildScrollView(
                  child: _ResetPage(),
                ),
              ),
            );
          },
          child: Text(
            'Reset',
            style: GoogleFonts.nunito(
              color: Palette.green,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _LinkToSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account yet? ",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w300,
            fontSize: 18,
            color: Palette.cream,
          ),
        ),
        TextButton(
          key: const Key('loginForm_createAccount_flatButton'),
          onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
          child: Text(
            'Sign Up',
            style: GoogleFonts.nunito(
              color: Palette.green,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _ResetPage extends StatefulWidget {
  @override
  __ResetPageState createState() => __ResetPageState();
}

class __ResetPageState extends State<_ResetPage> {
  String email;

  final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String isEmailValid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Palette.lightGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Reset Password',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26.0,
              color: Palette.cream,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
            decoration: InputDecoration(
              errorText: isEmailValid,
              hintText: 'Enter your email',
              border: InputBorder.none,
              isDense: true,
              hintStyle: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Palette.cream,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (newText) {
              setState(() {
                email = newText;
              });
            },
          ),
          const SizedBox(height: 20),
          TextButton(
            child: Text(
              'Done',
              style: GoogleFonts.nunito(
                color: Palette.cream,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Palette.green),
            ),
            onPressed: () async {
              if (email != null) {
                if (email.isNotEmpty) {
                  if (emailValid.hasMatch(email)) {
                    setState(() {
                      isEmailValid = null;
                    });

                    await context
                        .read<LoginCubit>()
                        .resetPassword(email: email);
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      isEmailValid = 'Enter Correct Email!';
                    });
                  }
                } else {
                  // ignore: avoid_print
                  print('Don\'t leave the field blank.');

                  setState(() {
                    isEmailValid = 'Don\'t leave the field blank.';
                  });
                }
              } else {
                // ignore: avoid_print
                print('Type Something in the Field!');

                setState(() {
                  isEmailValid = 'Type Something in the Field!';
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

class VersionNumber extends StatefulWidget {
  @override
  _VersionNumberState createState() => _VersionNumberState();
}

class _VersionNumberState extends State<VersionNumber> {
  String versionString;
  String buildNumber;

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  void _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionString = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Text(
          'Version: $versionString ($buildNumber)',
          style: GoogleFonts.nunito(
            color: Palette.cream,
            fontSize: 10,
          ),
        );
      },
    );
  }
}
