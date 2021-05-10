import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/leaderboard/cubit/leaderboard_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/leaderboard/widgets/pagenumberview.dart';
import 'package:vegas_lit/leaderboard/widgets/textbar.dart';

class WebLeaderboard extends StatefulWidget {
  WebLeaderboard({this.players});
  final List<Wallet> players;
  @override
  _WebLeaderboardState createState() => _WebLeaderboardState();
}

class _WebLeaderboardState extends State<WebLeaderboard> {
  @override
  Widget build(BuildContext context) {
    final leaderboardState = context.watch<LeaderboardCubit>().state;
    return Column(
      children: [
        Container(
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
                TextBar(
                  text: leaderboardState.week,
                  textList: leaderboardState.weeks,
                  onPress: (String value) {
                    context.read<LeaderboardCubit>().changeWeek(week: value);
                  },
                ),
                const TextBar(
                  text: 'All Leagues',
                  textList: ['All Leagues'],
                  onPress: print,
                ),
                const TextBar(
                  text: 'All Bet Types',
                  textList: ['All Bet Types'],
                  onPress: print,
                ),
              ],
            ),
          ),
        ),
        Container(
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
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
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
                            .asMap()
                            .entries
                            .map(
                              (entry) => WebLeaderboardItem(
                                player: entry.value,
                                rank: entry.key + 1,
                              ),
                            )
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
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: PageNumberView(pages: 15),
              ),
            ],
          ),
        )
      ],
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
  WebLeaderboardItem({this.player, this.rank});
  final Wallet player;
  final int rank;
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
              '$rank',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              '${player.username}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              '\$${player.totalProfit}',
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
              '${player.totalBets}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              '${player.totalWinBets}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              '\$${player.totalOpenBets}',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 145,
            child: Text(
              'N/A',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'N/A',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'N/A',
              style: Styles.normalText
                  .copyWith(color: Palette.cream, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
