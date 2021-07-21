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

  @override
  bool get wantKeepAlive => true;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: RefreshIndicator(
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
          child: ListView(
            controller: _scrollController,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
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
                                    BlocBuilder<BetSlipCubit, BetSlipState>(
                                      builder: (context, state) {
                                        switch (state.status) {
                                          case BetSlipStatus.opened:
                                            return Container(
                                              decoration: BoxDecoration(
                                                color: Palette.cream,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              height: 40,
                                              width: 42,
                                              child: Center(
                                                child: Text(
                                                  state.betSlipCard.length
                                                      .toString(),
                                                  style: GoogleFonts.nunito(
                                                    color: Palette.darkGrey,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            );
                                            break;
                                          default:
                                            return const Center(
                                              child: CircularProgressIndicator(
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
              Builder(
                builder: (context) {
                  var selectedIndex = 7;
                  switch (widget.league) {
                    case 'NFL':
                      selectedIndex = 0;
                      break;
                    case 'NBA':
                      selectedIndex = 1;
                      break;
                    case 'NHL':
                      selectedIndex = 2;
                      break;
                    case 'NCAAF':
                      selectedIndex = 3;
                      break;
                    case 'NCAAB':
                      selectedIndex = 4;
                      break;
                    case 'GOLF':
                      selectedIndex = 5;
                      break;
                    case 'MLB':
                      selectedIndex = 6;
                      break;
                    case 'OLYMPICS':
                      selectedIndex = 7;
                      break;
                    default:
                      selectedIndex = 8;
                      break;
                  }
                  return FadeIndexedStack(
                    index: selectedIndex,
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
            ],
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

class FadeIndexedStack extends StatefulWidget {
  const FadeIndexedStack({
    Key key,
    this.index,
    this.children,
    this.duration = const Duration(
      milliseconds: 800,
    ),
  }) : super(key: key);

  final int index;
  final List<Widget> children;
  final Duration duration;

  @override
  _FadeIndexedStackState createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: IndexedStack(
        index: widget.index,
        children: widget.children,
      ),
    );
  }
}
