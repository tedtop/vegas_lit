import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/admin_vault/admin_vault_page.dart';
import 'package:vegas_lit/features/authentication/authentication.dart';
import 'package:vegas_lit/features/drawer_pages/rules.dart';
import 'package:vegas_lit/features/groups/views/groups_page.dart';
import 'package:vegas_lit/features/home/home.dart';
import 'package:vegas_lit/features/nascar/race_page/race_page.dart';
import 'package:vegas_lit/features/profile/widgets/avatar/profile_avatar.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? versionString;
  String? buildNumber;

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    final username = context
        .select((HomeCubit cubit) => cubit.state.userData?.username ?? '');
    final email =
        context.select((HomeCubit cubit) => cubit.state.userData?.email ?? '');
    final location = context
        .select((HomeCubit cubit) => cubit.state.userData?.location ?? '');
    final isAdmin = context
        .select((HomeCubit cubit) => cubit.state.userData?.isAdmin ?? false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfileAvatar.route(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      username,
                      style: Styles.signUpFieldText,
                    ),
                    Text(
                      email,
                      style: Styles.signUpFieldText,
                    ),
                    Text(
                      location,
                      style: Styles.signUpFieldText,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: Palette.cream,
          ),
          ListTile(
            leading: const Icon(
              Icons.groups,
              color: Palette.cream,
            ),
            title: Text('GROUPS', style: Styles.normalTextBold),
            onTap: () {
              Navigator.push<void>(
                context,
                GroupsPage.route(
                  cubit: context.read<HomeCubit>(),
                ),
              );
            },
          ),
          if (isAdmin)
            ListTile(
              leading: const Icon(
                Icons.admin_panel_settings,
                color: Palette.cream,
              ),
              title: Text('ADMIN VAULT', style: Styles.normalTextBold),
              onTap: () {
                Navigator.of(context).push<void>(AdminVaultScreen.route());
              },
            )
          else
            Container(),
          if (isAdmin)
            ListTile(
              leading: const Icon(
                Icons.car_repair,
                color: Palette.cream,
              ),
              title: Text('NASCAR', style: Styles.normalTextBold),
              onTap: () {
                Navigator.of(context).push<void>(NascarPage.route());
              },
            )
          else
            Container(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Palette.cream,
            ),
            title: Text('LOGOUT', style: Styles.normalTextBold),
            onTap: () {
              context.read<AuthenticationCubit>().authenticationLogOut();
            },
          ),
          const Divider(
            color: Palette.cream,
          ),
          ListTile(
            title: Text('TUTORIAL', style: Styles.normalText),
            onTap: _launchTutorialVideo,
          ),
          ListTile(
            title: Text('RULES', style: Styles.normalText),
            onTap: () {
              Navigator.of(context).push<void>(
                Rules.route(),
              );
            },
          ),
          ListTile(
            title: Text('TERMS OF SERVICE', style: Styles.normalText),
            onTap: _launchTermsAndConditions,
          ),
          ListTile(
            title: Text('PRIVACY POLICY', style: Styles.normalText),
            onTap: _launchPrivacyPolicy,
          ),
          ListTile(
            title: Text('CONTACT US', style: Styles.normalText),
            onTap: () {
              launch(
                _emailLaunchUri.toString(),
              );
            },
          ),
          ListTile(
            title: Text(
              'Version: $versionString ($buildNumber)',
              style: Styles.versionText,
            ),
          ),
        ],
      ),
    );
  }

  final _tutorialVideoUrl = 'https://www.youtube.com/watch?v=LX2sJuqDWn0';

  Future<void> _launchTutorialVideo() async =>
      await canLaunch(_tutorialVideoUrl)
          ? await launch(_tutorialVideoUrl)
          : throw TutorialVideoUrlFailure();

  final _termsAndConditionsUrl = 'https://vegaslit.web.app/terms.html';

  Future<void> _launchTermsAndConditions() async =>
      await canLaunch(_termsAndConditionsUrl)
          ? await launch(_termsAndConditionsUrl)
          : throw TermsAndConditionsUrlFailure();

  final _privacyPolicyUrl = 'https://vegaslit.web.app/privacy.html';

  Future<void> _launchPrivacyPolicy() async =>
      await canLaunch(_privacyPolicyUrl)
          ? await launch(_privacyPolicyUrl)
          : throw PrivacyPolicyUrlFailure();

  Future<void> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionString = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'support@vegaslit.com',
    queryParameters: <String, String>{
      'subject': 'Question about Vegas Lit app'
    },
  );
}

class TutorialVideoUrlFailure implements Exception {}

class TermsAndConditionsUrlFailure implements Exception {}

class PrivacyPolicyUrlFailure implements Exception {}
