import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../../utils/bottom_bar.dart';
import '../cubit/leaderboard_cubit.dart';
import 'adaptive_leaderboard/desktop_leaderboard.dart';
import 'adaptive_leaderboard/mobile_leaderboard.dart';
import 'adaptive_leaderboard/tablet_leaderboard.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const _LeaderboardTopHeading(),
        BlocBuilder<LeaderboardCubit, LeaderboardState>(
          builder: (context, state) {
            switch (state.status) {
              case LeaderboardStatus.initial:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Palette.cream,
                  ),
                );

              default:
                return Column(
                  children: [
                    ScreenTypeLayout(
                      desktop: DesktopLeaderboard(
                        players: state.rankedUserList,
                      ),
                      tablet: TabletLeaderboard(
                        players: state.rankedUserList,
                      ),
                      mobile: MobileLeaderboard(
                        players: state.rankedUserList,
                      ),
                    ),
                    const BottomBar()
                  ],
                );
            }
          },
        ),
      ],
    );
  }
}

class _LeaderboardTopHeading extends StatelessWidget {
  const _LeaderboardTopHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'LEADERBOARD',
            style: Styles.pageTitle,
          ),
        ),
      ],
    );
  }
}
