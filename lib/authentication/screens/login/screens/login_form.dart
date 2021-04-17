import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vegas_lit/authentication/screens/sign_up/screens/view.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/shared_widgets/auth_socials.dart';
import 'package:vegas_lit/shared_widgets/auth_logo.dart';
import 'package:vegas_lit/shared_widgets/default_button.dart';

import '../login.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Authentication Failure',
                ),
              ),
            );
          }
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
            ),
            children: [
              TopLogo(),
              const SizedBox(height: 30),
              Column(
                children: [
                  _EmailInput(),
                  _PasswordInput(),
                  _LoginButton(),
                  _ResetPassword(),
                  _LinkToSignup(),
                  // const SocialLoginList(
                  //   authenticationType: AuthenticationType.login,
                  // ),
                ],
              ),
            ],
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
          width: width / 1.5,
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
                labelText: 'Email / Username',
                helperText: '',
                // errorText: state.email.invalid ? 'Invalid email' : null,
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
          width: width / 1.5,
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
                // errorText: state.password.invalid ? 'Invalid password' : null,
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
            ? const CircularProgressIndicator()
            : DefaultButton(
                text: 'LOGIN',
                action: () {
                  state.status.isValidated
                      ? context.read<LoginCubit>().logInWithCredentials()
                      // ignore: unnecessary_statements
                      : null;
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
          "Don't have an account yet?",
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

class _ResetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String email;

    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Palette.lightGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Reset Password',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26.0,
              color: Palette.cream,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
            decoration: InputDecoration(
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
              email = newText;
            },
          ),
          SizedBox(height: 20),
          FlatButton(
            child: Text(
              'Done',
              style: GoogleFonts.nunito(
                color: Palette.cream,
              ),
            ),
            color: Palette.green,
            onPressed: () async {
              await context.read<LoginCubit>().resetPassword(email: email);
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
