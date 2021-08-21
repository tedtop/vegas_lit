import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/wallet.dart';
import '../../../home/home.dart';
import '../../../leaderboard_profile/leaderboard_profile.dart';
import '../../cubit/leaderboard_cubit.dart';
import '../../widgets/textbar.dart';

class DesktopLeaderboard extends StatefulWidget {
  DesktopLeaderboard({this.players});
  final List<Wallet> players;
  @override
  _DesktopLeaderboardState createState() => _DesktopLeaderboardState();
}

class _DesktopLeaderboardState extends State<DesktopLeaderboard> {
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
                  child: AutoSizeText(
                    'Current Leaderboard',
                    style: Styles.normalTextBold,
                  ),
                ),
                Expanded(child: Container()),
                TextBar(
                  text: leaderboardState.day,
                  textList: leaderboardState.days,
                  onPress: (String value) {
                    context.read<LeaderboardCubit>().changeWeek(week: value);
                  },
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
                  child: AutoSizeText(
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
        // Container(
        //   constraints: const BoxConstraints(maxWidth: 1200),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(20.0),
        //         child: PageNumberView(pages: 15),
        //       ),
        //     ],
        //   ),
        // )
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
            child: AutoSizeText(
              'Rank',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 120,
            child: AutoSizeText(
              'Player',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 120,
            child: AutoSizeText(
              'Profit',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 150,
            child: AutoSizeText(
              'Account Balance',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 95,
            child: AutoSizeText(
              '# of Bets',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 140,
            child: AutoSizeText(
              '# of Correct Bets',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 110,
            child: AutoSizeText(
              'Open Bets',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 145,
            child: AutoSizeText(
              'Potential Winnings',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 120,
            child: AutoSizeText(
              'Biggest Win',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 120,
            child: AutoSizeText(
              'Last Week\'s Rank',
              style: Styles.leaderboardDesktopField,
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
    final currentUserUid =
        context.select((HomeCubit cubit) => cubit.state?.userWallet?.uid);
    final week = context.watch<LeaderboardCubit>().state.day;
    return InkWell(
      onTap: () {
        currentUserUid == player.uid
            ? context.read<HomeCubit>().homeChange(4)
            : Navigator.of(context).push(
                LeaderboardProfile.route(
                  uid: player.uid,
                  homeCubit: context.read<HomeCubit>(),
                  week: week,
                ),
              );
      },
      child: Container(
        height: 50,
        color: Palette.lightGrey,
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 60,
              child: AutoSizeText(
                '$rank',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 120,
              child: AutoSizeText(
                '${player.username}',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 120,
              child: AutoSizeText(
                '${player.totalProfit}',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 150,
              child: AutoSizeText(
                '${player.accountBalance}',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 95,
              child: AutoSizeText(
                '${player.totalBets}',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 140,
              child: AutoSizeText(
                '${player.totalBetsWon}',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 110,
              child: AutoSizeText(
                '${player.totalOpenBets}',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 145,
              child: AutoSizeText(
                'N/A',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 120,
              child: AutoSizeText(
                'N/A',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 120,
              child: AutoSizeText(
                'N/A',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
