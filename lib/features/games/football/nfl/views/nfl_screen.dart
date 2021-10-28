

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../config/palette.dart';
import '../../../../../data/repositories/sports_repository.dart';
import '../../../../../utils/bottom_bar.dart';
import '../cubit/nfl_cubit.dart';
import 'nfl_screen_desktop/nfl_screen_desktop.dart';
import 'nfl_screen_mobile/nfl_screen_mobile.dart';
import 'nfl_screen_tablet/nfl_screen_tablet.dart';

class NflScreen extends StatelessWidget {
  const NflScreen._({Key? key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => NflCubit(
            sportsfeedRepository: context.read<SportsRepository>(),
          )..fetchNflGames(),
          child: const NflScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NflCubit, NflState>(
      builder: (context, state) {
        switch (state.status) {
          case NflStatus.initial:
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 120),
              child: Center(
                child: CircularProgressIndicator(
                  color: Palette.cream,
                ),
              ),
            );
          default:
            if (state.games!.isEmpty) {
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
              return Column(
                children: [
                  ScreenTypeLayout(
                    //key: cardKey,
                    breakpoints: const ScreenBreakpoints(
                      desktop: 1000,
                      tablet: 600,
                      watch: 80,
                    ),
                    mobile: MobileNflScreen(
                      games: state.games,
                      gameName: state.league,
                      parsedTeamData: state.parsedTeamData,
                    ),
                    tablet: TabletNflScreen(
                      parsedTeamData: state.parsedTeamData,
                      games: state.games,
                      gameName: state.league,
                    ),
                    desktop: DesktopNflScreen(
                      parsedTeamData: state.parsedTeamData,
                      games: state.games,
                      gameName: state.league,
                    ),
                  ),
                  const BottomBar()
                ],
              );
            }
        }
      },
    );
  }
}
