import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/leaderboard/models/player.dart';

class WebLeaderboard extends StatefulWidget {
  final List<LeaderBoardPlayer> players;
  WebLeaderboard({this.players});
  @override
  _WebLeaderboardState createState() => _WebLeaderboardState();
}

class _WebLeaderboardState extends State<WebLeaderboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Palette.cream,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 1220),
            height: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              color: Palette.darkGrey,
            ),
            child: Center(
              child: Text(
                'CONTEST WINNINGS',
                style: Styles.largeTextBold,
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 1220),
            height: 8,
            color: Palette.green,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1220),
              child: Column(
                children: [
                  LeaderboardColumns(),
                  Column(
                    children: widget.players
                        .map((player) => WebLeaderboardItem(
                              player: player,
                            ))
                        .toList(),
                  ),
                  Container(
                    height: 8,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Palette.lightGrey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LeaderboardColumns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Palette.lightGrey,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 60,
            child: Text(
              'Rank',
              style: Styles.normalTextBold
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'Player',
              style: Styles.normalTextBold
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'Profit',
              style: Styles.normalTextBold
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              'Account Balance',
              style: Styles.normalTextBold
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 95,
            child: Text(
              '# of Bets',
              style: Styles.normalTextBold
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              '# of Correct Bets',
              style: Styles.normalTextBold
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              'Open Bets',
              style: Styles.normalTextBold
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 145,
            child: Text(
              'Potential Winnings',
              style: Styles.normalTextBold
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'Biggest Win',
              style: Styles.normalTextBold
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'Last Week\'s Rank',
              style: Styles.normalTextBold
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class WebLeaderboardItem extends StatelessWidget {
  final LeaderBoardPlayer player;
  WebLeaderboardItem({this.player});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Palette.lightGrey,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 60,
            child: Text(
              '${player.rank}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              '${player.player}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              '\$${player.profit}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              '\$${player.accountBalance}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 95,
            child: Text(
              '${player.noOfBets}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              '${player.noOfCorrectBets}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              '\$${player.openBets}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 145,
            child: Text(
              '\$${player.potentialWinnings}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              '\$${player.biggestWin}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              '${player.lastWeeksRank}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
