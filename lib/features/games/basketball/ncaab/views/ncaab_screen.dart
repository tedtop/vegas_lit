import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../config/palette.dart';
import '../../../../../data/repositories/sports_repository.dart';
import '../cubit/ncaab_cubit.dart';
import 'ncaab_screen_desktop/ncaab_screen_desktop.dart';
import 'ncaab_screen_mobile/ncaab_screen_mobile.dart';
import 'ncaab_screen_tablet/ncaab_screen_tablet.dart';

class NcaabScreen extends StatelessWidget {
  const NcaabScreen._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => NcaabCubit(
            sportsfeedRepository: context.read<SportsRepository>(),
          )..fetchNcaabGames(),
          child: const NcaabScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NcaabCubit, NcaabState>(
      builder: (context, state) {
        switch (state.status) {
          case NcaabStatus.initial:
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 120),
              child: Center(
                child: CircularProgressIndicator(
                  color: Palette.cream,
                ),
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
                mobile: MobileNcaabScreen(
                  games: state.games,
                  gameName: state.league,
                  parsedTeamData: state.parsedTeamData,
                ),
                tablet: TabletNcaabScreen(
                  parsedTeamData: state.parsedTeamData,
                  games: state.games,
                  gameName: state.league,
                ),
                desktop: DesktopNcaabScreen(
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
