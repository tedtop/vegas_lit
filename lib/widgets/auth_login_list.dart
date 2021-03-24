import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vegas_lit/features/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthenticationType { login, signup }

class SocialLoginList extends StatelessWidget {
  const SocialLoginList({Key key, @required this.authenticationType})
      : super(key: key);

  final AuthenticationType authenticationType;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        authenticationType == AuthenticationType.login
            ? SizedBox(
                width: width * 0.9,
                child: Text(
                  'Or use any of these social platforms to login.',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              )
            : SizedBox(
                width: width * 0.9,
                child: Text(
                  'Or use any of these social platforms to sign up.',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                IconButton(
                  key: const Key('facebookLogin_iconButton'),
                  icon: const Icon(LineAwesomeIcons.facebook_square),
                  iconSize: 40,
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Coming Soon!'),
                        ),
                      );
                  },
                ),
                Text(
                  'Facebook',
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                  ),
                )
              ],
            ),
            Column(
              children: [
                IconButton(
                  key: const Key('appleLogin_iconButton'),
                  icon: const Icon(LineAwesomeIcons.apple),
                  iconSize: 40,
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Coming Soon!'),
                        ),
                      );
                  },
                ),
                Text(
                  'Apple',
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                  ),
                )
              ],
            ),
            Column(
              children: [
                IconButton(
                  key: const Key('googleLogin_iconButton'),
                  icon: const Icon(LineAwesomeIcons.google_logo),
                  iconSize: 40,
                  onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
                ),
                Text(
                  'Google',
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
