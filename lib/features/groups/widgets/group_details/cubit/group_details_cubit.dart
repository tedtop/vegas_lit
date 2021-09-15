import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegas_lit/data/repositories/storage_repository.dart';
import 'package:vegas_lit/utils/logger.dart';

import '../../../../../data/models/group.dart';
import '../../../../../data/models/wallet.dart';
import '../../../../../data/repositories/groups_repository.dart';

part 'group_details_state.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  GroupDetailsCubit({
    @required GroupsRepository groupsRepository,
    @required StorageRepository storageRepository,
  })  : assert(groupsRepository != null),
        assert(storageRepository != null),
        _groupsRepository = groupsRepository,
        _storageRepository = storageRepository,
        super(
          GroupDetailsState(),
        );

  final GroupsRepository _groupsRepository;
  final StorageRepository _storageRepository;
  StreamSubscription _groupDetailsSubscription;

  Future<void> fetchGroupDetailsLeaderboard(
      {@required String groupId, @required String userId}) async {
    emit(
      GroupDetailsState(status: GroupDetailsStatus.loading),
    );

    final groupStream = _groupsRepository.fetchGroupDetails(groupId: groupId);

    await _groupDetailsSubscription?.cancel();
    _groupDetailsSubscription = groupStream.listen(
      (group) async {
        final filteredMap = Map<String, bool>.from(group.users)
          ..removeWhere((k, v) => v == false);
        final userList = filteredMap.keys.toList();
        final leaderboardList = await _groupsRepository.fetchGroupLeaderboard(
          userList: userList,
        );
        leaderboardList.sort(
          (a, b) => (a.rank).compareTo(b.rank),
        );
        final leaderboardListWithRank =
            leaderboardList.where((element) => element.rank != 0).toList();
        final isMember = userList.contains(userId);
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

  Future<void> addNewUser({
    @required String groupId,
    @required Map<String, bool> users,
  }) async {
    await _groupsRepository.addNewUserToGroup(groupId: groupId, users: users);
  }

  Future<void> pickAvatar({@required String groupId}) async {
    final avatarPickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);
    if (avatarPickedFile == null) {
      emit(
        GroupDetailsState(
          status: GroupDetailsStatus.complete,
          group: state.group,
          isMember: state.isMember,
          players: state.players,
        ),
      );
    } else {
      final avatarImageFile = File(avatarPickedFile.path);
      emit(
        GroupDetailsState(status: GroupDetailsStatus.loading),
      );
      try {
        final avatarUrl = await _storageRepository.uploadFile(
          file: avatarImageFile,
          path: 'groups/$groupId/',
        );
        await _groupsRepository.updateGroupAvatar(
          avatarUrl: avatarUrl,
          groupId: groupId,
        );
        emit(GroupDetailsState(
          status: GroupDetailsStatus.complete,
          group: state.group.copyWith(avatarUrl: avatarUrl),
          isMember: state.isMember,
          players: state.players,
        ));
      } catch (e) {
        logger.i('Unable to update group avatar!');
        GroupDetailsState(
          status: GroupDetailsStatus.complete,
          group: state.group,
          isMember: state.isMember,
          players: state.players,
        );
      }
    }
  }

  @override
  Future<void> close() async {
    await _groupDetailsSubscription?.cancel();
    return super.close();
  }
}
