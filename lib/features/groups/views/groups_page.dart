import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';
import 'package:vegas_lit/features/groups/cubit/groups_cubit.dart';
import 'package:vegas_lit/features/groups/widgets/group_add/group_add.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage._({Key key}) : super(key: key);

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) => GroupsCubit(
            groupsRepository: context.read<GroupsRepository>()
              ..fetchPublicGroups(),
          ),
          child: const GroupsPage._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                GroupAdd.route(),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<GroupsCubit, GroupsState>(
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
                    'Couldn\'t open groups',
                    style: GoogleFonts.nunito(),
                  ),
                );
              }
              return const GroupList();
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
    return ListTile(
      title: Text(_group.name),
    );
  }
}
