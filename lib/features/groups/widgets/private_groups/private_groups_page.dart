import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/group.dart';
import '../../../../data/repositories/groups_repository.dart';
import '../../../../data/repositories/storage_repository.dart';
import '../../../authentication/authentication.dart';
import '../../../home/home.dart';
import '../group_add/group_add.dart';
import '../group_details/group_details.dart';
import 'cubit/private_groups_cubit.dart';

class PrivateGroups extends StatelessWidget {
  const PrivateGroups._({Key? key}) : super(key: key);

  static Builder route({required String? uid}) {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (_) => PrivateGroupsCubit(
            groupsRepository: context.read<GroupsRepository>(),
          )..openPrivateGroups(uid: uid),
          child: const PrivateGroups._(),
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
                          Navigator.push<void>(
                            context,
                            GroupAdd.route(
                              storageRepository:
                                  context.read<StorageRepository>(),
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
          BlocBuilder<PrivateGroupsCubit, PrivateGroupsState>(
            builder: (context, state) {
              switch (state.status) {
                case PrivateGroupsStatus.initial:
                  return const SizedBox();

                case PrivateGroupsStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Palette.cream,
                    ),
                  );

                case PrivateGroupsStatus.success:
                  if (state.privateGroups.isEmpty) {
                    return Center(
                      child: Text(
                        'No Groups Found!',
                        style: GoogleFonts.nunito(),
                      ),
                    );
                  } else {
                    return const PrivateGroupList();
                  }

                case PrivateGroupsStatus.failure:
                  return Center(
                    child: Text(
                      'Couldn\'t open groups',
                      style: GoogleFonts.nunito(),
                    ),
                  );

                default:
                  return const SizedBox();
              }
            },
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}

class PrivateGroupList extends StatelessWidget {
  const PrivateGroupList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupList = context.select(
      (PrivateGroupsCubit cubit) => cubit.state.privateGroups,
    );
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      key: Key('${groupList.length}'),
      itemCount: groupList.length,
      itemBuilder: (context, index) {
        return PrivateGroupListTile(
          group: groupList[index],
        );
      },
    );
  }
}

class PrivateGroupListTile extends StatelessWidget {
  const PrivateGroupListTile({
    Key? key,
    required Group group,
  })  : assert(group != null),
        _group = group,
        super(key: key);

  final Group _group;

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AuthenticationBloc>().state.user!.uid;
    final groupUsersLength =
        _group.users!.values.where((element) => element == true).length;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Palette.lightGrey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Palette.cream),
        boxShadow: const <BoxShadow>[
          BoxShadow(
              color: Palette.lightGrey,
              blurRadius: 1.2,
              offset: Offset(0.4, 0.6))
        ],
      ),
      child: ListTile(
        leading: _group.avatarUrl != null
            ? CircleAvatar(
                radius: 25,
                backgroundImage: CachedNetworkImageProvider(
                  _group.avatarUrl!,
                ), //Image for web configuration.
              )
            : const SizedBox(
                width: 50,
                child: Icon(
                  Icons.star,
                  size: 35,
                ),
              ),
        title: Text(
          _group.name!,
          style: Styles.leaderboardUsername,
        ),
        subtitle: Text(
          _group.isPublic! ? 'Public Group' : 'Private Group',
          style: Styles.normalText.copyWith(fontSize: 14),
        ),
        trailing: Column(
          children: [
            Text(
              '$groupUsersLength${_group.userLimit == 0 ? '' : '/${_group.userLimit}'}',
              style: Styles.leaderboardUsername.copyWith(
                color: _group.userLimit == 0 ||
                        _group.userLimit! > _group.users!.length
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
          Navigator.push<void>(
            context,
            GroupDetails.route(
              storageRepository: context.read<StorageRepository>(),
              groupId: _group.id,
              userId: userId,
            ),
          );
        },
      ),
    );
  }
}
