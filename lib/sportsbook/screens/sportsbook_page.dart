import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/bet_slip/bet_slip.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:api_client/api_client.dart';
import 'package:vegas_lit/home/home.dart';
import 'package:vegas_lit/home/widgets/bottombar.dart';
import 'package:vegas_lit/sportsbook/widgets/adaptive_widgets/mobilesportsbook.dart';
import 'package:vegas_lit/sportsbook/widgets/adaptive_widgets/tabletsportsbook.dart';
import 'package:vegas_lit/sportsbook/widgets/adaptive_widgets/websportsbook.dart';

import 'package:vegas_lit/sportsbook/widgets/help_overlay.dart';
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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<SportsbookBloc>().add(
              SportsbookOpen(league: widget.league),
            );
        context.read<BetSlipCubit>()
          ..openBetSlip(
            betSlipGames: [],
          );
      },
      child: Stack(
        children: [
          ListView(
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
                                        SportsbookLeagueChange(
                                            league: newValue),
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
                              // 'GOLF'
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
                    Text(
                      'Local Time: ${formatDate(widget.currentTimeZone)}',
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
          widget.games.isEmpty
              ? Container()
              : Positioned(
                  bottom: 7,
                  right: 6,
                  child: FloatingActionButton(
                    child: const Icon(
                      Icons.help,
                      size: 50,
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

                      await showOverlay(
                          context: context, key1: _key1, key2: _key2);
                    },
                  ),
                )
        ],
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('E, MMMM, c, y @ hh:mm a').format(
      dateTime,
    );
  }
}
