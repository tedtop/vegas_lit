import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/data/repositories/sports_repository.dart';
import 'package:vegas_lit/features/games/football/ncaaf/cubit/ncaaf_cubit.dart';

import 'ncaaf_screen_desktop/ncaaf_screen_desktop.dart';
import 'ncaaf_screen_mobile/ncaaf_screen_mobile.dart';
import 'ncaaf_screen_tablet/ncaaf_screen_tablet.dart';

class NcaafScreen extends StatelessWidget {
  const NcaafScreen._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => NcaafCubit(
            sportsfeedRepository: context.read<SportsRepository>(),
          )..fetchNcaafGames(),
          child: const NcaafScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NcaafCubit, NcaafState>(
      builder: (context, state) {
        switch (state.status) {
          case NcaafStatus.initial:
            return const Center(
              child: CircularProgressIndicator(),
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
                mobile: MobileNcaafScreen(
                  games: state.games,
                  gameName: state.league,
                  parsedTeamData: state.parsedTeamData,
                ),
                tablet: TabletNcaafScreen(
                  parsedTeamData: state.parsedTeamData,
                  games: state.games,
                  gameName: state.league,
                ),
                desktop: DesktopNcaafScreen(
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
