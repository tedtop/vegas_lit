import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../config/palette.dart';
import '../../../../../data/repositories/sport_repository.dart';
import '../../../../../utils/bottom_bar.dart';
import '../../../../sportsbook/sportsbook.dart';
import '../nba_page.dart';
import 'nba_screen_desktop/nba_screen_desktop.dart';
import 'nba_screen_mobile/nba_screen_mobile.dart';
import 'nba_screen_tablet/nba_screen_tablet.dart';

class NbaScreen extends StatelessWidget {
  const NbaScreen._({Key? key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => NbaCubit(
            sportsfeedRepository: context.read<SportRepository>(),
          )..fetchNbaGames(),
          child: const NbaScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NbaCubit, NbaState>(
      listener: (context, state) {
        if (state.status == NbaStatus.opened) {
          if (state.games!.length is int) {
            context.read<SportsbookCubit>().updateLeagueLength(
                  league: state.league,
                  length: state.games!.length,
                );
          }
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case NbaStatus.initial:
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
