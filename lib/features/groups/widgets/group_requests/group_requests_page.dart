import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/data/repositories/storage_repository.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/group.dart';
import '../../../../data/repositories/groups_repository.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../../home/home.dart';
import '../group_add/group_add.dart';
import 'cubit/group_requests_cubit.dart';

class GroupRequests extends StatelessWidget {
  const GroupRequests._({Key? key}) : super(key: key);

  static Builder route({required String? uid}) {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (_) => GroupRequestsCubit(
            groupsRepository: context.read<GroupsRepository>(),
          )..openGroupRequests(uid: uid),
          child: const GroupRequests._(),
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
          BlocBuilder<GroupRequestsCubit, GroupRequestsState>(
            builder: (context, state) {
              switch (state.status) {
                case GroupRequestsStatus.initial:
                  return const SizedBox();

                case GroupRequestsStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Palette.cream,
                    ),
                  );

                case GroupRequestsStatus.success:
                  if (state.groups.isEmpty) {
                    return Center(
                      child: Text(
                        'No Groups Found!',
                        style: GoogleFonts.nunito(),
                      ),
                    );
                  } else {
                    return const GroupRequestsList();
                  }

                case GroupRequestsStatus.failure:
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
        ],
      ),
    );
  }
}

class GroupRequestsList extends StatelessWidget {
  const GroupRequestsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupList = context.select(
      (GroupRequestsCubit cubit) => cubit.state.groups,
    );
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      key: Key('${groupList.length}'),
      itemCount: groupList.length,
      itemBuilder: (context, index) {
        return GroupRequestsListTile(
          group: groupList[index],
        );
      },
    );
  }
}

class GroupRequestsListTile extends StatelessWidget {
  const GroupRequestsListTile({
    Key? key,
    required Group group,
  })  : assert(group != null),
        _group = group,
        super(key: key);

  final Group _group;

  @override
  Widget build(BuildContext context) {
    final groupUsersLength =
        _group.users!.values.where((element) => element == true).length;
    final userId = context.watch<AuthenticationBloc>().state.user!.uid;
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
      child: ExpansionTile(
        leading: const Icon(
          Icons.star,
          size: 35,
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(1),
                  backgroundColor: MaterialStateProperty.all(Palette.green),
                ),
                onPressed: () async {
                  await context
                      .read<GroupRequestsCubit>()
                      .acceptGroup(groupId: _group.id, uid: userId);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    'Accept',
                    style: GoogleFonts.nunito(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(),
              TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(1),
                  backgroundColor: MaterialStateProperty.all(Palette.red),
                ),
                onPressed: () async {
                  await context
                      .read<GroupRequestsCubit>()
                      .rejectGroup(groupId: _group.id, uid: userId);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    'Reject',
                    style: GoogleFonts.nunito(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
