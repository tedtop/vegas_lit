import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';
import 'package:vegas_lit/features/authentication/bloc/authentication_bloc.dart';
import 'package:vegas_lit/features/groups/cubit/groups_cubit.dart';
import 'package:vegas_lit/features/groups/widgets/group_add/group_add.dart';
import 'package:vegas_lit/features/groups/widgets/group_details/group_details.dart';
import 'package:vegas_lit/features/home/cubit/home_cubit.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage._({Key key}) : super(key: key);

  static MaterialPageRoute route({@required HomeCubit homeCubit}) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider.value(
          value: homeCubit,
          child: BlocProvider(
            create: (context) => GroupsCubit(
              groupsRepository: context.read<GroupsRepository>(),
            )..openPublicGroups(),
            child: const GroupsPage._(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GROUPS', style: Styles.pageTitle),
      ),
      body: ListView(
        shrinkWrap: true,
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
          BlocBuilder<GroupsCubit, GroupsState>(
            builder: (context, state) {
              switch (state.status) {
                case GroupsStatus.initial:
                  return const SizedBox();
                  break;
                case GroupsStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Palette.cream,
                    ),
                  );
                  break;
                case GroupsStatus.success:
                  if (state.publicGroups.isEmpty) {
                    return Center(
                      child: Text(
                        'No Groups Found!',
                        style: GoogleFonts.nunito(),
                      ),
                    );
                  } else {
                    return const GroupList();
                  }
                  break;
                case GroupsStatus.failure:
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
      floatingActionButton: TextButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Palette.green),
        ),
        onPressed: () {
          Navigator.push(
            context,
            GroupAdd.route(
              homeCubit: context.read<HomeCubit>(),
            ),
          );
        },
        label: Text('CREATE', style: Styles.normalTextBold),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class GroupList extends StatelessWidget {
  const GroupList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupList =
        context.select((GroupsCubit cubit) => cubit.state?.publicGroups);
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      key: Key('${groupList.length}'),
      itemCount: groupList.length,
      itemBuilder: (context, index) {
        return GroupListTile(
          group: groupList[index],
        );
      },
    );
  }
}

class GroupListTile extends StatelessWidget {
  const GroupListTile({
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
              ));
        },
      ),
    );
  }
}
