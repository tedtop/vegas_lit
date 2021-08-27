import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../config/palette.dart';
import '../../../../../data/repositories/sports_repository.dart';
import '../../../../../utils/bottom_bar.dart';
import '../cubit/nhl_cubit.dart';
import 'nhl_screen_desktop/nhl_screen_desktop.dart';
import 'nhl_screen_mobile/nhl_screen_mobile.dart';
import 'nhl_screen_tablet/nhl_screen_tablet.dart';

class NhlScreen extends StatelessWidget {
  const NhlScreen._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => NhlCubit(
            sportsfeedRepository: context.read<SportsRepository>(),
          )..fetchNhlGames(),
          child: const NhlScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NhlCubit, NhlState>(
      builder: (context, state) {
        switch (state.status) {
          case NhlStatus.initial:
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
                    breakpoints: const ScreenBreakpoints(
                      desktop: 1000,
                      tablet: 600,
                      watch: 80,
                    ),
                    mobile: MobileNhlScreen(
                      games: state.games,
                      gameName: state.league,
                      parsedTeamData: state.parsedTeamData,
                    ),
                    tablet: TabletNhlScreen(
                      parsedTeamData: state.parsedTeamData,
                      games: state.games,
                      gameName: state.league,
                    ),
                    desktop: DesktopNhlScreen(
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
