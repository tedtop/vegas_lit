import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/palette.dart';
import '../../../../data/repositories/storage_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../cubit/profile_cubit.dart';
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
                  content: AutoSizeText(
                    'Your profile was updated.',
                  ),
                ),
              );
            break;
          case ProfileAvatarStatus.failure:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: AutoSizeText(
                    'An error occurred. Try again later.',
                  ),
                ),
              );
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        final username = context.watch<ProfileCubit>().state.userData?.username;
        final currentUserId = context.watch<ProfileCubit>().state.userData?.uid;
        final avatarUrl =
            context.watch<ProfileCubit>().state.userData?.avatarUrl;
        if (username == null)
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
            return Stack(
              children: [
                avatarUrl != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: CachedNetworkImageProvider(avatarUrl,
                            imageRenderMethodForWeb:
                                ImageRenderMethodForWeb.HttpGet),
                      )
                    : CircleAvatar(
                        radius: 50,
                        child: ClipOval(
                          child: Container(
                            alignment: Alignment.center,
                            color: Palette.darkGrey,
                            height: 100.0,
                            width: 100.0,
                            child: AutoSizeText(
                              username.substring(0, 1).toUpperCase(),
                              style: GoogleFonts.nunito(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                Positioned(
                    bottom: 5,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        context
                            .read<ProfileAvatarCubit>()
                            .pickAvatar(uid: currentUserId);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Palette.darkGrey,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Palette.cream)),
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.edit,
                              color: Palette.cream,
                              size: 12,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            AutoSizeText(
                              'Edit',
                              style: GoogleFonts.nunito(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            );
            break;
        }
      },
    );
  }
}
