import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/helpers/bets_data_helper.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/data/models/wallet.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';
import 'package:vegas_lit/features/shared_widgets/default_button.dart';

import 'cubit/group_details_cubit.dart';

class GroupDetails extends StatelessWidget {
  GroupDetails._({Key key, this.group}) : super(key: key);

  static MaterialPageRoute route({@required Group group}) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        // USE THE CUBIT TO GET LEADERBOARD
        create: (context) => GroupDetailsCubit(
          userRepository: context.read<UserRepository>(),
        )..fetchLeaderboardForGroup(groupId: 'groupId'),
        child: GroupDetails._(
          group: group,
        ),
      );
    });
  }

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                      child: Center(
                    child: Text(
                      'GROUP DETAILS',
                      style: Styles.normalTextBold,
                    ),
                  )),
                ],
              ),
              Center(
                child: Text(
                  'WIN OR GO BROKE',
                  style: Styles.pageTitle,
                ),
              ),
              const Center(
                child: Icon(
                  Icons.star,
                  size: 50,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Table(
                border: TableBorder.all(color: Colors.transparent),
                columnWidths: {
                  0: const FixedColumnWidth(70),
                  1: const FixedColumnWidth(10),
                  2: const FlexColumnWidth()
                },
                children: [
                  TableRow(
                    children: [
                      Text(
                        'Motto',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                      const SizedBox(),
                      Text(
                        'assume this is a motto, okay? If you don\'t think this is anything like a motto, then you are right, as I do not know what to do with my life myself.',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        'Type',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                      const SizedBox(),
                      Text(
                        'Public',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        'Homepage',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                      const SizedBox(),
                      Text(
                        'https://thisisntasite.com/wasteyourlife',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        'Members',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                      const SizedBox(),
                      Text(
                        'assume this is a motto, okay? If you don\'t think this is anything like a motto, then you are right, as I do not know what to do with my life myself.',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        'Admin',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                      const SizedBox(),
                      Text(
                        'ritikTheGreat',
                        style: Styles.greenText.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                    width: 200,
                    child: DefaultButton(text: 'SHARE', action: () {})),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'LEADERBOARD',
                style: Styles.pageTitle.copyWith(fontSize: 18),
              ),
              BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
                  builder: (context, state) {
                switch (state.status) {
                  case GroupDetailsStatus.loading:
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Palette.cream,
                        ),
                      ),
                    );
                    break;
                  case GroupDetailsStatus.complete:
                    return Column(
                      children: state.players
                          .map((player) => Container(
                                width: 380,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 10),
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
                                      // if (currentUserUid == player.uid) {
                                      //   context.read<HistoryCubit>().changeWeek(week: week);
                                      //   context.read<HomeCubit>().homeChange(4);
                                      // } else {
                                      //   Navigator.of(context).push(
                                      //     LeaderboardProfile.navigation(
                                      //       uid: player.uid,
                                      //       homeCubit: context.read<HomeCubit>(),
                                      //       week: week,
                                      //     ),
                                      //   );
                                      // }
                                    },
                                    leading: player.avatarUrl != null && !kIsWeb
                                        ? CircleAvatar(
                                            radius: 25,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    player.avatarUrl,
                                                    imageRenderMethodForWeb:
                                                        ImageRenderMethodForWeb
                                                            .HttpGet),
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
                                                    player.username
                                                        .substring(0, 1)
                                                        .toUpperCase(),
                                                    style: Styles
                                                        .leaderboardUsername),
                                              ),
                                            ),
                                          ),

                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'W/L/O/T: ${player.totalBetsWon}/${player.totalBetsLost}/${player.totalOpenBets}/${player.totalBets}',
                                          style: Styles.awayTeam,
                                        ),
                                        Text(
                                          BetsDataHelper
                                              .leaderboardWinningBetsRatio(
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
                              ))
                          .toList(),
                    );
                    break;
                  default:
                    return SizedBox(
                        height: 100,
                        child: Center(
                            child: Text(
                          'Not available at this time',
                          style: Styles.normalText,
                        )));
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
