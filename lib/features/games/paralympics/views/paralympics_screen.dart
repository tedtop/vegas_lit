import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/palette.dart';
import '../../../../data/repositories/sports_repository.dart';
import '../../../../utils/bottom_bar.dart';
import '../paralympics.dart';
import '../widgets/matchup_card/paralympics_matchup_card.dart';

class ParalympicsScreen extends StatelessWidget {
  const ParalympicsScreen._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => ParalympicsCubit(
            sportsRepository: context.read<SportsRepository>(),
          )..fetchParalympicsGames(),
          child: const ParalympicsScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParalympicsCubit, ParalympicsState>(
      builder: (context, state) {
        switch (state.status) {
          case ParalympicsStatus.initial:
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 120),
              child: Center(
                child: CircularProgressIndicator(
                  color: Palette.cream,
                ),
              ),
            );
            break;
          default:
            if (state.games.isEmpty) {
              return Column(
                children: [
                  Padding(
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
                  ),
                  const BottomBar()
                ],
              );
            } else {
              return ListView.builder(
                key: Key('${state.games.length}'),
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.games.length,
                itemBuilder: (context, index) {
                  return ParalympicsMatchupCard.route(
                    game: state.games[index],
                    gameName: state.league,
                  );
                },
              );
            }
        }
      },
    );
  }
}
