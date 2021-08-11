import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/helpers/bets_data_helper.dart';
import 'package:vegas_lit/data/models/wallet.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';
import 'package:vegas_lit/features/authentication/authentication.dart';
import 'package:vegas_lit/features/shared_widgets/default_button.dart';

import 'cubit/group_details_cubit.dart';

class GroupDetails extends StatelessWidget {
  GroupDetails._({Key key}) : super(key: key);

  static MaterialPageRoute route(
      {@required String groupId, @required String userId}) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) => GroupDetailsCubit(
          groupsRepository: context.read<GroupsRepository>(),
        )..fetchGroupDetailsLeaderboard(groupId: groupId, userId: userId),
        child: GroupDetails._(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'GROUP DETAILS',
          style: Styles.normalTextBold,
        ),
      ),
      body: BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const GroupDetailsDescription(),
                    const SizedBox(height: 10),
                    const GroupDetailsJoinButton(),
                    const SizedBox(height: 10),
                    const GroupDetailsLeaderboard(),
                  ],
                ),
              );
              break;
            default:
              return SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    'Couldn\'t load group details',
                    style: Styles.normalText,
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class GroupDetailsDescription extends StatelessWidget {
  const GroupDetailsDescription({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
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
              children: [
                Center(
                  child: Text(
                    state.group.name,
                    style: Styles.pageTitle,
                  ),
                ),
                const Center(
                  child: Icon(
                    Icons.star,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Table(
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
                            style: Styles.normalText.copyWith(fontSize: 14.5),
                          ),
                          const SizedBox(),
                          Text(
                            state.group.description.isEmpty
                                ? 'None'
                                : state.group.description,
                            style: Styles.normalText.copyWith(fontSize: 14.5),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text(
                            'Type',
                            style: Styles.normalText.copyWith(fontSize: 14.5),
                          ),
                          const SizedBox(),
                          Text(
                            state.group.isPublic ? 'Public' : 'Private',
                            style: Styles.normalText.copyWith(fontSize: 14.5),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text(
                            'People',
                            style: Styles.normalText.copyWith(fontSize: 14.5),
                          ),
                          const SizedBox(),
                          RichText(
                            text: TextSpan(
                              text:
                                  '${state.group.users.length}${state.group.userLimit == 0 ? '' : '/${state.group.userLimit}'}',
                              style: Styles.normalTextBold.copyWith(
                                fontSize: 14.5,
                                color: state.group.userLimit == 0 ||
                                        state.group.userLimit >
                                            state.group.users.length
                                    ? Palette.green
                                    : Palette.red,
                              ),
                              children: [
                                TextSpan(
                                  text: ' people are in the group',
                                  style: Styles.normalText
                                      .copyWith(fontSize: 14.5),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text(
                            'Admin',
                            style: Styles.normalText.copyWith(fontSize: 14.5),
                          ),
                          const SizedBox(),
                          Text(
                            state.group.adminName,
                            style: Styles.greenTextBold.copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
            break;
          default:
            return SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Couldn\'t load group details',
                  style: Styles.normalText,
                ),
              ),
            );
        }
      },
    );
  }
}

class GroupDetailsJoinButton extends StatelessWidget {
  const GroupDetailsJoinButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AuthenticationBloc>().state.user.uid;
    return BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
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
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child:
                      // state.isMember
                      //     ? const SizedBox()
                      //     :
                      Visibility(
                    visible: state.group.userLimit == 0
                        ? true
                        : state.group.userLimit >= state.group.users.length + 1,
                    replacement: SizedBox(
                      height: 60,
                      child: Center(
                        child: Text(
                          'Group Members Limit Exceeded.',
                          style: Styles.normalText,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      width: 150,
                      child: DefaultButton(
                        text: 'Join',
                        action: () {
                          context.read<GroupDetailsCubit>().addNewUser(
                              groupId: state.group.id, userId: userId);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
            break;
          default:
            return SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Couldn\'t load button',
                  style: Styles.normalText,
                ),
              ),
            );
        }
      },
    );
  }
}

class GroupDetailsLeaderboard extends StatelessWidget {
  const GroupDetailsLeaderboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'LEADERBOARD',
            style: Styles.pageTitle.copyWith(fontSize: 18),
          ),
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
                return state.players.isEmpty
                    ? SizedBox(
                        height: 100,
                        child: Center(
                          child: Text(
                            'Place some bets first.',
                            style: Styles.normalText,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.players.length,
                        itemBuilder: (context, index) {
                          return GroupDetailsLeaderboardTile(
                            player: state.players[index],
                            index: index,
                          );
                        },
                      );

                break;
              default:
                return SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Not available at this time',
                      style: Styles.normalText,
                    ),
                  ),
                );
            }
          },
        ),
      ],
    );
  }
}

class GroupDetailsLeaderboardTile extends StatelessWidget {
  const GroupDetailsLeaderboardTile(
      {Key key, @required this.player, @required this.index})
      : super(key: key);

  final Wallet player;
  final int index;

  @override
  Widget build(BuildContext context) {
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
                '$index. ${player.username}',
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
