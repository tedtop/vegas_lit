import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pluto_grid/pluto_grid.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/home/widgets/bottombar.dart';
import 'package:vegas_lit/leaderboard/cubit/leaderboard_cubit.dart';
import 'package:vegas_lit/leaderboard/models/fakedata.dart';
import 'package:vegas_lit/leaderboard/widgets/adaptive_widgets/mobileleaderboard.dart';
import 'package:vegas_lit/leaderboard/widgets/pagenumberview.dart';
import 'package:vegas_lit/leaderboard/widgets/adaptive_widgets/tabletleaderboard.dart';
import 'package:vegas_lit/leaderboard/widgets/adaptive_widgets/webleaderboard.dart';

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
    return SingleChildScrollView(
      child: Container(
        color: Palette.darkGrey,
        child: Column(
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
                    return const CircularProgressIndicator();
                    break;
                  case LeaderboardStatus.opened:
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
                  default:
                }
              },
            ),
            kIsWeb ? const BottomBar() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
