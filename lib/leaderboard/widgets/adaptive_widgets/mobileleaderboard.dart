import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/leaderboard/models/player.dart';
import 'package:vegas_lit/leaderboard/widgets/pagenumberview.dart';
import 'package:vegas_lit/leaderboard/widgets/textbar.dart';

class MobileLeaderboard extends StatefulWidget {
  MobileLeaderboard({@required this.players});
  final List<UserData> players;
  @override
  _MobileLeaderboardState createState() => _MobileLeaderboardState();
}

class _MobileLeaderboardState extends State<MobileLeaderboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
          child: Text(
            'Current Leaderboard',
            style: Styles.normalTextBold,
          ),
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
          ],
        ),
        const TextBar(
          text: 'All Bet Types',
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: widget.players
              .asMap()
              .entries
              .map((entry) => MobileLeaderboardTile(
                    player: entry.value,
                    rank: entry.key + 1,
                  ))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageNumberView(pages: 0),
            ),
          ],
        )
      ],
    );
  }
}

class MobileLeaderboardTile extends StatelessWidget {
  MobileLeaderboardTile({@required this.player, @required this.rank});
  final UserData player;
  final int rank;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.cream,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ExpansionTile(
          title: Text(
            '$rank. ${player.username}',
            style: Styles.normalTextBold,
          ),
          subtitle: Text(
            'Total Profit: \$${player.profit}',
            style: Styles.homeTeam,
          ),
          collapsedBackgroundColor: Palette.lightGrey,
          backgroundColor: Palette.darkGrey,
          children: [
            Container(
              width: 380,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${player.correctBets} out of ${player.numberBets} Correct Bets!',
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
            )
          ],
        ),
      ),
    );
  }
}
