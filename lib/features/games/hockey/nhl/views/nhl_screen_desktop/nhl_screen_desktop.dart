import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/palette.dart';
import '../../../../../../data/models/nhl/nhl_game.dart';
import '../../../../../bet_slip/bet_slip.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class DesktopNhlScreen extends StatelessWidget {
  DesktopNhlScreen({this.gameName, this.games, this.parsedTeamData});
  final List<NhlGame> games;
  final String gameName;
  final dynamic parsedTeamData;
  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    final betSlipState = context.watch<BetSlipCubit>().state;
    return
        // Container(
        //   constraints: BoxConstraints(maxWidth: 800, minWidth: 700),
        //   child:
        FittedBox(
      fit: BoxFit.scaleDown,
      // width: width < 1200 ? width : 1200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanded(child: Container()),
          Container(
            constraints: const BoxConstraints(maxWidth: 800, minWidth: 700),
            child: GridView.count(
                childAspectRatio: 1.5,
                crossAxisCount: 2,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: games
                    .map(
                      (game) => MatchupCard.route(
                          game: game,
                          gameName: gameName,
                          parsedTeamData: parsedTeamData),
                    )
                    .toList()),
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 5),
                        height: 38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Palette.green,
                        ),
                        child: Center(
                          child: Text(
                            'BET SLIP',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Palette.cream,
                            ),
                          ),
                        ),
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
                                  state.betSlipCard.length.toString(),
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
                            return const CircularProgressIndicator(
                              color: Palette.cream,
                            );
                            break;
                        }
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
                BlocBuilder<BetSlipCubit, BetSlipState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case BetSlipStatus.opened:
                        return state.betSlipCard.isEmpty
                            ? AbstractCard(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                widgets: [
                                  Text(
                                    'Your Bet List is\ncurrently Empty.',
                                    style: GoogleFonts.nunito(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Palette.cream),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  textPoints(
                                    '1. Find a game you are interested in',
                                  ),
                                  textPoints(
                                    '2. Click on the link you\'d like to bet on',
                                  ),
                                  textPoints(
                                    // ignore: lines_longer_than_80_chars
                                    '3. Your bet will show up in this area where you can place your bet',
                                  ),
                                ],
                              )
                            : ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: betSlipState.betSlipCard.length,
                                itemBuilder: (context, index) {
                                  return betSlipState.betSlipCard[index];
                                },
                              );
                        break;
                      default:
                        return const CircularProgressIndicator(
                          color: Palette.cream,
                        );
                        break;
                    }
                  },
                ),
              ],
            ),
          ),
          //  Expanded(child: Container()),
        ],
      ),
      // ),
    );
  }

  Widget textPoints(String text) {
    return Column(
      children: [
        Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w200,
            color: Palette.cream,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class AbstractCard extends StatelessWidget {
  const AbstractCard({
    Key key,
    @required this.widgets,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12.5,
      vertical: 12.0,
    ),
  }) : super(key: key);

  final List<Widget> widgets;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        width: 390,
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.cream,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          color: Palette.lightGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: crossAxisAlignment,
                children: widgets,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
