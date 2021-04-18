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
import 'package:vegas_lit/leaderboard/widgets/mobileleaderboard.dart';
import 'package:vegas_lit/leaderboard/widgets/pagenumberview.dart';

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
              desktop: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Current Leaderboard',
                          style: Styles.normalTextBold,
                        ),
                      ),
                      Expanded(child: Container()),
                      const TextBar(
                        text: 'Current Week',
                      ),
                      const TextBar(
                        text: 'All Leagues',
                      ),
                      const TextBar(
                        text: 'All Bet Types',
                      ),
                    ],
                  ),
                ),
              ),
              mobile: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MobileLeaderboard(
                    players: playerList,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PageNumberView(pages: 15),
                      ),
                    ],
                  )
                ],
              ),
            ),
            kIsWeb ? const BottomBar() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class TextBar extends StatelessWidget {
  const TextBar({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Container(
            color: Palette.lightGrey,
            padding: const EdgeInsets.all(8.0),
            height: 40,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: GoogleFonts.nunito(
                    color: Palette.cream,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Icon(
                  FontAwesome.angle_down,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
