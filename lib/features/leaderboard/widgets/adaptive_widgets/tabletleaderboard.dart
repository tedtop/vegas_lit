import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/wallet.dart';
import 'package:vegas_lit/features/leaderboard/cubit/leaderboard_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pagenumberview.dart';
import '../textbar.dart';

class TabletLeaderboard extends StatefulWidget {
  TabletLeaderboard({this.players});
  final List<Wallet> players;
  @override
  _TabletLeaderboardState createState() => _TabletLeaderboardState();
}

class _TabletLeaderboardState extends State<TabletLeaderboard> {
  @override
  Widget build(BuildContext context) {
    final leaderboardState = context.watch<LeaderboardCubit>().state;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
              child: Text(
                'Current Leaderboard',
                style: Styles.normalTextBold,
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextBar(
              text: leaderboardState.day,
              textList: leaderboardState.days,
              onPress: (String value) {
                context.read<LeaderboardCubit>().changeWeek(week: value);
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            shrinkWrap: true,
            childAspectRatio: 2,
            children: widget.players
                .asMap()
                .entries
                .map((entry) => TabletLeaderboardTile(
                      player: entry.value,
                      rank: entry.key + 1,
                    ))
                .toList(),
          ),
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
    );
  }
}

class TabletLeaderboardTile extends StatelessWidget {
  TabletLeaderboardTile({@required this.player, @required this.rank});
  final Wallet player;
  final int rank;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Palette.lightGrey,
        border: Border.all(
          color: Palette.cream,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Text(
                  '$rank. ${player.username}',
                  style: Styles.normalTextBold,
                ),
                Text(
                  'Total Profit: \$${player.totalProfit}',
                  style: Styles.homeTeam,
                ),
                Text(
                  '${player.totalBetsWon} out of ${player.totalBets} Correct Bets!',
                  style: Styles.awayTeam,
                ),
                // Text(
                //   'Biggest win: \$${player.biggestWin}',
                //   style: Styles.awayTeam,
                // ),
                Text(
                  'Account Balance: \$${player.accountBalance}',
                  style: Styles.awayTeam,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
