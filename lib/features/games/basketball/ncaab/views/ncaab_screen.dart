import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../config/palette.dart';
import '../../../../../data/repositories/sport_repository.dart';
import '../../../../../utils/bottom_bar.dart';
import '../../../../sportsbook/sportsbook.dart';
import '../cubit/ncaab_cubit.dart';
import 'ncaab_screen_desktop/ncaab_screen_desktop.dart';
import 'ncaab_screen_mobile/ncaab_screen_mobile.dart';
import 'ncaab_screen_tablet/ncaab_screen_tablet.dart';

class NcaabScreen extends StatelessWidget {
  const NcaabScreen._({Key? key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => NcaabCubit(
            sportsfeedRepository: context.read<SportRepository>(),
          )..fetchNcaabGames(),
          child: const NcaabScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NcaabCubit, NcaabState>(
      listener: (context, state) {
        if (state.status == NcaabStatus.opened) {
          if (state.games.length is int) {
            context.read<SportsbookCubit>().updateLeagueLength(
                  league: state.league,
                  length: state.games.length,
                );
          }
        }
      },
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
                    mobile: MobileNcaabScreen(
                      games: state.games,
                      gameName: state.league,
                      teamData: state.teamData,
                    ),
                    tablet: TabletNcaabScreen(
                      teamData: state.teamData,
                      games: state.games,
                      gameName: state.league,
                    ),
                    desktop: DesktopNcaabScreen(
                      teamData: state.teamData,
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
