import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/repositories/sportsfeed_repository.dart';
import 'package:vegas_lit/features/history/bet_history.dart';
import 'package:vegas_lit/features/home/cubit/home_cubit.dart';
import 'package:vegas_lit/features/home/widgets/widgets.dart';
import 'package:vegas_lit/features/leaderboard/view/leaderboard_page.dart';
import 'package:vegas_lit/features/open_bets/view/open_bets_page.dart';
import 'package:vegas_lit/features/slip/bet_slip.dart';
import 'package:vegas_lit/features/slip/cubit/bet_slip_cubit.dart';
import 'package:vegas_lit/features/sportsbook/bloc/sportsbook_bloc.dart';
import 'package:vegas_lit/features/sportsbook/view/sportsbook_page.dart';

import '../../authentication/bloc/authentication_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage._({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<SportsbookBloc>(
            create: (_) => SportsbookBloc(
              sportsfeedRepository: context.read<SportsfeedRepository>(),
            )..add(
                SportsbookOpen(
                  gameName: 'NBA',
                ),
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
      ),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final pageIndex =
        context.select((HomeCubit homeCubit) => homeCubit.state.pageIndex);
    final userId = context.select(
      (AuthenticationBloc authenticationBloc) =>
          authenticationBloc.state.user?.uid,
    );
    return Scaffold(
      // backgroundColor: Palette.lightGrey,
      appBar: AppBar(
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
                    AutoSizeText(
                      'Balance',
                      style: GoogleFonts.nunito(
                        color: Palette.cream,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      '\$100',
                      style: GoogleFonts.nunito(
                        color: Palette.cream,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: HomeDrawer(),
      body: IndexedStack(
        index: pageIndex,
        children: [
          Sportsbook(),
          BetSlip(),
          Leaderboard(),
          OpenBets.route(currentUserId: userId),
          BetHistory(),
        ],
      ),
      bottomNavigationBar: HomeBottomNavigation(),
    );
  }
}
