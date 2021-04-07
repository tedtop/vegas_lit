import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:vegas_lit/bet_slip/bet_slip.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:api_client/api_client.dart';
import 'package:vegas_lit/home/home.dart';
import 'package:vegas_lit/sportsbook/widgets/matchup_card/matchup_card.dart';
import '../bloc/sportsbook_bloc.dart';

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
        if (state is SportsbookOpened) {
          return SportsBookView(
            games: state.games,
            gameName: state.gameName,
            currentTimeZone: state.currentTimeZone,
            estTimeZone: state.estTimeZone,
            gameNumberList: state.gameNumbers,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class SportsBookView extends StatelessWidget {
  const SportsBookView({
    Key key,
    @required this.games,
    @required this.gameName,
    @required this.estTimeZone,
    @required this.gameNumberList,
    @required this.currentTimeZone,
  })  : assert(games != null),
        assert(gameName != null),
        assert(currentTimeZone != null),
        assert(gameNumberList != null),
        super(key: key);

  final List<Game> games;
  final String gameName;
  final DateTime estTimeZone;
  final DateTime currentTimeZone;
  final Map gameNumberList;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<SportsbookBloc>().add(
              SportsbookOpen(gameName: gameName),
            );
        context.read<BetSlipCubit>()
          ..openBetSlip(
            betSlipGames: [],
          );
      },
      child: ListView(
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
                        dropdownColor: Palette.green,
                        isDense: true,
                        value: '$gameName',
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
                          if (newValue != gameName) {
                            context.read<SportsbookBloc>().add(
                                  SportsbookOpen(gameName: newValue),
                                );
                          }
                        },
                        items: <String>[
                          'NFL',
                          'NBA',
                          'MLB',
                          'NHL',
                          'NCAAF',
                          'NCAAB'
                        ].map<DropdownMenuItem<String>>(
                          (String value) {
                            String length;
                            gameNumberList.forEach(
                              (key, newValue) {
                                if (key == 'NFL' || key == 'NCAAF') {
                                  length = '$newValue';
                                } else {
                                  key == value
                                      ? length = '$newValue Games'
                                      : null;
                                }
                              },
                            );
                            return DropdownMenuItem<String>(
                              value: value,
                              child: value == gameName
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
                        BlocBuilder<BetSlipCubit, BetSlipState>(
                          builder: (context, state) {
                            switch (state.status) {
                              case BetSlipStatus.opened:
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Palette.cream,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  height: 40,
                                  width: 42,
                                  child: Center(
                                    child: Text(
                                      state.betSlipCardData.length.toString(),
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
                  'Local Time: ${formatDate(currentTimeZone)}',
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
                  'Eastern Time: ${formatDate(estTimeZone)}',
                  style: Styles.matchupTime,
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) {
              if (games.isEmpty) {
                return Center(
                  child: Text(
                    'No Games Scheduled Today!',
                    style: GoogleFonts.nunito(
                      color: Palette.cream,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    return MatchupCard.route(
                      game: games[index],
                      gameName: gameName,
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('EEEE, MMMM, c, y @ hh:mm a').format(
      dateTime,
    );
  }
}
