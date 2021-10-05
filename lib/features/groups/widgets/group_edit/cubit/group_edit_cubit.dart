import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';
import 'package:vegas_lit/data/repositories/storage_repository.dart';
import 'package:vegas_lit/utils/logger.dart';

part 'group_edit_state.dart';

class GroupEditCubit extends Cubit<GroupEditState> {
  GroupEditCubit(
      {@required GroupsRepository groupsRepository,
      @required StorageRepository storageRepository})
      : assert(groupsRepository != null),
        assert(storageRepository != null),
        _groupsRepository = groupsRepository,
        _storageRepository = storageRepository,
        super(
          GroupEditState(status: GroupEditStatus.initial),
        );

  final GroupsRepository _groupsRepository;
  final StorageRepository _storageRepository;

  Future<void> pickAvatar() async {
    final avatarPickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);
    if (avatarPickedFile != null) {
      final avatarImageFile = File(avatarPickedFile.path);
      emit(
        GroupEditState(
          status: GroupEditStatus.initial,
          avatarFile: avatarImageFile,
        ),
      );
    } else {
      logger.i('Failed to pick icon!');
    }
  }

  void editGroup({@required Group group}) async {
    emit(state.copyWith(status: GroupEditStatus.loading));

    if (state.avatarFile != null) {
      try {
        final avatarUrl = await _storageRepository.uploadFile(
          file: state.avatarFile,
          path: 'groups/${group.id}/',
        );
        group = group.copyWith(avatarUrl: avatarUrl);
      } catch (e) {
        logger.i('Failed to upload icon!');
      }
    } else {
      logger.i('No icon added!');
    }

    await _groupsRepository.updateGroup(group: group, groupId: group.id);

    emit(GroupEditState(status: GroupEditStatus.success));
  }
}