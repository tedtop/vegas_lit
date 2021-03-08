import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/repositories/sportsfeed_repository.dart';

import '../authentication/bloc/authentication_bloc.dart';
import 'screens/bet_history/bet_history.dart';
import 'screens/bet_slip/bet_slip.dart';
import 'screens/bet_slip/cubit/bet_slip_cubit.dart';
import 'screens/leaderboard/leaderboard.dart';
import 'screens/open_bets/open_bets.dart';
import 'screens/sportsbook/bloc/sportsbook_bloc.dart';
import 'screens/sportsbook/sportsbook.dart';

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
                SportsbookOpen(gameName: 'NBA'),
              ),
          ),
          BlocProvider<BetSlipCubit>(
            create: (_) => BetSlipCubit()
              ..openBetSlip(
                betSlipGames: [],
              ),
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
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userData = context.select((AuthenticationBloc authenticationBloc) =>
        authenticationBloc.state.user);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        title: Image.asset(
          Images.topLogo,
          fit: BoxFit.contain,
          height: 80,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Balance',
                  style: Styles.h3,
                ),
                Text(
                  '\$100',
                  style: Styles.h3,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FlatButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(
                      AuthenticationLogoutRequested(),
                    );
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
      body: IndexedStack(
        index: pageIndex,
        children: [
          Sportsbook(),
          BetSlip(),
          Leaderboard(),
          OpenBets.route(currentUserId: userData.uid),
          BetHistory(),
        ],
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget bottomNavigation() {
    return BlocBuilder<BetSlipCubit, BetSlipState>(
      builder: (context, state) {
        if (state.status == BetSlipStatus.opened) {
          final showBadge = state.games.isNotEmpty;
          final badgeCount = state.games.length;
          return BottomNavigationBar(
            selectedLabelStyle: GoogleFonts.nunito(),
            selectedFontSize: 10,
            unselectedFontSize: 8,
            elevation: 0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Palette.green,
            unselectedItemColor: Palette.white,
            backgroundColor: Palette.darkGrey,
            currentIndex: pageIndex,
            onTap: onPageChanged,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                  icon: Icon(Feather.home), label: 'Sportsbook'),
              BottomNavigationBarItem(
                  icon: Stack(
                    children: <Widget>[
                      const Icon(Icons.notifications),
                      Positioned(
                        right: 0,
                        child: showBadge
                            ? Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                                child: Text(
                                  '$badgeCount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                  label: 'Bet Slip'
                  // showBadge: showBadge,
                  // badgeCount: badgeCount,
                  ),
              BottomNavigationBarItem(
                  icon: Icon(Feather.globe), label: 'Leaderboard'),
              BottomNavigationBarItem(
                  icon: Icon(Feather.file_text), label: 'Open Bets'),
              BottomNavigationBarItem(
                  icon: Icon(Feather.calendar), label: 'History'),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  void onPageChanged(int pageIndex) {
    setState(
      () {
        this.pageIndex = pageIndex;
      },
    );
  }
}
