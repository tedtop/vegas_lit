

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../data/repositories/storage_repository.dart';
import '../../../../../data/repositories/user_repository.dart';

part 'profileavatar_state.dart';

class ProfileAvatarCubit extends Cubit<ProfileAvatarState> {
  ProfileAvatarCubit({
    required UserRepository userRepository,
    required StorageRepository storageRepository,
  })  : assert(userRepository != null),
        assert(storageRepository != null),
        _userRepository = userRepository,
        _storageRepository = storageRepository,
        super(
          const ProfileAvatarState(),
        );

  final UserRepository _userRepository;
  final StorageRepository _storageRepository;

  Future<void> pickAvatar({required String? uid}) async {
    final avatarPickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);
    if (avatarPickedFile == null) {
      emit(
        const ProfileAvatarState(),
      );
    } else {
      final avatarImageFile = File(avatarPickedFile.path);
      emit(
        const ProfileAvatarState(status: ProfileAvatarStatus.loading),
      );
      try {
        final avatarUrl = await _storageRepository.uploadFile(
          file: avatarImageFile,
          path: uid,
        );
        await _userRepository.updateUserAvatar(
          avatarUrl: avatarUrl,
          uid: uid,
        );
      } catch (e) {
        const ProfileAvatarState(status: ProfileAvatarStatus.failure);
      }
      emit(const ProfileAvatarState(status: ProfileAvatarStatus.success));
    }
  }
}
