import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/golf.dart';
import '../golf_page.dart';

class GolfTournamentsView extends StatefulWidget {
  GolfTournamentsView({this.tournaments});
  final List<GolfTournament> tournaments;
  @override
  _GolfTournamentsViewState createState() => _GolfTournamentsViewState();
}

class _GolfTournamentsViewState extends State<GolfTournamentsView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: widget.tournaments.map((tournament) {
        return GolfTournamentCard(tournament: tournament);
      }).toList(),
    );
  }
}

class GolfTournamentCard extends StatelessWidget {
  GolfTournamentCard({@required this.tournament})
      : assert(tournament != null),
        tournamentName = tournament.name,
        venue = tournament.venue,
        location = tournament.location,
        startDate = tournament.startDate,
        endDate = tournament.endDate,
        purse = tournament.purse;

  final GolfTournament tournament;
  final String tournamentName, venue, location;
  final DateTime startDate, endDate;
  final int purse;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<GolfCubit>()
            .fetchTournamentDetails(tournamentID: tournament.tournamentId);
        // BlocProvider.of<SportsbookBloc>(context)
        //     .add(GolfDetailOpen(tournamentID: tournament.tournamentId));
      },
      child: Container(
        height: 170,
        width: 380,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(
              color: Palette.cream,
            ),
            borderRadius: BorderRadius.circular(12),
            color: Palette.lightGrey),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Row(
            children: [
              Container(
                height: 150,
                width: 220,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Palette.green),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tournamentName,
                      style: Styles.normalTextBold,
                    ),
                    Text(
                      venue ?? '',
                      style: Styles.normalText.copyWith(fontSize: 14),
                    ),
                    Text(
                      location ?? '',
                      style: Styles.normalText.copyWith(fontSize: 14),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 150,
                //width: 135,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Palette.darkGrey),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${startDate.day} ${DateFormat.MMM().format(startDate)}-${endDate.day} ${DateFormat.MMM().format(endDate)}, ${endDate.year}',
                      style: Styles.normalText.copyWith(fontSize: 12),
                    ),
                    Text(
                      'Watch on CBS, GOLF',
                      style: Styles.normalTextBold.copyWith(fontSize: 12),
                    ),
                    Text(
                      'Purse \$$purse',
                      style: Styles.normalTextBold.copyWith(fontSize: 14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
