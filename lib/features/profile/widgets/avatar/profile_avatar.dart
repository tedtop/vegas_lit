import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/data/repositories/storage_repository.dart';
import 'package:vegas_lit/features/profile/cubit/profile_cubit.dart';

import '../../../../config/palette.dart';
import '../../../../data/repositories/user_repository.dart';
import 'cubit/profileavatar_cubit.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar._({Key key}) : super(key: key);

  static Widget route() {
    return RepositoryProvider(
      create: (context) => StorageRepository(),
      child: Builder(
        builder: (context) => BlocProvider<ProfileAvatarCubit>(
          create: (_) => ProfileAvatarCubit(
            storageRepository: context.read<StorageRepository>(),
            userRepository: context.read<UserRepository>(),
          ),
          child: const ProfileAvatar._(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileAvatarCubit, ProfileAvatarState>(
      listener: (context, state) {
        switch (state.status) {
          case ProfileAvatarStatus.success:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text(
                    'Profile Updated!',
                  ),
                ),
              );
            break;
          case ProfileAvatarStatus.failure:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text(
                    'Some Error Occured!',
                  ),
                ),
              );
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        final username = context.watch<ProfileCubit>().state.userData.username;
        final currentUserId = context.watch<ProfileCubit>().state.userData.uid;
        final avatarUrl =
            context.watch<ProfileCubit>().state.userData.avatarUrl;
        switch (state.status) {
          case ProfileAvatarStatus.loading:
            return CircleAvatar(
              radius: 50,
              child: ClipOval(
                child: Container(
                  alignment: Alignment.center,
                  color: Palette.darkGrey,
                  height: 100.0,
                  width: 100.0,
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: Palette.cream,
                  )),
                ),
              ),
            );
            break;

          default:
            return InkWell(
              onTap: () {
                context
                    .read<ProfileAvatarCubit>()
                    .pickAvatar(uid: currentUserId);
              },
              child: avatarUrl != null
                  ? CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: Image.network(avatarUrl, fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                              color: Palette.cream,
                            ),
                          );
                        }),
                      ),
                    )
                  : CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: Container(
                          alignment: Alignment.center,
                          color: Palette.darkGrey,
                          height: 100.0,
                          width: 100.0,
                          child: Text(
                            username.substring(0, 1).toUpperCase(),
                            style: GoogleFonts.nunito(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
            );
            break;
        }
      },
    );
  }
}
