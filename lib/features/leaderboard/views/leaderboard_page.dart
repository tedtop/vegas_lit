import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/home/widgets/bottombar.dart';
import 'package:vegas_lit/features/leaderboard/cubit/leaderboard_cubit.dart';
import 'package:vegas_lit/features/leaderboard/widgets/adaptive_widgets/mobileleaderboard.dart';
import 'package:vegas_lit/features/leaderboard/widgets/adaptive_widgets/tabletleaderboard.dart';
import 'package:vegas_lit/features/leaderboard/widgets/adaptive_widgets/webleaderboard.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return const Leaderboard._();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'LEADERBOARD',
                style: Styles.pageTitle,
              ),
            ),
          ],
        ),
        BlocBuilder<LeaderboardCubit, LeaderboardState>(
          builder: (context, state) {
            switch (state.status) {
              case LeaderboardStatus.initial:
                return const CircularProgressIndicator(
                  color: Palette.cream,
                );
                break;
              default:
                return ScreenTypeLayout(
                  desktop: WebLeaderboard(
                    players: state.rankedUserList,
                  ),
                  tablet: TabletLeaderboard(
                    players: state.rankedUserList,
                  ),
                  mobile: MobileLeaderboard(
                    players: state.rankedUserList,
                  ),
                );
                break;
            }
          },
        ),
        kIsWeb ? const BottomBar() : const SizedBox(),
      ],
    );
  }
}
