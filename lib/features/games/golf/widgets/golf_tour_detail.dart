

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/golf/golf.dart';
import '../golf_page.dart';

class GolfDetailView extends StatefulWidget {
  GolfDetailView({this.players, this.tournament});
  final GolfTournament? tournament;
  final List<GolfPlayer>? players;
  @override
  _GolfDetailViewState createState() => _GolfDetailViewState();
}

class _GolfDetailViewState extends State<GolfDetailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          const SizedBox(
            width: 15,
          ),
          IconButton(
              padding: const EdgeInsets.all(10),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                context.read<GolfCubit>().fetchTournaments();
              }),
          Expanded(
              child: Center(
            child: Text(
              widget.tournament!.name!,
              style: Styles.greenTextBold.copyWith(fontSize: 24),
            ),
          ))
        ]),
        GolfTournamentDetailCard(
          tournament: widget.tournament,
          players: widget.players,
        ),
      ],
    );
  }
}

class GolfTournamentDetailCard extends StatelessWidget {
  GolfTournamentDetailCard({this.tournament, this.players});
  final GolfTournament? tournament;
  final List<GolfPlayer>? players;
  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            width: 360,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Palette.cream,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Palette.lightGrey),
            child: Column(
              children: [
                Text(
                  'Tournament ID: ${tournament!.tournamentId}',
                  style: Styles.normalTextBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Start Date: ${tournament!.startDate!.day}-${DateFormat.MMMM().format(tournament!.startDate!)}-${tournament!.startDate!.year}',
                  style: Styles.normalText,
                ),
                Text(
                  'End Date: ${tournament!.endDate!.day}-${DateFormat.MMMM().format(tournament!.endDate!)}-${tournament!.endDate!.year}',
                  style: Styles.normalText,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Venue:',
                  style: Styles.greenTextBold,
                ),
                Text(
                  '${tournament!.venue ?? 'NA'}',
                  style: Styles.awayTeam,
                ),
                Text(
                  '${tournament!.location ?? 'NA'}',
                  style: Styles.awayTeam,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GolfStyledBox(
                      child: Text(
                        'Par: ${tournament!.par ?? 'NA'}',
                        style: Styles.normalTextBold,
                      ),
                    ),
                    GolfStyledBox(
                      child: Text(
                        'Yards: ${tournament!.yards ?? 'NA'}',
                        style: Styles.normalTextBold,
                      ),
                    ),
                    GolfStyledBox(
                      child: Text(
                        'Purse: ${tournament!.purse ?? 'NA'}',
                        style: Styles.normalTextBold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
                tournament!.isInProgress!
                    ? Text(
                        'This tournament is in progress!',
                        style: Styles.largeTextBold,
                        textAlign: TextAlign.center,
                      )
                    : (tournament!.isOver!
                        ? Text(
                            'This tournament is over!',
                            style: Styles.largeTextBold,
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            'This tournament has not started yet!',
                            style: Styles.largeTextBold,
                            textAlign: TextAlign.center,
                          ))
              ],
            ),
          ),
          players!.isNotEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Text(
                    'Players',
                    style: Styles.pageTitle,
                  ),
                )
              : const SizedBox(),
          ...players!
              .map((player) => InkWell(
                    onTap: () {
                      BlocProvider.of<GolfCubit>(context).fetchPlayerDetails(
                          player: player, tournament: tournament!);
                    },
                    child: Container(
                      width: 360,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Palette.lightGrey,
                        border: Border.all(color: Palette.cream),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${player.name}',
                            style: Styles.normalTextBold,
                          ),
                          Text(
                            '${player.country}',
                            style: Styles.normalText,
                          ),
                          Text(
                            'Rank: ${player.rank ?? 'N/A'}',
                            style: Styles.greenTextBold,
                          ),
                          Text(
                            'Total Score: ${player.totalScore}',
                            style: Styles.greenTextBold,
                          ),
                          Text(
                            'Total Strokes: ${player.totalStrokes}',
                            style: Styles.greenTextBold,
                          )
                        ],
                      ),
                    ),
                  ))
              .toList()
        ]);
  }
}

class GolfStyledBox extends StatelessWidget {
  GolfStyledBox({this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
          color: Palette.green, borderRadius: BorderRadius.circular(5)),
      child: child,
    );
  }
}
