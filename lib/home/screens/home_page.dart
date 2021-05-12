import 'package:api_client/api_client.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_version/new_version.dart';
import 'package:vegas_lit/bet_history/bet_history.dart';
import 'package:vegas_lit/bet_history/cubit/bet_history_cubit.dart';
import 'package:vegas_lit/bet_slip/bet_slip.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/home/cubit/internet_cubit.dart';
import 'package:vegas_lit/home/widgets/topnavbar.dart';
import 'package:vegas_lit/leaderboard/cubit/leaderboard_cubit.dart';
import 'package:vegas_lit/leaderboard/leaderboard.dart';
import 'package:vegas_lit/open_bets/open_bets.dart';
import 'package:vegas_lit/sportsbook/sportsbook.dart';
import '../cubit/version_cubit.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import '../home.dart';

class HomePage extends StatefulWidget {
  const HomePage._({@required this.observer, Key key}) : super(key: key);

  final FirebaseAnalyticsObserver observer;

  static Route route({
    @required FirebaseAnalyticsObserver observer,
    @required Connectivity connectivity,
  }) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'HomePage'),
      builder: (context) {
        final currentUserId = context.select(
          (AuthenticationBloc authenticationBloc) =>
              authenticationBloc.state?.user?.uid,
        );
        return MultiBlocProvider(
          providers: [
            BlocProvider<SportsbookBloc>(
              create: (_) => SportsbookBloc(
                sportsfeedRepository: context.read<SportsRepository>(),
              )..add(
                  SportsbookOpen(
                    league: 'MLB',
                  ),
                ),
            ),
            BlocProvider<OpenBetsCubit>(
              create: (context) => OpenBetsCubit(
                betsRepository: context.read<BetsRepository>(),
              )..openBetsOpen(
                  currentUserId: currentUserId,
                ),
            ),
            BlocProvider<VersionCubit>(
              create: (context) => VersionCubit(
                userRepository: context.read<UserRepository>(),
              )..checkMinimumVersion(),
            ),
            BlocProvider<BetHistoryCubit>(
              create: (context) => BetHistoryCubit(
                betsRepository: context.read<BetsRepository>(),
              )..betHistoryOpen(
                  currentUserId: currentUserId,
                ),
            ),
            BlocProvider<LeaderboardCubit>(
              create: (context) => LeaderboardCubit(
                userRepository: context.read<UserRepository>(),
              )..openLeaderboard(),
            ),
            BlocProvider<BetSlipCubit>(
              create: (_) => BetSlipCubit()
                ..openBetSlip(
                  betSlipGames: [],
                ),
            ),
            BlocProvider<HomeCubit>(
              create: (_) => HomeCubit(
                userRepository: context.read<UserRepository>(),
              )..openHome(uid: currentUserId),
            ),
          ],
          child: HomePage._(
            observer: observer,
          ),
        );
      },
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, RouteAware {
  @override
  void initState() {
    super.initState();
    if (kIsWeb != true) {
      final newVersion = NewVersion();
      // ignore: cascade_invocations
      newVersion.showAlertIfNecessary(context: context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.observer.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    widget.observer.unsubscribe(this);
    super.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pageIndex =
        context.select((HomeCubit homeCubit) => homeCubit.state.pageIndex);
    final balanceAmount = context.select(
      (HomeCubit homeCubit) => homeCubit.state.userData == null
          ? 0
          : homeCubit.state.userWallet.accountBalance,
    );
    final width = MediaQuery.of(context).size.width;

    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          previous.pageIndex != current.pageIndex,
      listener: (context, state) {
        if (state.status == HomeStatus.changed) {
          selectedIndex = state.pageIndex;

          _sendCurrentTabToAnalytics();
        }
      },
      child: Scaffold(
        // backgroundColor: Palette.lightGrey,
        appBar: kIsWeb
            ? webViewAppBar(width, balanceAmount, pageIndex)
            : mobileViewAppBar(balanceAmount),
        drawer: kIsWeb && width > 870 ? null : HomeDrawer(),
        body: BlocBuilder<InternetCubit, InternetState>(
          builder: (context, state) {
            if (state is InternetDisconnected) {
              return Center(
                child: SvgPicture.asset(SVG.networkError),
              );
            } else {
              return IndexedStack(
                index: pageIndex,
                children: [
                  Sportsbook(),
                  BetSlip(),
                  Leaderboard.route(),
                  OpenBets.route(),
                  BetHistory.route(),
                ],
              );
            }
          },
        ),
        bottomNavigationBar: kIsWeb ? null : BottomNavigation(),
      ),
    );
  }

  @override
  void didPush() {
    _sendCurrentTabToAnalytics();
  }

  @override
  void didPopNext() {
    _sendCurrentTabToAnalytics();
  }

  void _sendCurrentTabToAnalytics() {
    widget.observer.analytics.setCurrentScreen(
      screenName: '${whichIndexPage(selectedIndex)}',
    );
  }

  String whichIndexPage(int pageIndex) {
    switch (pageIndex) {
      case 1:
        return 'BetSlip';
        break;
      case 2:
        return 'Leaderboard';
        break;
      case 3:
        return 'OpenBets';
        break;
      case 4:
        return 'BetHistory';
        break;
      default:
        return 'Sportsbook';
        break;
    }
  }

  AppBar webViewAppBar(width, balanceAmount, pageIndex) {
    return AppBar(
      iconTheme: const IconThemeData(color: Palette.cream),
      toolbarHeight: 80.0,
      title: width > 870
          ? Row(
              children: [
                Image.asset(
                  Images.topLogo,
                  fit: BoxFit.contain,
                  height: 80,
                ),
                InteractiveNavItem(
                  title: 'Sportsbook',
                  index: 0,
                  selected: pageIndex == 0,
                ),
                // InteractiveNavItem(
                //   title: 'Bet Slip',
                //   index: 1,
                //   selected: pageIndex == 1,
                // ),
                InteractiveNavItem(
                  title: 'Leaderboard',
                  index: 2,
                  selected: pageIndex == 2,
                ),
                InteractiveNavItem(
                  title: 'Open Bets',
                  index: 3,
                  selected: pageIndex == 3,
                ),
                InteractiveNavItem(
                  title: 'History',
                  index: 4,
                  selected: pageIndex == 4,
                )
              ],
            )
          : Image.asset(
              Images.topLogo,
              fit: BoxFit.contain,
              height: 80,
            ),
    );
  }

  AppBar mobileViewAppBar(balanceAmount) {
    return AppBar(
      iconTheme: const IconThemeData(color: Palette.cream),
      toolbarHeight: 80.0,
      titleSpacing: 0,
      title: Image.asset(
        Images.topLogo,
        fit: BoxFit.contain,
        height: 80,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 9, 10, 11),
          child: GestureDetector(
            onTap: () {
              context.read<HomeCubit>().homeChange(4);
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Palette.green,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Balance',
                      style: GoogleFonts.nunito(
                        color: Palette.cream,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      '\$$balanceAmount',
                      style: GoogleFonts.nunito(
                        color: Palette.cream,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
