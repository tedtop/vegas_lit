import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/leaderboard/models/player.dart';

class MobileLeaderboard extends StatefulWidget {
  final List<LeaderBoardPlayer> players;
  MobileLeaderboard({@required this.players});
  @override
  _MobileLeaderboardState createState() => _MobileLeaderboardState();
}

class _MobileLeaderboardState extends State<MobileLeaderboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.players
          .map((player) => MobileLeaderboardTile(
                player: player,
              ))
          .toList(),
    );
  }
}

class MobileLeaderboardTile extends StatelessWidget {
  final LeaderBoardPlayer player;
  MobileLeaderboardTile({@required this.player});
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
            '${player.rank}. ${player.player}',
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
            )
          ],
        ),
      ),
    );
  }
}
