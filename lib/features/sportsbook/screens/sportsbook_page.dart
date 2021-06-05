import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../config/assets.dart';
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
import '../../home/widgets/bottombar.dart';
import '../bloc/sportsbook_bloc.dart';

class Sportsbook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SportsbookBloc, SportsbookState>(
      builder: (context, state) {
        switch (state.status) {
          case SportsbookStatus.initial:
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(50),
                child: const Center(
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
                switch (widget.league) {
                  case 'NFL':
                    return NflScreen.route();
                    break;
                  case 'NBA':
                    return NbaScreen.route();
                    break;
                  case 'NHL':
                    return NhlScreen.route();
                    break;
                  case 'NCAAF':
                    return NcaafScreen.route();
                    break;
                  case 'NCAAB':
                    return NcaabScreen.route();
                    break;
                  case 'GOLF':
                    return GolfScreen.route();
                    break;
                  case 'MLB':
                    return MlbScreen.route();
                    break;
                  default:
                    return Container();
                    break;
                }
              },
            ),
            kIsWeb ? const BottomBar() : const SizedBox(),
          ],
        ),
      ),
      floatingActionButton: widget.gameNumberList[widget.league] == '0' ||
              widget.gameNumberList[widget.league] == 'OFF-SEASON'
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
                context.read<BetSlipCubit>().openBetSlip(
                  betSlipGames: [],
                );
              }
            },
            items: <String>[
              'NFL',
              'NBA',
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
  Future<void> showHelp(
      {BuildContext context, GlobalKey key1, GlobalKey key2}) async {
    _overlayEntry = _createOverlayEntry(
      context: context,
    );
    Overlay.of(context).insert(_overlayEntry);
  }

  OverlayEntry _createOverlayEntry({
    BuildContext context,
  }) {
    return OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      final topSafeSpacePadding = MediaQuery.of(context).viewPadding.top;
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Align(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Image.asset(
                  Images.betTypesHelpOverlay,
                  fit: BoxFit.contain,
                  width: size.width,
                ),
              ),
              Positioned(
                  top: topSafeSpacePadding + 108,
                  left: 25,
                  child: Image.asset(Images.sportTypesHelpOverlay,
                      fit: BoxFit.contain, width: 285)),
              Positioned(
                  top: topSafeSpacePadding + 18,
                  right: 22,
                  child: Image.asset(Images.coinBalanceHelpOverlay,
                      fit: BoxFit.contain, width: 300)),
              Positioned(
                  left: size.width / 2 - 110,
                  top: topSafeSpacePadding + 245,
                  child: Image.asset(Images.placeBetHelpOverlay,
                      fit: BoxFit.contain, width: 220)),
              Positioned(
                right: 17,
                top: topSafeSpacePadding + 56,
                child: Image.asset(Images.numberOfBetsHelpOverlay,
                    fit: BoxFit.contain, width: 300),
              )
            ],
          ),
        ),
        onHorizontalDragStart: (_) {
          hideHelp();
        },
        onPanStart: (_) {
          hideHelp();
        },
        onVerticalDragDown: (_) {
          hideHelp();
        },
        onDoubleTap: () {
          hideHelp();
        },
        onDoubleTapDown: (_) {
          hideHelp();
        },
        onLongPress: () {
          hideHelp();
        },
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
