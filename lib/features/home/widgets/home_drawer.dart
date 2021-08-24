import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/assets.dart';
import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../admin_vault/admin_vault_page.dart';
import '../../authentication/authentication.dart';
import '../../drawer_pages/rules.dart';
import '../../olympics/olympic_add.dart';
import '../../profile/cubit/profile_cubit.dart';
import '../../profile/views/profile_page.dart';
import '../cubit/home_cubit.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String versionString;
  String buildNumber;

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final currentUserId = context.select(
      (AuthenticationBloc authenticationBloc) =>
          authenticationBloc.state?.user?.uid,
    );
    final isAdmin = context.select((ProfileCubit profileCubit) =>
        profileCubit.state.userData?.isAdmin ?? false);
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
            title: AutoSizeText('PROFILE', style: Styles.normalTextBold),
            onTap: () {
              Navigator.of(context).push(
                Profile.route(currentUserId: currentUserId),
              );
            },
          ),
          kIsWeb
              ? Column(
                  children: [
                    ListTile(
                      title: AutoSizeText('SPORTSBOOK',
                          style: Styles.normalTextBold),
                      onTap: () {
                        context.read<HomeCubit>().homeChange(0);
                        Navigator.of(context).pop();
                      },
                    ),
                    width > 1000
                        ? const SizedBox()
                        : ListTile(
                            title: AutoSizeText('BET SLIP',
                                style: Styles.normalTextBold),
                            onTap: () {
                              context.read<HomeCubit>().homeChange(1);
                              Navigator.of(context).pop();
                            },
                          ),
                    ListTile(
                      title: AutoSizeText('OPEN BETS',
                          style: Styles.normalTextBold),
                      onTap: () {
                        context.read<HomeCubit>().homeChange(3);
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title:
                          AutoSizeText('HISTORY', style: Styles.normalTextBold),
                      onTap: () {
                        context.read<HomeCubit>().homeChange(4);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              : const SizedBox(),
          ListTile(
            title: AutoSizeText('LEADERBOARD', style: Styles.normalTextBold),
            onTap: () {
              context.read<HomeCubit>().homeChange(2);
              Navigator.of(context).pop();
            },
          ),
          isAdmin
              ? ListTile(
                  title:
                      AutoSizeText('ADMIN VAULT', style: Styles.normalTextBold),
                  onTap: () {
                    Navigator.of(context).push(AdminVaultScreen.route());
                  },
                )
              : Container(),
          // isAdmin
          //     ?
          ListTile(
            title: AutoSizeText('OLYMPICS', style: Styles.normalTextBold),
            onTap: () {
              Navigator.of(context).push(OlympicsAddForm.route());
            },
          ),
          // : Container(),
          // ListTile(
          //   leading:AutoSizeText('GROUPS', style: Styles.normalTextBold),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       GroupsPage.route(
          //         cubit: context.read<HomeCubit>(),
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            leading: AutoSizeText('LOGOUT', style: Styles.normalTextBold),
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
            title: AutoSizeText('TUTORIAL', style: Styles.normalText),
            onTap: _launchTutorialVideo,
          ),
          ListTile(
            title: AutoSizeText('RULES', style: Styles.normalText),
            onTap: () {
              Navigator.of(context).push(
                Rules.route(),
              );
            },
          ),
          ListTile(
            title: AutoSizeText('TERMS OF SERVICE', style: Styles.normalText),
            onTap: _launchTermsAndConditions,
          ),
          ListTile(
            title: AutoSizeText('PRIVACY POLICY', style: Styles.normalText),
            onTap: _launchPrivacyPolicy,
          ),
          ListTile(
            title: AutoSizeText('CONTACT US', style: Styles.normalText),
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
                title: AutoSizeText(
                  'Version: $versionString ($buildNumber)',
                  style: Styles.versionText,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  final _tutorialVideoUrl = 'https://www.youtube.com/watch?v=LX2sJuqDWn0';
  void _launchTutorialVideo() async => await canLaunch(_tutorialVideoUrl)
      ? await launch(_tutorialVideoUrl)
      : throw TutorialVideoUrlFailure();

  final _termsAndConditionsUrl = 'https://vegaslit.web.app/terms.html';
  void _launchTermsAndConditions() async =>
      await canLaunch(_termsAndConditionsUrl)
          ? await launch(_termsAndConditionsUrl)
          : throw TermsAndConditionsUrlFailure();

  final _privacyPolicyUrl = 'https://vegaslit.web.app/privacy.html';
  void _launchPrivacyPolicy() async => await canLaunch(_privacyPolicyUrl)
      ? await launch(_privacyPolicyUrl)
      : throw PrivacyPolicyUrlFailure();

  void _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionString = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'support@vegaslit.com',
    queryParameters: {'subject': 'Question about Vegas Lit app'},
  );
}

class TutorialVideoUrlFailure implements Exception {}

class TermsAndConditionsUrlFailure implements Exception {}

class PrivacyPolicyUrlFailure implements Exception {}
