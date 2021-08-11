import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/data/models/wallet.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';

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
  StreamSubscription _groupDetailsSubscription;

  Future<void> fetchGroupDetailsLeaderboard(
      {@required String groupId, @required String userId}) async {
    emit(
      GroupDetailsState(status: GroupDetailsStatus.loading),
    );

    final groupStream = _groupsRepository.fetchPublicGroup(groupId: groupId);

    await _groupDetailsSubscription?.cancel();
    _groupDetailsSubscription = groupStream.listen(
      (group) async {
        final leaderboardList = await _groupsRepository.fetchGroupLeaderboard(
            userList: group.users);
        leaderboardList.sort(
          (a, b) => (a.rank).compareTo(b.rank),
        );
        final leaderboardListWithRank =
            leaderboardList.where((element) => element.rank != 0).toList();
        final isMember = group.users.contains(userId);
        emit(
          GroupDetailsState(
            status: GroupDetailsStatus.complete,
            players: leaderboardListWithRank,
            group: group,
            isMember: isMember,
          ),
        );
      },
    );
  }

  Future<void> addNewUser(
      {@required String groupId, @required String userId}) async {
    await _groupsRepository.addNewUserToGroup(groupId: groupId, userId: userId);
  }

  @override
  Future<void> close() async {
    await _groupDetailsSubscription?.cancel();
    return super.close();
  }
}
