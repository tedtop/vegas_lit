import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/features/bet_history/bet_history.dart';
import 'package:vegas_lit/features/home/home.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/wallet.dart';
import '../../cubit/leaderboard_cubit.dart';
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
            childAspectRatio: 3.5,
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: PageNumberView(pages: 15),
        //     ),
        //   ],
        // )
      ],
    );
  }
}

class TabletLeaderboardTile extends StatefulWidget {
  TabletLeaderboardTile({@required this.player, @required this.rank});
  final Wallet player;
  final int rank;

  @override
  _TabletLeaderboardTileState createState() => _TabletLeaderboardTileState();
}

class _TabletLeaderboardTileState extends State<TabletLeaderboardTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final currentUserUid =
        context.select((HomeCubit cubit) => cubit.state?.userWallet?.uid);
    return Container(
      width: 380,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.cream,
        ),
        borderRadius: BorderRadius.circular(12),
        color: Palette.lightGrey,
      ),
      child: Center(
        child: ListTile(
          leading: GestureDetector(
            child: CircleAvatar(
              backgroundColor: expanded ? Palette.lightGrey : Palette.darkGrey,
              child: Text(
                widget.player.username.substring(0, 1).toUpperCase(),
                style: Styles.leaderboardUsername,
              ),
            ),
            onTap: () {
              currentUserUid == widget.player.uid
                  ? context.read<HomeCubit>().homeChange(4)
                  : Navigator.of(context).push(
                      History.navigation(
                        uid: widget.player.uid,
                        homeCubit: context.read<HomeCubit>(),
                      ),
                    );
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.player.rank}. ${widget.player.username}',
                style: Styles.normalTextBold,
              ),
              Text(
                '\$${widget.player.accountBalance + widget.player.pendingRiskedAmount}',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Palette.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'W/L/O/T: ${widget.player.totalBetsWon}/${widget.player.totalBetsLost}/${widget.player.totalOpenBets}/${widget.player.totalBets}',
                style: Styles.awayTeam,
              ),
              Text(
                'Wins: ${((widget.player.totalBetsWon / widget.player.totalBets) * 100).toStringAsFixed(0)}%',
                style: Styles.awayTeam,
              ),
            ],
          ),
          tileColor: Palette.lightGrey,
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     width: 240,
  //     height: 100,
  //     margin: const EdgeInsets.symmetric(vertical: 4),
  //     decoration: BoxDecoration(
  //       color: Palette.lightGrey,
  //       border: Border.all(
  //         color: Palette.cream,
  //       ),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(12),
  //       child: FittedBox(
  //         fit: BoxFit.scaleDown,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //           child: Column(
  //             children: [
  //               Text(
  //                 '${widget.rank}. ${widget.player.username}',
  //                 style: Styles.normalTextBold,
  //               ),
  //               Text(
  //                 'Total Profit: \$${widget.player.totalProfit}',
  //                 style: Styles.homeTeam,
  //               ),
  //               Text(
  //                 '${widget.player.totalBetsWon} out of ${widget.player.totalBets} Correct Bets!',
  //                 style: Styles.awayTeam,
  //               ),
  //               // Text(
  //               //   'Biggest win: \$${player.biggestWin}',
  //               //   style: Styles.awayTeam,
  //               // ),
  //               Text(
  //                 'Account Balance: \$${widget.player.accountBalance}',
  //                 style: Styles.awayTeam,
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
