import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../config/palette.dart';
import '../../../../../data/repositories/sport_repository.dart';
import '../../../../../utils/bottom_bar.dart';
import '../../../../sportsbook/sportsbook.dart';
import '../cubit/mlb_cubit.dart';
import 'mlb_screen_desktop/mlb_screen_desktop.dart';
import 'mlb_screen_mobile/mlb_screen_mobile.dart';
import 'mlb_screen_tablet/mlb_screen_tablet.dart';

class MlbScreen extends StatelessWidget {
  const MlbScreen._({Key? key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => MlbCubit(
            sportsfeedRepository: context.read<SportRepository>(),
          )..fetchMlbGames(),
          child: const MlbScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MlbCubit, MlbState>(
      listener: (context, state) {
        if (state.status == MlbStatus.opened) {
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
          case MlbStatus.initial:
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 120),
              child: Center(
                child: CircularProgressIndicator(
                  color: Palette.cream,
                ),
              ),
            );
          case MlbStatus.opened:
            if (state.games!.isEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 120),
                    child: Text(
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
                    mobile: MobileMlbScreen(
                      games: state.games,
                      gameName: state.league,
                      parsedTeamData: state.parsedTeamData,
                    ),
                    tablet: TabletMlbScreen(
                      parsedTeamData: state.parsedTeamData,
                      games: state.games,
                      gameName: state.league,
                    ),
                    desktop: DesktopMlbScreen(
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
