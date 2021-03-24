import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/features/login/login.dart';
import 'package:vegas_lit/features/sign_up/sign_up.dart';

class SignUpInput extends StatelessWidget {
  const SignUpInput({
    Key key,
    @required this.textFieldName,
    @required this.onChange,
    @required this.textInputType,
  }) : super(key: key);

  final String textFieldName;
  final Function onChange;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      // buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  textFieldName,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                cursorColor: Palette.cream,
                style: GoogleFonts.nunito(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
                onChanged: onChange,
                keyboardType: textInputType,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 10,
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
                  hintText: textFieldName,
                  helperText: '',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LoginInput extends StatelessWidget {
  const LoginInput({
    Key key,
    @required this.textFieldName,
    @required this.onChange,
    @required this.textInputType,
  }) : super(key: key);

  final String textFieldName;
  final Function onChange;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginCubit, LoginState>(
      // buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return SizedBox(
          width: width / 1.5,
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: TextField(
              onChanged: onChange,
              keyboardType: textInputType,
              style: GoogleFonts.nunito(color: Palette.cream),
              decoration: InputDecoration(
                labelStyle: GoogleFonts.nunito(color: Palette.cream),
                prefixIcon: const Icon(
                  LineAwesomeIcons.user,
                  color: Palette.cream,
                ),
                labelText: textFieldName,
                helperText: '',
                errorText:
                    state.email.invalid ? 'Invalid $textFieldName' : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
