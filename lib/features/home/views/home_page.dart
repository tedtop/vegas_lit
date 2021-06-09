import 'package:connectivity/connectivity.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/assets.dart';
import '../../../data/repositories/bets_repository.dart';
import '../../../data/repositories/sports_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../bet_history/cubit/history_cubit.dart';
import '../../bet_history/views/bet_history_page.dart';
import '../../bet_slip/bet_slip.dart';
import '../../leaderboard/leaderboard.dart';
import '../../open_bets/cubit/open_bets_cubit.dart';
import '../../open_bets/views/open_bets_page.dart';
import '../../profile/cubit/profile_cubit.dart';
import '../../shared_widgets/app_bar/app_bar.dart';
import '../../sportsbook/screens/sportsbook_page.dart';
import '../../sportsbook/sportsbook.dart';
import '../cubit/internet_cubit.dart';
import '../cubit/version_cubit.dart';
import '../home.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/home_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage._({@required this.observer, this.currentUserId, Key key})
      : super(key: key);

  final FirebaseAnalyticsObserver observer;
  final String currentUserId;

  static Route route({
    @required FirebaseAnalyticsObserver observer,
    @required Connectivity connectivity,
    @required String uid,
  }) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'HomePage'),
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ProfileCubit>(
                create: (context) =>
                    ProfileCubit(userRepository: context.read<UserRepository>())
                      ..openProfile(currentUserId: uid)),
            BlocProvider<SportsbookBloc>(
              create: (_) => SportsbookBloc(
                sportsfeedRepository: context.read<SportsRepository>(),
              )..add(
                  SportsbookOpen(
                    league: 'MLB',
                  ),
                ),
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
                betsRepository: context.read<BetsRepository>(),
              )..fetchAllBets(uid: uid),
            ),
            BlocProvider<HistoryCubit>(
              create: (context) => HistoryCubit(
                betsRepository: context.read<BetsRepository>(),
                userRepository: context.read<UserRepository>(),
              )..fetchAllBets(uid: uid),
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
              )..openHome(uid: uid),
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
        appBar: adaptiveAppBar(
            width: width, balanceAmount: balanceAmount, pageIndex: pageIndex),
        drawer: HomeDrawer(),
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
                  OpenBets.route(uid: widget.currentUserId),
                  History.route(uid: widget.currentUserId),
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
}
