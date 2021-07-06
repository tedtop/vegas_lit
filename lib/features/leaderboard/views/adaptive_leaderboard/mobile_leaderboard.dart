import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/helpers/bets_data_helper.dart';
import 'package:vegas_lit/features/bet_history/bet_history.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/wallet.dart';
import '../../../home/home.dart';
import '../../../leaderboard_profile/leaderboard_profile.dart';
import '../../cubit/leaderboard_cubit.dart';
import '../../widgets/textbar.dart';

class MobileLeaderboard extends StatefulWidget {
  MobileLeaderboard({@required this.players});
  final List<Wallet> players;
  @override
  _MobileLeaderboardState createState() => _MobileLeaderboardState();
}

class _MobileLeaderboardState extends State<MobileLeaderboard> {
  @override
  Widget build(BuildContext context) {
    final leaderboardState = context.watch<LeaderboardCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextBar(
          text: leaderboardState.day,
          textList: leaderboardState.days,
          onPress: (String value) {
            context.read<LeaderboardCubit>().changeWeek(week: value);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Builder(
          builder: (context) {
            switch (leaderboardState.status) {
              case LeaderboardStatus.opened:
                return leaderboardState.rankedUserList.isNotEmpty
                    ? Column(
                        children: widget.players
                            .asMap()
                            .entries
                            .map((entry) => MobileLeaderboardTile(
                                  player: entry.value,
                                  rank: entry.key + 1,
                                ))
                            .toList(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 120),
                        child: Text(
                          // ignore: lines_longer_than_80_chars
                          'No records found',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            color: Palette.cream,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                break;
              case LeaderboardStatus.weekChanged:
                return leaderboardState.rankedUserList.isNotEmpty
                    ? Column(
                        children: widget.players
                            .asMap()
                            .entries
                            .map((entry) => MobileLeaderboardTile(
                                  player: entry.value,
                                  rank: entry.key + 1,
                                ))
                            .toList(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 120),
                        child: Text(
                          // ignore: lines_longer_than_80_chars
                          'No records found',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            color: Palette.cream,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
              default:
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 120),
                  child: CircularProgressIndicator(
                    color: Palette.cream,
                  ),
                );
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Last Updated: ',
                style: Styles.matchupTime,
              ),
              Text(
                DateFormat('E, MMMM, c, y @ hh:00 a')
                    .format(ESTDateTime.fetchTimeEST()),
                style: Styles.matchupTime,
              ),
              Text(
                ' EST',
                style: Styles.matchupTime,
              ),
            ],
          ),
        )
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: PageNumberView(pages: 0),
        //     ),
        //   ],
        // )
      ],
    );
  }
}

class MobileLeaderboardTile extends StatelessWidget {
  MobileLeaderboardTile({@required this.player, @required this.rank});
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
        color: Palette.lightGrey,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          // enableFeedback: true,
          onTap: () {
            if (currentUserUid == player.uid) {
              context.read<HistoryCubit>().changeWeek(week: week);
              context.read<HomeCubit>().homeChange(4);
            } else {
              Navigator.of(context).push(
                LeaderboardProfile.navigation(
                  uid: player.uid,
                  homeCubit: context.read<HomeCubit>(),
                  week: week,
                ),
              );
            }
          },
          leading: player.avatarUrl != null && !kIsWeb
              ? CircleAvatar(
                  radius: 25,
                  backgroundImage: CachedNetworkImageProvider(player.avatarUrl,
                      imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet),
                )
              : CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child: Container(
                      alignment: Alignment.center,
                      color: Palette.darkGrey,
                      height: 50.0,
                      width: 50.0,
                      child: Text(player.username.substring(0, 1).toUpperCase(),
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
                '${player.accountBalance + player.pendingRiskedAmount - player.totalRewards}',
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
                BetsDataHelper.leaderboardWinningBetsRatio(
                  player.totalBetsWon,
                  player.totalBetsLost,
                ),
                style: Styles.awayTeam,
              ),
            ],
          ),
          tileColor: Palette.lightGrey,
        ),
      ),
    );
  }
}
