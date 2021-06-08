import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';

import 'cubit/profileavatar_cubit.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar._(
      {Key key, this.avatarUrl, this.username, this.currentUserId})
      : super(key: key);

  static Widget route(
      {@required String avatarUrl,
      @required String username,
      @required String currentUserId}) {
    return Builder(
      builder: (context) => BlocProvider<ProfileAvatarCubit>(
        create: (_) => ProfileAvatarCubit(
            userRepository: context.read<UserRepository>(), uid: currentUserId),
        child: ProfileAvatar._(
          avatarUrl: avatarUrl,
          currentUserId: currentUserId,
          username: username,
        ),
      ),
    );
  }

  final String avatarUrl;
  final String currentUserId;
  final String username;

  @override
  Widget build(BuildContext context) {
    // return
    // BlocBuilder<ProfileAvatarCubit, ProfileAvatarState>(
    //   builder: (context, state) {
    //     switch (state.status) {
    //       case ProfileAvatarStatus.none:
    return InkWell(
      onTap: () {
        context
            .read<ProfileAvatarCubit>()
            .pickAvatar(currentUserId: currentUserId);
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

    //        case ProfileAvatarStatus.updating:
    //           return CircleAvatar(
    //             radius: 50,
    //             child: ClipOval(
    //               child: Container(
    //                 alignment: Alignment.center,
    //                 color: Palette.darkGrey,
    //                 height: 100.0,
    //                 width: 100.0,
    //                 child: const Center(
    //                     child: CircularProgressIndicator(
    //                   color: Palette.cream,
    //                 )),
    //               ),
    //             ),
    //           );
    //           break;
    //         default:
    //           return Container();
    //       }
    //     },
    //   );
  }
}
