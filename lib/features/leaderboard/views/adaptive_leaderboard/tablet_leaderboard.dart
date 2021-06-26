import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/wallet.dart';
import '../../../home/home.dart';
import '../../../leaderboard_profile/leaderboard_profile.dart';
import '../../cubit/leaderboard_cubit.dart';
import '../../widgets/textbar.dart';

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
            childAspectRatio: 3.7,
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

class TabletLeaderboardTile extends StatelessWidget {
  TabletLeaderboardTile({@required this.player, @required this.rank});
  final Wallet player;
  final int rank;

  @override
  Widget build(BuildContext context) {
    final currentUserUid =
        context.select((HomeCubit cubit) => cubit.state?.userWallet?.uid);
    final week = context.watch<LeaderboardCubit>().state.day;
    return Container(
      width: 380,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.cream,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        color: Palette.lightGrey,
        child: Center(
          child: ListTile(
            // enableFeedback: true,
            onTap: () {
              currentUserUid == player.uid
                  ? context.read<HomeCubit>().homeChange(4)
                  : Navigator.of(context).push(
                      LeaderboardProfile.navigation(
                        uid: player.uid,
                        homeCubit: context.read<HomeCubit>(),
                        week: week,
                      ),
                    );
            },
            leading: player.avatarUrl != null && !kIsWeb
                ? CircleAvatar(
                    radius: 25,
                    backgroundImage: CachedNetworkImageProvider(
                        player.avatarUrl,
                        imageRenderMethodForWeb:
                            ImageRenderMethodForWeb.HttpGet),
                  )
                : CircleAvatar(
                    radius: 25,
                    child: ClipOval(
                      child: Container(
                        alignment: Alignment.center,
                        color: Palette.darkGrey,
                        height: 50.0,
                        width: 50.0,
                        child: Text(
                            player.username.substring(0, 1).toUpperCase(),
                            style: Styles.leaderboardUsername),
                      ),
                    ),
                  ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${player.rank}. ${player.username}',
                  style: Styles.normalTextBold,
                ),
                Text(
                  '\$${player.accountBalance + player.pendingRiskedAmount}',
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
                  'W/L/O/T: ${player.totalBetsWon}/${player.totalBetsLost}/${player.totalOpenBets}/${player.totalBets}',
                  style: Styles.awayTeam,
                ),
                Text(
                  'Wins: ${((player.totalBetsWon / player.totalBets) * 100).toStringAsFixed(0)}%',
                  style: Styles.awayTeam,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
