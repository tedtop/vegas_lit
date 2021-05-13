import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/bet_slip/bet_slip.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:api_client/api_client.dart';
import 'package:vegas_lit/home/home.dart';
import 'package:vegas_lit/home/widgets/bottombar.dart';
import 'package:vegas_lit/sportsbook/widgets/adaptive_widgets/mobilesportsbook.dart';
import 'package:vegas_lit/sportsbook/widgets/adaptive_widgets/tabletsportsbook.dart';
import 'package:vegas_lit/sportsbook/widgets/adaptive_widgets/websportsbook.dart';

import '../bloc/sportsbook_bloc.dart';
import 'golf_screens/golf_matchup.dart';
import 'golf_screens/golf_tour.dart';
import 'golf_screens/golf_tour_detail.dart';

class Sportsbook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SportsbookBloc, SportsbookState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        // if (state is SportsbookOpened) {
        //   Navigator.of(context).push<void>(
        //     Interstitial.route(),
        //   );
        // }
      },
      builder: (context, state) {
        switch (state.status) {
          case SportsbookStatus.initial:
            return const Center(
              child: CircularProgressIndicator(),
            );
            break;
          default:
            return SportsBookView(
              games: state.games,
              league: state.league,
              currentTimeZone: state.localTimeZone,
              estTimeZone: state.estTimeZone,
              gameNumberList: state.gameNumbers,
              parsedTeamData: state.parsedTeamData,
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
    @required this.games,
    @required this.league,
    @required this.estTimeZone,
    @required this.gameNumberList,
    @required this.currentTimeZone,
    @required this.parsedTeamData,
  })  : assert(games != null),
        assert(league != null),
        assert(currentTimeZone != null),
        assert(gameNumberList != null),
        super(key: key);

  final List<Game> games;
  final String league;
  final DateTime estTimeZone;
  final dynamic parsedTeamData;
  final DateTime currentTimeZone;
  final Map gameNumberList;

  @override
  _SportsBookViewState createState() => _SportsBookViewState();
}

class _SportsBookViewState extends State<SportsBookView> {
  final GlobalKey _key1 = GlobalKey();

  final GlobalKey _key2 = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  OverlayEntry _overlayEntry;
  @override
  Widget build(BuildContext context) {
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
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: [
            Text(
              'SPORTSBOOK',
              textAlign: TextAlign.center,
              style: Styles.pageTitle,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                        padding: const EdgeInsets.all(8.0),
                        height: 40,
                        width: double.infinity,
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
                              if (newValue == 'GOLF') {
                                context.read<SportsbookBloc>().add(
                                      GolfTournamentsOpen(),
                                    );
                                context.read<BetSlipCubit>().openBetSlip(
                                  betSlipGames: [],
                                );
                              } else {
                                context.read<SportsbookBloc>().add(
                                      SportsbookLeagueChange(league: newValue),
                                    );
                                context.read<BetSlipCubit>().openBetSlip(
                                  betSlipGames: [],
                                );
                              }
                            }
                          },
                          items: <String>[
                            'NFL',
                            'NBA',
                            'MLB',
                            'NHL',
                            'NCAAF',
                            'NCAAB',
                            //'GOLF'
                          ].map<DropdownMenuItem<String>>(
                            (String value) {
                              String length;
                              widget.gameNumberList.forEach(
                                (key, newValue) {
                                  if (key == 'NFL' ||
                                      key == 'NCAAF' ||
                                      key == 'GOLF') {
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
                    ),
                  ),
                  kIsWeb
                      ? const SizedBox()
                      : Expanded(
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
                                              state.betSlipCardData.length
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
                                        return const CircularProgressIndicator();
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   'Local Time: ${formatDate(widget.currentTimeZone)}',
                  //   style: Styles.matchupTime,
                  // ),
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
                final sportsbookState = context.watch<SportsbookBloc>().state;
                switch (sportsbookState.status) {
                  case SportsbookStatus.golfOpen:
                    return GolfTournamentsView(
                      tournaments: sportsbookState.tournaments,
                    );
                    break;
                  case SportsbookStatus.golfPlayerOpened:
                    return GolfMatchup(
                      player: sportsbookState.player,
                      tournamentID: sportsbookState.tournamentID,
                      name: sportsbookState.name,
                      venue: sportsbookState.venue,
                      location: sportsbookState.location,
                    );
                    break;
                  case SportsbookStatus.golfDetailOpen:
                    return GolfDetailView(
                      tournament: sportsbookState.tournament,
                      players: sportsbookState.players,
                    );
                    break;
                  case SportsbookStatus.loading:
                    return Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 180),
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                    break;
                  default:
                    if (widget.games.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 120),
                        child: Text(
                          // ignore: lines_longer_than_80_chars
                          'No odds available for the league you have selected at this time.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            color: Palette.cream,
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    } else {
                      return ScreenTypeLayout(
                        key: _key1,
                        breakpoints: const ScreenBreakpoints(
                          desktop: 1000,
                          tablet: 600,
                          watch: 80,
                        ),
                        mobile: MobileSportsbook(
                          games: widget.games,
                          gameName: widget.league,
                          parsedTeamData: widget.parsedTeamData,
                        ),
                        tablet: TabletSportsbook(
                          parsedTeamData: widget.parsedTeamData,
                          games: widget.games,
                          gameName: widget.league,
                        ),
                        desktop: WebSportsbook(
                          parsedTeamData: widget.parsedTeamData,
                          games: widget.games,
                          gameName: widget.league,
                        ),
                      );
                    }
                }
              },
            ),
            kIsWeb ? const BottomBar() : const SizedBox(),
          ],
        ),
      ),
      floatingActionButton: widget.games.isEmpty
          ? Container()
          : FloatingActionButton(
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

                await Future.delayed(
                  const Duration(milliseconds: 300),
                );

                await showHelp(context: context, key1: _key1, key2: _key2);
              },
            ),
    );
  }

  Future<void> showHelp(
      {BuildContext context, GlobalKey key1, GlobalKey key2}) async {
    _overlayEntry =
        _createOverlayEntry(context: context, key1: key1, key2: key2);
    Overlay.of(context).insert(_overlayEntry);
  }

  OverlayEntry _createOverlayEntry(
      {BuildContext context, GlobalKey key1, GlobalKey key2}) {
    final RenderBox currentRenderObject1 =
        key1.currentContext.findRenderObject();
    final RenderBox currentRenderObject2 =
        key2.currentContext.findRenderObject();

    final betTypesOverlay =
        currentRenderObject1.localToGlobal(const Offset(0, 0));
    final sportsTypesOverlay =
        currentRenderObject2.localToGlobal(const Offset(0, 0));

    return OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      final topSafeSpacePadding = MediaQuery.of(context).viewPadding.top;
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Align(
          alignment: Alignment.center,
          child: Stack(children: [
            Positioned(
              //BET TYPES
              top: betTypesOverlay.dy + 100,
              child: Image.asset(
                Images.betTypesHelpOverlay,
                fit: BoxFit.contain,
                width: size.width,
              ),
            ),
            Positioned(
                //typeOfSports
                top: topSafeSpacePadding + 15,
                left: 25,
                child: Image.asset(
                  Images.sportTypesHelpOverlay,
                  fit: BoxFit.contain,
                  height: sportsTypesOverlay.dy - topSafeSpacePadding,
                )),
            Positioned(
                //coin Balance
                top: topSafeSpacePadding + 15,
                right: 50,
                child: Image.asset(
                  Images.coinBalanceHelpOverlay,
                  fit: BoxFit.contain,
                  height: 60,
                )),
            Positioned(
                //Placing a bet
                left: size.width * 0.3,
                top: topSafeSpacePadding + 15,
                child: Image.asset(
                  Images.placeBetHelpOverlay,
                  fit: BoxFit.contain,
                  height: betTypesOverlay.dy + 130, //TRICKY
                )),
            Positioned(
                //Number of bets
                right: 40,
                top: topSafeSpacePadding + 75,
                child: Image.asset(
                  Images.numberOfBetsHelpOverlay,
                  fit: BoxFit.contain,
                  height:
                      sportsTypesOverlay.dy - topSafeSpacePadding - 55, //TRICKY
                ))
          ]),
        ),
        onTap: () {
          hideHelp();
        },
      );
    });
  }

  void hideHelp() {
    _overlayEntry.remove();
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('E, MMMM, c, y @ hh:mm a').format(
      dateTime,
    );
  }
}
