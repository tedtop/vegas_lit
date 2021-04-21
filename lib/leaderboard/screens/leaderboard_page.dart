import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pluto_grid/pluto_grid.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/home/widgets/bottombar.dart';
import 'package:vegas_lit/leaderboard/models/fakedata.dart';
import 'package:vegas_lit/leaderboard/widgets/adaptive_widgets/mobileleaderboard.dart';
import 'package:vegas_lit/leaderboard/widgets/pagenumberview.dart';
import 'package:vegas_lit/leaderboard/widgets/adaptive_widgets/tabletleaderboard.dart';
import 'package:vegas_lit/leaderboard/widgets/adaptive_widgets/webleaderboard.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  void initState() {
    super.initState();

    //_employeeDataSource = EmployeeDataSource(playerData: players);
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
            ScreenTypeLayout(
              desktop: WebLeaderboard(
                players: playerList,
              ),
              tablet: TabletLeaderboard(
                players: playerList,
              ),
              mobile: MobileLeaderboard(
                players: playerList,
              ),
            ),
            kIsWeb ? const BottomBar() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
