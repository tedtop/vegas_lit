import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegas_lit/authentication/authentication.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/drawer_pages/faq.dart';
import 'package:vegas_lit/drawer_pages/privacy_policy.dart';
import 'package:vegas_lit/drawer_pages/rules.dart';
import 'package:vegas_lit/drawer_pages/terms.dart';
import 'package:vegas_lit/profile/profile.dart';

import '../cubit/home_cubit.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String versionNumber;

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

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
          //..................................................................//
          ListTile(
            title: Text('PROFILE', style: Styles.normalTextBold),
            onTap: () {
              Navigator.of(context).push(Profile.route());
            },
          ),
          ListTile(
            title: Text('LEADERBOARD', style: Styles.normalTextBold),
            onTap: () {
              context.read<HomeCubit>().homeChange(2);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Text('LOGOUT', style: Styles.normalTextBold),
            onTap: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
          ),
          //..................................................................//
          const Divider(
            color: Palette.cream,
          ),
          //..................................................................//
          ListTile(
            title: Text('RULES', style: Styles.normalText),
            onTap: () {
              Navigator.of(context).push(
                Rules.route(),
              );
            },
          ),
          ListTile(
            title: Text('FAQ', style: Styles.normalText),
            onTap: () {
              Navigator.of(context).push(
                FAQ.route(),
              );
            },
          ),
          ListTile(
            title: Text('TERMS OF SERVICE', style: Styles.normalText),
            onTap: () {
              Navigator.of(context).push(
                TermsOfService.route(),
              );
            },
          ),
          ListTile(
            title: Text('PRIVACY POLICY', style: Styles.normalText),
            onTap: () {
              Navigator.of(context).push(
                PrivacyPolicy.route(),
              );
            },
          ),
          ListTile(
            title: Text('CONTACT US', style: Styles.normalText),
            onTap: () {
              launch(
                _emailLaunchUri.toString(),
              );
            },
          ),
          //..................................................................//
          Builder(
            builder: (context) {
              return ListTile(
                title: Text(
                  'Version: $versionNumber',
                  style: GoogleFonts.nunito(
                    color: Palette.cream,
                    fontSize: 10,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionNumber = packageInfo.version;
    });
  }

  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'support@vegaslit.com',
    queryParameters: {'subject': 'Question about Vegas Lit app'},
  );
}
