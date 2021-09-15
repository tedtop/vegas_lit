import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegas_lit/data/repositories/storage_repository.dart';
import 'package:vegas_lit/utils/logger.dart';

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
        emit(
          GroupAddState(
            status: GroupAddStatus.initial,
            avatarFile: avatarImageFile,
          ),
        );
      } catch (e) {
        logger.i('Failed to upload icon!');
      }
    }
  }

  void addGroup({@required Group group}) async {
    emit(state.copyWith(status: GroupAddStatus.loading));

    await _groupsRepository.addNewGroup(group: group).then(
      (id) async {
        if (state.avatarFile != null) {
          try {
            final avatarUrl = await _storageRepository.uploadFile(
              file: state.avatarFile,
              path: 'groups/$id/',
            );
            await _groupsRepository.updateGroup(
              avatarLink: avatarUrl,
              groupId: id,
            );
          } catch (e) {
            logger.i('Failed to upload icon!');
          }
        } else {
          logger.i('No icon added!');
        }
      },
    );

    emit(GroupAddState(status: GroupAddStatus.success));
  }
}
