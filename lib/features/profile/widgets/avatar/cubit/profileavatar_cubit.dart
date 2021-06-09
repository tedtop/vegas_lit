import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../config/paths.dart';
import '../../../../../data/repositories/storage_repository.dart';
import '../../../../../data/repositories/user_repository.dart';

part 'profileavatar_state.dart';

class ProfileAvatarCubit extends Cubit<ProfileAvatarState> {
  ProfileAvatarCubit(
      {@required UserRepository userRepository, @required String uid})
      : assert(userRepository != null && uid != null),
        _userRepository = userRepository,
        _uid = uid,
        super(
          const ProfileAvatarState.none(),
        );

  final UserRepository _userRepository;
  final String _uid;

  Future<void> pickAvatar({@required String currentUserId}) async {
    final avatarPickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (avatarPickedFile == null) {
      emit(const ProfileAvatarState.none());
      return;
    }
    final avatarImageFile = File(avatarPickedFile.path);
    emit(const ProfileAvatarState.updating());
    final avatarUrl = await StorageRepository()
        .uploadFile(file: avatarImageFile, path: Paths.profilePicturePath);
    await _userRepository.updateUserAvatar(avatarUrl: avatarUrl, uid: _uid);
    emit(const ProfileAvatarState.none());
    //print('state is none now');
  }
}
