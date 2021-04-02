import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegas_lit/authentication/authentication.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/drawer_pages/faq.dart';
import 'package:vegas_lit/drawer_pages/privacy_policy.dart';
import 'package:vegas_lit/drawer_pages/rules.dart';
import 'package:vegas_lit/drawer_pages/terms.dart';
import 'package:vegas_lit/profile/profile.dart';

import '../cubit/home_cubit.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Hero(
              tag: 'drawerHeader',
              child: Image.asset(
                Images.topLogo,
                fit: BoxFit.contain,
                height: 80,
              ),
            ),
            decoration: const BoxDecoration(
              color: Palette.lightGrey,
            ),
          ),
          ListTile(
            title: Text(
              'PROFILE',
              style: GoogleFonts.nunito(
                color: Palette.cream,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              // Navigator.of(context).push(Profile.route());
            },
          ),
          ListTile(
            title: Text(
              'LEADERBOARD',
              style: GoogleFonts.nunito(
                color: Palette.cream,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              context.read<HomeCubit>().homeChange(2);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Text(
              'LOGOUT',
              style: GoogleFonts.nunito(
                color: Palette.cream,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              context.read<AuthenticationBloc>().add(
                    AuthenticationLogoutRequested(),
                  );
            },
          ),
          const Divider(
            color: Palette.cream,
          ),
          ListTile(
            title: Text(
              'RULES',
              style: GoogleFonts.nunito(
                color: Palette.cream,
                fontSize: 18,
                fontWeight: FontWeight.w200,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                Rules.route(),
              );
            },
          ),
          ListTile(
            title: Text(
              'FAQ',
              style: GoogleFonts.nunito(
                color: Palette.cream,
                fontSize: 18,
                fontWeight: FontWeight.w200,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                FAQ.route(),
              );
            },
          ),
          ListTile(
            title: Text(
              'TERMS OF SERVICE',
              style: GoogleFonts.nunito(
                color: Palette.cream,
                fontSize: 18,
                fontWeight: FontWeight.w200,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                TermsOfService.route(),
              );
            },
          ),
          ListTile(
            title: Text(
              'PRIVACY POLICY',
              style: GoogleFonts.nunito(
                color: Palette.cream,
                fontSize: 18,
                fontWeight: FontWeight.w200,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                PrivacyPolicy.route(),
              );
            },
          ),
          ListTile(
            title: Text(
              'CONTACT US',
              style: GoogleFonts.nunito(
                color: Palette.cream,
                fontSize: 18,
                fontWeight: FontWeight.w200,
              ),
            ),
            onTap: () {
              launch(
                _emailLaunchUri.toString(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Version: 0.5.3',
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: Palette.cream,
                      )),
                ),
                const Expanded(
                  child: Divider(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@vegaslit.com',
      queryParameters: {'subject': 'VegasLit'});
}
