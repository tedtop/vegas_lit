import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/data/models/wallet.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';

part 'group_details_state.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  GroupDetailsCubit({
    @required GroupsRepository groupsRepository,
  })  : assert(groupsRepository != null),
        _groupsRepository = groupsRepository,
        super(
          GroupDetailsState(),
        );

  final GroupsRepository _groupsRepository;

  Future<void> fetchGroupDetailsLeaderboard({@required Group group}) async {
    emit(
      GroupDetailsState(status: GroupDetailsStatus.loading),
    );

    final leaderboardList =
        await _groupsRepository.fetchGroupLeaderboard(userList: group.users);

    emit(
      GroupDetailsState(
        status: GroupDetailsStatus.complete,
        players: leaderboardList,
        group: group,
      ),
    );
  }

  Future<void> addNewUser(
      {@required String groupId, @required String userId}) async {
    await _groupsRepository.addNewUserToGroup(groupId: groupId, userId: userId);
    await fetchGroupDetailsLeaderboard(group: state.group);
  }
}
