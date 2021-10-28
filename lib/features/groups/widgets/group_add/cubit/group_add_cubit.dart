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
      {required GroupsRepository groupsRepository,
      required StorageRepository storageRepository})
      : _groupsRepository = groupsRepository,
        _storageRepository = storageRepository,
        super(
          GroupAddState(),
        );

  final GroupsRepository _groupsRepository;
  final StorageRepository _storageRepository;

  Future<void> pickAvatar() async {
    final avatarPickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);
    if (avatarPickedFile != null) {
      final avatarImageFile = File(avatarPickedFile.path);
      emit(
        GroupAddState(
          avatarFile: avatarImageFile,
        ),
      );
    } else {
      print('Failed to pick icon!');
    }
  }

  Future<void> addGroup({required Group group}) async {
    emit(state.copyWith(status: GroupAddStatus.loading));

    await _groupsRepository.addNewGroup(group: group).then(
      (id) async {
        if (state.avatarFile != null) {
          try {
            final avatarUrl = await _storageRepository.uploadFile(
              file: state.avatarFile!,
              path: 'groups/$id/',
            );
            await _groupsRepository.updateGroupAvatar(
              avatarUrl: avatarUrl,
              groupId: id,
            );
          } catch (e) {
            print('Failed to upload icon!');
          }
        } else {
          print('No icon added!');
        }
      },
    );

    emit(GroupAddState(status: GroupAddStatus.success));
  }
}
