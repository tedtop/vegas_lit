import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_version/new_version.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/admin_vault/admin_vault_page.dart';
import 'package:vegas_lit/features/authentication/authentication.dart';
import 'package:vegas_lit/features/drawer_pages/rules.dart';
import 'package:vegas_lit/features/groups/views/groups_page.dart';
import 'package:vegas_lit/features/profile/widgets/avatar/profile_avatar.dart';

import '../../../config/assets.dart';
import '../../../config/palette.dart';
import '../../../config/routes.dart';
import '../../../data/repositories/bet_repository.dart';
import '../../../data/repositories/device_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../utils/app_bar.dart';
import '../../../utils/route_aware_analytics.dart';
import '../../bet_history/cubit/history_cubit.dart';
import '../../bet_history/views/bet_history_page.dart';
import '../../bet_slip/bet_slip.dart';
import '../../bet_slip/widgets/parlay_bet_button/cubit/parlay_bet_button_cubit.dart';
import '../../leaderboard/leaderboard.dart';
import '../../open_bets/cubit/open_bets_cubit.dart';
import '../../open_bets/views/open_bets_page.dart';
import '../../sportsbook/screens/help_overlay/help_overlay.dart';
import '../../sportsbook/screens/sportsbook_page.dart';
import '../../sportsbook/sportsbook.dart';
import '../cubit/internet_cubit.dart';
import '../cubit/notification_cubit.dart';
import '../cubit/version_cubit.dart';
import '../home.dart';
import '../widgets/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage._({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(
      name: 'HomePage',
      child: Builder(builder: (context) {
        final uid = context
            .select((AuthenticationCubit cubit) => cubit.state.user?.uid);
        return MultiBlocProvider(
          providers: [
            BlocProvider<SportsbookCubit>(
              create: (context) => SportsbookCubit(
                deviceRepository: context.read<DeviceRepository>(),
              )..sportsbookOpen(league: 'MLB'),
            ),
            BlocProvider<VersionCubit>(
              create: (context) => VersionCubit(
                userRepository: context.read<UserRepository>(),
              )..checkMinimumVersion(),
            ),
            BlocProvider<LeaderboardCubit>(
              create: (context) => LeaderboardCubit(
                userRepository: context.read<UserRepository>(),
              )..openLeaderboard(),
            ),
            BlocProvider<OpenBetsCubit>(
              create: (context) => OpenBetsCubit(
                betsRepository: context.read<BetRepository>(),
              )..fetchAllBets(uid: uid!),
            ),
            BlocProvider<ParlayBetButtonCubit>(
              create: (context) => ParlayBetButtonCubit(
                betsRepository: context.read<BetRepository>(),
              ),
            ),
            BlocProvider<HistoryCubit>(
              create: (context) => HistoryCubit(
                userRepository: context.read<UserRepository>(),
              )..fetchAllBets(uid: uid),
            ),
            BlocProvider<NotificationCubit>(
              create: (context) => NotificationCubit(
                deviceRepository: context.read<DeviceRepository>(),
              )..initializePushNotification(),
            ),
            BlocProvider<BetSlipCubit>(
              create: (context) => BetSlipCubit()
                ..openBetSlip(
                  singleBetSlipGames: [],
                  parlayBetSlipGames: [],
                  betDataList: [],
                ),
            ),
            BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(
                deviceRepository: context.read<DeviceRepository>(),
                userRepository: context.read<UserRepository>(),
              )..openHome(uid: uid!),
            ),
          ],
          child: const HomePage._(),
        );
      }));

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, RouteAwareAnalytics {
  final newVersion = NewVersion();

  final PageController _pageController = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final uid =
        context.select((AuthenticationCubit cubit) => cubit.state.user?.uid);
    final pageIndex =
        context.select((HomeCubit homeCubit) => homeCubit.state.pageIndex);
    final balanceAmount = context.select(
      (HomeCubit homeCubit) => homeCubit.state.userData == null
          ? 0
          : homeCubit.state.userWallet!.accountBalance,
    );
    final width = MediaQuery.of(context).size.width;

    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          previous.pageIndex != current.pageIndex,
      listener: (context, state) async {
        if (state.status == HomeStatus.changed) {
          _pageController.jumpToPage(state.pageIndex);
          selectedIndex = _pageController.page!.toInt();
          await super.setThisScreenForAnalytics();
        } else if (state.askReview) {
          await context.read<DeviceRepository>().openAppReview();
        } else if (state.status == HomeStatus.initial) {
          newVersion.showAlertIfNecessary(context: context);
        }
      },
      child: Stack(
        children: [
          Scaffold(
            // backgroundColor: Palette.lightGrey,
            appBar: adaptiveAppBar(
                width: width,
                balanceAmount: balanceAmount,
                pageIndex: pageIndex),

            body: BlocConsumer<NotificationCubit, NotificationState>(
              listener: (context, state) {
                switch (state.status) {
                  case NotificationStatus.failure:
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            state.errorMessage!,
                          ),
                        ),
                      );
                    break;
                  case NotificationStatus.success:
                    showSimpleNotification(
                      Text(
                        state.notification!.title!,
                        style: GoogleFonts.nunito(color: Palette.cream),
                      ),
                      subtitle: Text(
                        state.notification!.body!,
                        style: GoogleFonts.nunito(color: Palette.cream),
                      ),
                      background: Palette.lightGrey,
                      duration: const Duration(seconds: 4),
                    );
                    break;
                  default:
                }
              },
              builder: (context, state) {
                return BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                    if (state is InternetDisconnected) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(SVG.networkError),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<InternetCubit>()
                                    .checkInternetConnection();
                              },
                              icon: const Icon(Icons.replay_rounded),
                            )
                          ],
                        ),
                      );
                    } else {
                      return PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        children: [
                          const Sportsbook(),
                          BetSlip(),
                          Leaderboard.route(),
                          const Orders(),
                          const Account(),
                        ],
                      );
                    }
                  },
                );
              },
            ),
            bottomNavigationBar:
                !kIsWeb ? BottomNavigation() : const SizedBox.shrink(),
          ),
          const HelpOverlayView()
        ],
      ),
    );
  }

  @override
  Routes get route {
    switch (selectedIndex) {
      case 1:
        return Routes.betSlip;

      case 2:
        return Routes.leaderboard;

      case 3:
        return Routes.openBets;

      case 4:
        return Routes.betHistory;

      default:
        return Routes.sportsbook;
    }
  }
}

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid =
        context.select((AuthenticationCubit cubit) => cubit.state.user?.uid);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Palette.green,
            tabs: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'OPEN BETS',
                      style: Styles.pageTitle.copyWith(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'BET HISTORY',
                      style: Styles.pageTitle.copyWith(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OpenBets.route(uid: uid),
            History.route(uid: uid),
          ],
        ),
      ),
    );
  }
}

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
