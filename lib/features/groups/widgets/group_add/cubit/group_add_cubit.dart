import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegas_lit/data/repositories/storage_repository.dart';

import '../../../../../data/models/group.dart';
import '../../../../../data/repositories/groups_repository.dart';

part 'group_add_state.dart';

class GroupAddCubit extends Cubit<GroupAddState> {
  GroupAddCubit(
      {@required GroupsRepository groupsRepository,
      @required StorageRepository storageRepository})
      : assert(groupsRepository != null),
        assert(storageRepository != null),
        _groupsRepository = groupsRepository,
        _storageRepository = storageRepository,
        super(
          GroupAddState(status: GroupAddStatus.initial),
        );

  final GroupsRepository _groupsRepository;
  final StorageRepository _storageRepository;

  Future<void> pickAvatar() async {
    final avatarPickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);
    if (avatarPickedFile != null) {
      final avatarImageFile = File(avatarPickedFile.path);
      try {
        final avatarUrl = await _storageRepository.uploadFile(
          file: avatarImageFile,
          path: 'groups',
        );
        emit(GroupAddState(
            status: GroupAddStatus.initial, avatarUrl: avatarUrl));
      } catch (e) {
        print('Failed to upload icon!');
      }
    }
  }

  void addGroup({@required Group group}) async {
    emit(GroupAddState(status: GroupAddStatus.loading));
    await _groupsRepository.addNewGroup(group: group);
    emit(GroupAddState(status: GroupAddStatus.success));
  }
}
