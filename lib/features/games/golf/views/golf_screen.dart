import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/palette.dart';
import '../../../../data/repositories/sports_repository.dart';
import '../cubit/golf_cubit.dart';
import '../widgets/golf_matchup.dart';
import '../widgets/golf_tour.dart';
import '../widgets/golf_tour_detail.dart';

class GolfScreen extends StatelessWidget {
  const GolfScreen._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => GolfCubit(
            sportsfeedRepository: context.read<SportsRepository>(),
          )..fetchTournaments(),
          child: const GolfScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GolfCubit, GolfState>(
      builder: (context, state) {
        if (state is GolfInitial) {
          return const Center(
              child: CircularProgressIndicator(
            color: Palette.cream,
          ));
        } else if (state is GolfTournamentsOpened) {
          return GolfTournamentsView(
            tournaments: state.tournaments,
          );
        } else if (state is GolfDetailOpened) {
          return GolfDetailView(
            tournament: state.tournament,
            players: state.players,
          );
        } else if (state is GolfPlayerOpened) {
          return GolfMatchup(
            player: state.player,
            tournamentID: state.tournamentID,
            name: state.name,
            venue: state.venue,
            location: state.location,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
