import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../bet_slip/cubit/bet_slip_cubit.dart';
import '../../drawer_pages/rules_dialog.dart';
import '../../games/baseball/mlb/mlb_page.dart';
import '../../games/basketball/nba/nba_page.dart';
import '../../games/basketball/ncaab/views/ncaab_screen.dart';
import '../../games/football/ncaaf/views/ncaaf_screen.dart';
import '../../games/football/nfl/views/nfl_screen.dart';
import '../../games/golf/golf_page.dart';
import '../../games/hockey/nhl/views/nhl_screen.dart';
import '../../games/olympics/olympics.dart';
import '../../games/paralympics/paralympics.dart';
import '../../home/cubit/home_cubit.dart';
import '../cubit/sportsbook_cubit.dart';

class Sportsbook extends StatefulWidget {
  const Sportsbook({Key? key}) : super(key: key);

  @override
  State<Sportsbook> createState() => _SportsbookState();
}

class _SportsbookState extends State<Sportsbook>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<SportsbookCubit, SportsbookState>(
      listener: (context, state) {
        if (state.status == SportsbookStatus.initial) {
          if (!state.isRulesShown) {
            Navigator.push<void>(
              context,
              RulesDialog.route(),
            );
          }
        }
      },
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
          case SportsbookStatus.opened:
            return SportsBookView();
        }
      },
    );
  }
}

class SportsBookView extends StatelessWidget {
  SportsBookView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sportsbookState = context.read<SportsbookCubit>().state;
    final betSlipLength = context
        .select((BetSlipCubit cubit) => cubit.state.betDataList?.length ?? 0);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BetSlipCubit>().openBetSlip(
            singleBetSlipGames: [],
            parlayBetSlipGames: [],
            betDataList: [],
          );
          await context
              .read<SportsbookCubit>()
              .sportsbookOpen(league: sportsbookState.league);
        },
        color: Palette.cream,
        child: ListView(
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
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 4,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Container(
                          color: Palette.green,
                          padding: const EdgeInsets.all(8),
                          height: 40,
                          child: DropdownWidgetHome(),
                        ),
                      ),
                    ),
                    if (kIsWeb)
                      const SizedBox()
                    else
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.read<HomeCubit>().homeChange(1);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'BET SLIP',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.cream,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Palette.cream,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                height: 40,
                                width: 42,
                                child: Center(
                                  child: Text(
                                    betSlipLength.toString(),
                                    style: GoogleFonts.nunito(
                                      color: Palette.darkGrey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              tablet: Container(
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(maxWidth: 500),
                width: 500,
                child: Card(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Container(
                    color: Palette.green,
                    padding: const EdgeInsets.all(8),
                    height: 40,
                    child: DropdownWidgetHome(),
                  ),
                ),
              ),
              desktop: Container(
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                width: 600,
                child: Card(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Container(
                    color: Palette.green,
                    padding: const EdgeInsets.all(8),
                    height: 40,
                    child: DropdownWidgetHome(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context
                          .read<SportsbookCubit>()
                          .updateLeagueLength(league: 'MLB', length: 5);
                      print('Done');
                    },
                    child: Text(
                      'All games are based on Eastern Standard Time',
                      style: Styles.matchupTime,
                    ),
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
                    'Eastern Time: ${formatDate(sportsbookState.estTimeZone!)}',
                    style: Styles.matchupTime,
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                var selectedIndex = 7;
                switch (sportsbookState.league) {
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
                  case 'PARALYMPICS':
                    selectedIndex = 7;
                    break;
                  case 'OLYMPICS':
                    selectedIndex = 8;
                    break;
                  default:
                    selectedIndex = 9;
                }
                return FadeIndexedStack(
                  index: selectedIndex,
                  children: [
                    Visibility(
                      maintainState: true,
                      visible: selectedIndex == 0,
                      child: NflScreen.route(),
                    ),
                    Visibility(
                      maintainState: true,
                      visible: selectedIndex == 1,
                      child: NbaScreen.route(),
                    ),
                    Visibility(
                      maintainState: true,
                      visible: selectedIndex == 2,
                      child: NhlScreen.route(),
                    ),
                    Visibility(
                      maintainState: true,
                      visible: selectedIndex == 3,
                      child: NcaafScreen.route(),
                    ),
                    Visibility(
                      maintainState: true,
                      visible: selectedIndex == 4,
                      child: NcaabScreen.route(),
                    ),
                    Visibility(
                      maintainState: true,
                      visible: selectedIndex == 5,
                      child: GolfScreen.route(),
                    ),
                    Visibility(
                      maintainState: true,
                      visible: selectedIndex == 6,
                      child: MlbScreen.route(),
                    ),
                    Visibility(
                      maintainState: true,
                      visible: selectedIndex == 7,
                      child: ParalympicsScreen.route(),
                    ),
                    Visibility(
                      maintainState: true,
                      visible: selectedIndex == 8,
                      child: OlympicsScreen.route(),
                    ),
                    Visibility(
                      maintainState: true,
                      visible: selectedIndex == 9,
                      child: Container(),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: ResponsiveBuilder(
        builder: (context, sizeInfo) {
          if (sizeInfo.isMobile && !kIsWeb) {
            return FloatingActionButton(
              onPressed: _launchTutorialVideo,
              child: const Icon(
                Icons.help_outlined,
                size: 40,
                color: Palette.cream,
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  static const _tutorialVideoUrl =
      'https://www.youtube.com/watch?v=LX2sJuqDWn0';
  Future<void> _launchTutorialVideo() async =>
      await canLaunch(_tutorialVideoUrl)
          ? await launch(_tutorialVideoUrl)
          : throw TutorialVideoUrlFailure();

  String formatDate(DateTime dateTime) {
    return DateFormat('E, MMMM, c, y @ hh:mm a').format(
      dateTime,
    );
  }
}

class DropdownWidgetHome extends StatefulWidget {
  DropdownWidgetHome({
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownWidgetHome> createState() => _DropdownWidgetHomeState();
}

class _DropdownWidgetHomeState extends State<DropdownWidgetHome> {
  List list = <String>[
    'NFL',
    'NBA',
    // 'OLYMPICS',
    // 'PARALYMPICS',
    'MLB',
    'NHL',
    'NCAAF',
    'NCAAB',
    // 'GOLF',
    // 'CRICKET'
  ];

  @override
  Widget build(BuildContext context) {
    final sportsbookState = context.read<SportsbookCubit>().state;
    return DropdownButton<String>(
      dropdownColor: Palette.green,
      isDense: true,
      value: sportsbookState.league,
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
      onChanged: (String? newValue) {
        setState(() {
          list = <String>[
            'NFL',
            'NBA',
            'OLYMPICS',
            'PARALYMPICS',
            'MLB',
            'NHL',
            'NCAAF',
            'NCAAB',
            // 'GOLF',
            // 'CRICKET'
          ];
        });
        if (newValue != sportsbookState.league) {
          context
              .read<SportsbookCubit>()
              .sportsbookLeagueChange(league: newValue);
        }
      },
      items: sportsbookState.dropdown,
    );
  }
}

class FadeIndexedStack extends StatefulWidget {
  const FadeIndexedStack({
    Key? key,
    this.index,
    this.children,
    this.duration = const Duration(
      milliseconds: 800,
    ),
  }) : super(key: key);

  final int? index;
  final List<Widget>? children;
  final Duration duration;

  @override
  _FadeIndexedStackState createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0);
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
        children: widget.children!,
      ),
    );
  }
}

class TutorialVideoUrlFailure implements Exception {}
