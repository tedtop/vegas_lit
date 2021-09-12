import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/data/repositories/storage_repository.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/user.dart';
import '../../../../data/models/wallet.dart';
import '../../../../data/repositories/groups_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../authentication/authentication.dart';
import 'cubit/group_details_cubit.dart';
import 'cubit/user_search_cubit.dart';

class GroupDetails extends StatelessWidget {
  GroupDetails._({Key key, @required this.userId}) : super(key: key);

  static MaterialPageRoute route(
      {@required StorageRepository storageRepository,
      @required String groupId,
      @required String userId}) {
    return MaterialPageRoute(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GroupDetailsCubit(
                groupsRepository: context.read<GroupsRepository>(),
                storageRepository: storageRepository,
              )..fetchGroupDetailsLeaderboard(groupId: groupId, userId: userId),
            ),
            BlocProvider(
              create: (context) => UserSearchCubit(
                userRepository: context.read<UserRepository>(),
              ),
            ),
          ],
          child: GroupDetails._(
            userId: userId,
          ),
        );
      },
    );
  }

  final String userId;

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
                    GroupDetailsDescription(userId: userId),
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
  const GroupDetailsDescription({Key key, @required this.userId})
      : super(key: key);

  final String userId;

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
                const SizedBox(height: 10),
                Stack(
                  children: [
                    state.group.avatarUrl != null
                        ? SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                child: Image.network(state.group.avatarUrl)),
                          )
                        : const Center(
                            child: Icon(
                              Icons.star,
                              size: 50,
                            ),
                          ),
                    Positioned(
                      bottom: 5,
                      right: 0,
                      child: state.group.adminId == userId
                          ? InkWell(
                              onTap: () {
                                context
                                    .read<GroupDetailsCubit>()
                                    .pickAvatar(groupId: state.group.id);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Palette.darkGrey,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Palette.cream)),
                                padding: const EdgeInsets.all(3),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.edit,
                                      color: Palette.cream,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Edit',
                                      style: GoogleFonts.nunito(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ],
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
            return Visibility(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: DefaultButton(
                      text: 'Add',
                      action: () async {
                        final selectedUser = await showSearch(
                          context: context,
                          delegate: UserSearch(
                            context.read<UserSearchCubit>(),
                          ),
                        );
                        if (selectedUser != null) {
                          if (state.group.users.containsKey(selectedUser.uid)) {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  duration: const Duration(milliseconds: 2000),
                                  content: Text(
                                    'User already added',
                                    style: GoogleFonts.nunito(),
                                  ),
                                ),
                              );
                          } else {
                            final updatedUsers = state.group.users;
                            updatedUsers[selectedUser.uid] = false;
                            await context.read<GroupDetailsCubit>().addNewUser(
                                  groupId: state.group.id,
                                  users: updatedUsers,
                                );

                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  duration: const Duration(milliseconds: 2000),
                                  content: Text(
                                    'Group request sent to ${selectedUser.username}',
                                    style: GoogleFonts.nunito(),
                                  ),
                                ),
                              );
                          }
                        }
                      },
                    ),
                  ),
                  Center(
                    child: state.isMember
                        ? const SizedBox()
                        : SizedBox(
                            width: 150,
                            child: DefaultButton(
                              text: 'Join',
                              action: () {
                                final updatedUsers = state.group.users;
                                updatedUsers[userId] = true;
                                context.read<GroupDetailsCubit>().addNewUser(
                                      groupId: state.group.id,
                                      users: updatedUsers,
                                    );
                              },
                            ),
                          ),
                  ),
                ],
              ),
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
                            index: index + 1,
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
                leaderboardWinningBetsRatio(
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

String leaderboardWinningBetsRatio(int betsWon, int betsLost) {
  return 'Wins: ${(betsWon / (betsWon + betsLost)).isNaN ? 0 : (betsWon / (betsWon + betsLost) * 100).toStringAsFixed(0)}%';
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    @required this.text,
    @required this.action,
    this.color = Palette.green,
    this.elevation = Styles.normalElevation,
  })  : assert(text != null),
        super(key: key);

  final String text;
  final Function action;
  final Color color;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 174,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: 10,
                ),
              ),
              elevation: MaterialStateProperty.all(elevation),
              shape: MaterialStateProperty.all(Styles.smallRadius),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Palette.cream),
              ),
              backgroundColor: MaterialStateProperty.all(color),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Text(
            text,
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: action,
        ),
      ),
    );
  }
}

class UserSearch extends SearchDelegate<UserData> {
  UserSearch(this.userSearchCubit);

  final UserSearchCubit userSearchCubit;

  @override
  List<Widget> buildActions(BuildContext context) => null;

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const BackButtonIcon(),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    userSearchCubit.searchUserResults(query: query);
    return BlocBuilder<UserSearchCubit, UserSearchState>(
      cubit: userSearchCubit,
      builder: (context, state) {
        switch (state.status) {
          case UserSearchStatus.initial:
            return const SizedBox();
            break;
          case UserSearchStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
            break;
          case UserSearchStatus.success:
            return ListView.builder(
              itemBuilder: (context, index) {
                final userData = state.users[index];
                return ListTile(
                  leading: userData.avatarUrl != null && !kIsWeb
                      ? CircleAvatar(
                          radius: 25,
                          backgroundImage: CachedNetworkImageProvider(
                              userData.avatarUrl,
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
                                  userData.username
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: Styles.leaderboardUsername),
                            ),
                          ),
                        ),
                  title: Text(
                    userData.username,
                    style: GoogleFonts.nunito(),
                  ),
                  onTap: () {
                    close(
                      context,
                      state.users[index],
                    );
                  },
                );
              },
              itemCount: state.users.length,
            );

            break;
          default:
            return Text(
              'Error',
              style: GoogleFonts.nunito(),
            );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    userSearchCubit.searchUserSuggestions(query: query);
    return BlocBuilder<UserSearchCubit, UserSearchState>(
      cubit: userSearchCubit,
      builder: (context, state) {
        switch (state.status) {
          case UserSearchStatus.initial:
            return const SizedBox();
            break;
          case UserSearchStatus.loading:
            return const Center(
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(),
              ),
            );
            break;
          case UserSearchStatus.success:
            return ListView.builder(
              itemBuilder: (context, index) {
                final userData = state.users[index];
                return ListTile(
                  leading: userData.avatarUrl != null && !kIsWeb
                      ? CircleAvatar(
                          radius: 25,
                          backgroundImage: CachedNetworkImageProvider(
                              userData.avatarUrl,
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
                                  userData.username
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: Styles.leaderboardUsername),
                            ),
                          ),
                        ),
                  title: Text(
                    userData.username,
                    style: GoogleFonts.nunito(),
                  ),
                  onTap: () {
                    close(
                      context,
                      state.users[index],
                    );
                  },
                );
              },
              itemCount: state.users.length,
            );

            break;
          default:
            return Text(
              'Error',
              style: GoogleFonts.nunito(),
            );
        }
      },
    );
  }
}
