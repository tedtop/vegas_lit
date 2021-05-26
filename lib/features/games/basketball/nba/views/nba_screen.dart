import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/data/repositories/sports_repository.dart';

import '../nba_page.dart';
import 'nba_screen_desktop/nba_screen_desktop.dart';
import 'nba_screen_mobile/nba_screen_mobile.dart';
import 'nba_screen_tablet/nba_screen_tablet.dart';

class NbaScreen extends StatelessWidget {
  const NbaScreen._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => NbaCubit(
            sportsfeedRepository: context.read<SportsRepository>(),
          )..fetchNbaGames(),
          child: const NbaScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NbaCubit, NbaState>(
      builder: (context, state) {
        switch (state.status) {
          case NbaStatus.initial:
            return const Center(
              child: CircularProgressIndicator(
                color: Palette.cream,
              ),
            );
          default:
            if (state.games.isEmpty) {
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
                //key: cardKey,
                breakpoints: const ScreenBreakpoints(
                  desktop: 1000,
                  tablet: 600,
                  watch: 80,
                ),
                mobile: MobileNbaScreen(
                  games: state.games,
                  gameName: state.league,
                  parsedTeamData: state.parsedTeamData,
                ),
                tablet: TabletNbaScreen(
                  parsedTeamData: state.parsedTeamData,
                  games: state.games,
                  gameName: state.league,
                ),
                desktop: DesktopNbaScreen(
                  parsedTeamData: state.parsedTeamData,
                  games: state.games,
                  gameName: state.league,
                ),
              );
            }
        }
      },
    );
  }
}
