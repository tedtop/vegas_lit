import 'package:api_client/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_version/new_version.dart';
import 'package:vegas_lit/bet_history/bet_history.dart';
import 'package:vegas_lit/bet_history/cubit/bet_history_cubit.dart';
import 'package:vegas_lit/bet_slip/bet_slip.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/home/widgets/topnavbar.dart';
import 'package:vegas_lit/leaderboard/leaderboard.dart';
import 'package:vegas_lit/open_bets/open_bets.dart';
import 'package:vegas_lit/sportsbook/sportsbook.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import '../home.dart';

class HomePage extends StatefulWidget {
  const HomePage._({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'HomePage'),
      builder: (context) {
        final currentUserId = context.select(
          (AuthenticationBloc authenticationBloc) =>
              authenticationBloc.state.user?.uid,
        );
        return MultiBlocProvider(
          providers: [
            BlocProvider<SportsbookBloc>(
              create: (_) => SportsbookBloc(
                sportsfeedRepository: context.read<SportsfeedRepository>(),
              )..add(
                  SportsbookOpen(
                    gameName: 'MLB',
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
            BlocProvider<BetHistoryCubit>(
              create: (context) => BetHistoryCubit(
                betsRepository: context.read<BetsRepository>(),
              )..betHistoryOpen(
                  currentUserId: currentUserId,
                ),
            ),
            BlocProvider<BetSlipCubit>(
              create: (_) => BetSlipCubit()
                ..openBetSlip(
                  betSlipGames: [],
                ),
            ),
            BlocProvider<HomeCubit>(
              create: (_) => HomeCubit(),
            ),
          ],
          child: const HomePage._(),
        );
      },
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb != true) {
      final newVersion = NewVersion();
      // ignore: cascade_invocations
      newVersion.showAlertIfNecessary(context: context);
    }
  }

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final pageIndex =
        context.select((HomeCubit homeCubit) => homeCubit.state.pageIndex);
    final balanceAmount =
        context.select((HomeCubit homeCubit) => homeCubit.state.balanceAmount);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Palette.lightGrey,
      appBar: kIsWeb
          ? webViewAppBar(width, balanceAmount, pageIndex)
          : mobileViewAppBar(balanceAmount),
      drawer: kIsWeb && width > 870 ? null : HomeDrawer(),
      body: IndexedStack(
        index: pageIndex,
        children: [
          Sportsbook(),
          BetSlip(),
          Leaderboard(),
          OpenBets.route(),
          BetHistory.route(),
        ],
      ),
      bottomNavigationBar: kIsWeb ? null : BottomNavigation(),
    );
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
                InteractiveNavItem(
                  title: 'Bet Slip',
                  index: 1,
                  selected: pageIndex == 1,
                ),
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
      title: Image.asset(
        Images.topLogo,
        fit: BoxFit.contain,
        height: 80,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 9, 10, 11),
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
      ],
    );
  }
}
