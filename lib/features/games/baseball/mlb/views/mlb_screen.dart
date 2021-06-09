import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../config/palette.dart';
import '../../../../../data/repositories/sports_repository.dart';
import '../../../../shared_widgets/bottom_bar.dart';
import '../cubit/mlb_cubit.dart';
import 'mlb_screen_desktop/mlb_screen_desktop.dart';
import 'mlb_screen_mobile/mlb_screen_mobile.dart';
import 'mlb_screen_tablet/mlb_screen_tablet.dart';

class MlbScreen extends StatelessWidget {
  const MlbScreen._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => MlbCubit(
            sportsfeedRepository: context.read<SportsRepository>(),
          )..fetchMlbGames(),
          child: const MlbScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MlbCubit, MlbState>(
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
