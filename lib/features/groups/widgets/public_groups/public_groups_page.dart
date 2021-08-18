import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';
import 'package:vegas_lit/features/authentication/authentication.dart';
import 'package:vegas_lit/features/groups/widgets/group_add/group_add.dart';
import 'package:vegas_lit/features/groups/widgets/group_details/group_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/features/home/home.dart';

import 'cubit/public_groups_cubit.dart';

class PublicGroups extends StatelessWidget {
  const PublicGroups._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (_) => PublicGroupsCubit(
            groupsRepository: context.read<GroupsRepository>(),
          )..openPublicGroups(),
          child: const PublicGroups._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: RichText(
              text: TextSpan(
                text: 'You can join or ',
                style: Styles.openBetsNormalText,
                children: [
                  TextSpan(
                      text: 'create a group',
                      style: Styles.greenTextBold,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            GroupAdd.route(
                              homeCubit: context.read<HomeCubit>(),
                            ),
                          );
                        }),
                  const TextSpan(
                      text:
                          ' to play with your friends together or to make new friends by playing together.')
                ],
              ),
            ),
          ),
          BlocBuilder<PublicGroupsCubit, PublicGroupsState>(
            builder: (context, state) {
              switch (state.status) {
                case PublicGroupsStatus.initial:
                  return const SizedBox();
                  break;
                case PublicGroupsStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Palette.cream,
                    ),
                  );
                  break;
                case PublicGroupsStatus.success:
                  if (state.publicGroups.isEmpty) {
                    return Center(
                      child: Text(
                        'No Groups Found!',
                        style: GoogleFonts.nunito(),
                      ),
                    );
                  } else {
                    return const PublicGroupList();
                  }
                  break;
                case PublicGroupsStatus.failure:
                  return Center(
                    child: Text(
                      'Couldn\'t open groups',
                      style: GoogleFonts.nunito(),
                    ),
                  );
                  break;
                default:
                  return const SizedBox();
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}

class PublicGroupList extends StatelessWidget {
  const PublicGroupList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupList = context.select(
      (PublicGroupsCubit cubit) => cubit.state?.publicGroups,
    );
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      key: Key('${groupList.length}'),
      itemCount: groupList.length,
      itemBuilder: (context, index) {
        return PublicGroupListTile(
          group: groupList[index],
        );
      },
    );
  }
}

class PublicGroupListTile extends StatelessWidget {
  const PublicGroupListTile({
    Key key,
    @required Group group,
  })  : assert(group != null),
        _group = group,
        super(key: key);

  final Group _group;

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AuthenticationBloc>().state.user.uid;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Palette.lightGrey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Palette.cream, width: 1.0),
        boxShadow: <BoxShadow>[
          const BoxShadow(
              color: Palette.lightGrey,
              blurRadius: 1.2,
              offset: Offset(0.4, 0.6))
        ],
      ),
      child: ListTile(
        leading: const Icon(
          Icons.star,
          size: 35,
        ),
        title: Text(
          _group.name,
          style: Styles.leaderboardUsername,
        ),
        subtitle: Text(
          _group.isPublic ? 'Public Group' : 'Private Group',
          style: Styles.normalText.copyWith(fontSize: 14),
        ),
        trailing: Column(
          children: [
            Text(
              '${_group.users.length}${_group.userLimit == 0 ? '' : '/${_group.userLimit}'}',
              style: Styles.leaderboardUsername.copyWith(
                color: _group.userLimit == 0 ||
                        _group.userLimit > _group.users.length
                    ? Palette.green
                    : Palette.red,
              ),
            ),
            Text(
              'Users',
              style: Styles.normalText.copyWith(fontSize: 14),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            GroupDetails.route(
              groupId: _group.id,
              userId: userId,
            ),
          );
        },
      ),
    );
  }
}