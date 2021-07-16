import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/features/games/olympics/views/olympics_screen.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../bet_slip/cubit/bet_slip_cubit.dart';
import '../../games/baseball/mlb/mlb_page.dart';
import '../../games/basketball/nba/nba_page.dart';
import '../../games/basketball/ncaab/views/ncaab_screen.dart';
import '../../games/football/ncaaf/views/ncaaf_screen.dart';
import '../../games/football/nfl/views/nfl_screen.dart';
import '../../games/golf/golf_page.dart';
import '../../games/hockey/nhl/views/nhl_screen.dart';
import '../../home/cubit/home_cubit.dart';
import '../bloc/sportsbook_bloc.dart';
import 'help_overlay/help_overlay.dart';

class Sportsbook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SportsbookBloc, SportsbookState>(
      builder: (context, state) {
        switch (state.status) {
          case SportsbookStatus.initial:
            return const Scaffold(
              body: Padding(
                padding: EdgeInsets.all(50),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Palette.cream,
                  ),
                ),
              ),
            );
            break;
          default:
            return SportsBookView(
              league: state.league,
              estTimeZone: state.estTimeZone,
              gameNumberList: state.gameNumbers,
            );
            break;
        }
      },
    );
  }
}

class SportsBookView extends StatefulWidget {
  SportsBookView({
    Key key,
    @required this.league,
    @required this.estTimeZone,
    @required this.gameNumberList,
  })  : assert(league != null),
        assert(gameNumberList != null),
        super(key: key);

  final String league;
  final DateTime estTimeZone;
  final Map gameNumberList;

  @override
  _SportsBookViewState createState() => _SportsBookViewState();
}

class _SportsBookViewState extends State<SportsBookView>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey _key1 = GlobalKey();

  final GlobalKey _key2 = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  final _pageController = PageController(initialPage: 7);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          floatHeaderSlivers: true,
          physics: const AlwaysScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Text(
                      'SPORTSBOOK',
                      textAlign: TextAlign.center,
                      style: Styles.pageTitle,
                    ),
                    ScreenTypeLayout(
                      mobile: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(flex: 2, child: _selectGameDropdown()),
                            kIsWeb
                                ? const SizedBox()
                                : Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<HomeCubit>().homeChange(1);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'BET SLIP',
                                            style: GoogleFonts.nunito(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.cream,
                                            ),
                                          ),
                                          BlocBuilder<BetSlipCubit,
                                              BetSlipState>(
                                            builder: (context, state) {
                                              switch (state.status) {
                                                case BetSlipStatus.opened:
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: Palette.cream,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    height: 40,
                                                    width: 42,
                                                    child: Center(
                                                      child: Text(
                                                        state.betSlipCard.length
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.nunito(
                                                          color:
                                                              Palette.darkGrey,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                  break;
                                                default:
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Palette.cream,
                                                    ),
                                                  );
                                                  break;
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      tablet: Container(
                          padding: const EdgeInsets.all(8.0),
                          constraints: const BoxConstraints(maxWidth: 500),
                          width: 500,
                          child: _selectGameDropdown()),
                      desktop: Container(
                          padding: const EdgeInsets.all(8.0),
                          constraints: const BoxConstraints(
                            maxWidth: 600,
                          ),
                          width: 600,
                          child: _selectGameDropdown()),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'All games are based on Eastern Standard Time',
                            style: Styles.matchupTime,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Eastern Time: ${formatDate(widget.estTimeZone)}',
                            style: Styles.matchupTime,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: RefreshIndicator(
            notificationPredicate: (notif) => notif.depth == 1,
            onRefresh: () async {
              context.read<SportsbookBloc>().add(
                    SportsbookOpen(league: widget.league),
                  );
              context.read<BetSlipCubit>()
                ..openBetSlip(
                  betSlipGames: [],
                );
            },
            color: Palette.cream,
            child: Builder(
              builder: (context) {
                if (_pageController.hasClients ?? false)
                  switch (widget.league) {
                    case 'NFL':
                      _pageController.jumpToPage(0);
                      break;
                    case 'NBA':
                      _pageController.jumpToPage(1);
                      break;
                    case 'NHL':
                      _pageController.jumpToPage(2);
                      break;
                    case 'NCAAF':
                      _pageController.jumpToPage(3);
                      break;
                    case 'NCAAB':
                      _pageController.jumpToPage(4);
                      break;
                    case 'GOLF':
                      _pageController.jumpToPage(5);
                      break;
                    case 'MLB':
                      _pageController.jumpToPage(6);
                      break;
                    case 'OLYMPICS':
                      _pageController.jumpToPage(7);
                      break;
                    default:
                      _pageController.jumpToPage(0);
                      break;
                  }

                return PageView(
                  controller: _pageController,
                  children: [
                    NflScreen.route(),
                    NbaScreen.route(),
                    NhlScreen.route(),
                    NcaafScreen.route(),
                    NcaabScreen.route(),
                    GolfScreen.route(),
                    MlbScreen.route(),
                    OlympicsScreen.route(),
                    Container(),
                  ],
                );
              },
            ),
          ),
        ),
        floatingActionButton: ResponsiveBuilder(
          builder: (context, sizeInfo) {
            if (sizeInfo.isMobile &&
                !kIsWeb &&
                !(widget.gameNumberList[widget.league] == '0') &&
                !(widget.gameNumberList[widget.league] == 'OFF-SEASON')) {
              return FloatingActionButton(
                child: const Icon(
                  Icons.help_outlined,
                  size: 40,
                  color: Palette.cream,
                ),
                onPressed: () async {
                  await _scrollController.animateTo(
                    _scrollController.initialScrollOffset,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );

                  // await Future.delayed(
                  //   const Duration(milliseconds: 300),
                  // );

                  HelpOverlayLoader.appLoader.showLoader();
                },
              );
            }
            return const SizedBox();
          },
        ));
  }

  Widget _selectGameDropdown() => Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Container(
          color: Palette.green,
          padding: const EdgeInsets.all(8.0),
          height: 40,
          //width: double.infinity,
          child: DropdownButton<String>(
            key: _key2,
            dropdownColor: Palette.green,
            isDense: true,
            value: '${widget.league}',
            icon: const Icon(
              Icons.arrow_circle_down,
              color: Palette.cream,
            ),
            iconSize: 25,
            isExpanded: true,
            underline: Container(
              height: 0,
            ),
            style: GoogleFonts.nunito(
              fontSize: 18,
            ),
            onChanged: (String newValue) {
              if (newValue != widget.league) {
                context.read<SportsbookBloc>().add(
                      SportsbookLeagueChange(league: newValue),
                    );
              }
            },
            items: <String>[
              'NFL',
              'NBA',
              'OLYMPICS',
              'MLB',
              'NHL',
              'NCAAF',
              'NCAAB',
              // 'GOLF',
              // 'CRICKET'
            ].map<DropdownMenuItem<String>>(
              (String value) {
                String length;
                widget.gameNumberList.forEach(
                  (key, newValue) {
                    if (key == 'NFL' || key == 'NCAAF' || key == 'GOLF') {
                      length = '$newValue';
                    } else {
                      if (key == value) {
                        length = '$newValue Games';
                      }
                    }
                  },
                );
                return DropdownMenuItem<String>(
                  value: value,
                  child: value == widget.league
                      ? Text('$value ($length)',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Palette.cream,
                          ))
                      : Text(
                          '$value ($length)',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.nunito(
                            color: Palette.cream,
                          ),
                        ),
                );
              },
            ).toList(),
          ),
        ),
      );

  String formatDate(DateTime dateTime) {
    return DateFormat('E, MMMM, c, y @ hh:mm a').format(
      dateTime,
    );
  }
}
