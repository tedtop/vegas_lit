import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/leaderboard/models/player.dart';
import 'package:vegas_lit/leaderboard/widgets/pagenumberview.dart';
import 'package:vegas_lit/leaderboard/widgets/textbar.dart';

class TabletLeaderboard extends StatefulWidget {
  final List<LeaderBoardPlayer> players;
  TabletLeaderboard({this.players});
  @override
  _TabletLeaderboardState createState() => _TabletLeaderboardState();
}

class _TabletLeaderboardState extends State<TabletLeaderboard> {
  @override
  Widget build(BuildContext context) {
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
                .map((player) => TabletLeaderboardTile(
                      player: player,
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
  final LeaderBoardPlayer player;
  TabletLeaderboardTile({this.player});
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
                  '${player.rank}. ${player.player}',
                  style: Styles.normalTextBold,
                ),
                Text(
                  'Total Profit: \$${player.profit}',
                  style: Styles.homeTeam,
                ),
                Text(
                  '${player.noOfCorrectBets} out of ${player.noOfBets} Correct Bets!',
                  style: Styles.awayTeam,
                ),
                Text(
                  'Biggest win: \$${player.biggestWin}',
                  style: Styles.awayTeam,
                ),
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
