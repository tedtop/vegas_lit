import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';
import 'package:vegas_lit/features/authentication/authentication.dart';
import 'package:vegas_lit/features/profile/cubit/profile_cubit.dart';
import 'package:vegas_lit/features/shared_widgets/app_bar.dart';

class Profile extends StatelessWidget {
  const Profile._({Key key}) : super(key: key);

  static Route route({@required String currentUserId}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'Profile'),
      builder: (context) => BlocProvider<ProfileCubit>(
        create: (_) => ProfileCubit(
          userRepository: context.read<UserRepository>(),
        )..openProfile(
            currentUserId: currentUserId,
          ),
        child: const Profile._(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'MY PROFILE',
                textAlign: TextAlign.center,
                style: Styles.pageTitle,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  switch (state.status) {
                    case ProfileStatus.opened:
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 380,
                          decoration: BoxDecoration(
                            color: Palette.lightGrey,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Palette.cream),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _PicWithName(),
                                const _UserDetails(),
                                const _Signout()
                              ],
                            ),
                          ),
                        ),
                      );

                      break;
                    default:
                      return const CircularProgressIndicator(
                        color: Palette.cream,
                      );
                      break;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PicWithName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final username = context.watch<ProfileCubit>().state.userData.username;
    return Stack(
      //fit: StackFit.expand,
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          width: 380,
          height: 200,
          padding: const EdgeInsets.only(bottom: 60),
          child: Image.asset(
            Images.allSportsBackground,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Container(
            alignment: Alignment.center,
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
                color: Palette.darkGrey,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Palette.cream)),
            child: Text(
              username.substring(0, 1).toUpperCase(),
              style: GoogleFonts.nunito(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 160),
          height: 50,
          child: Column(
            children: [
              Text(
                username,
                style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Palette.cream),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UserDetails extends StatelessWidget {
  const _UserDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state.userData.location;
    final email = context.watch<ProfileCubit>().state.userData.email;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: RichText(
            text: TextSpan(
              text: 'State\n',
              style: GoogleFonts.nunito(
                fontSize: 14,
                color: Palette.green,
                shadows: <Shadow>[
                  Shadow(
                    offset: const Offset(0, 2.0),
                    blurRadius: 2.0,
                    color: const Color(0xFF000000).withOpacity(0.25),
                  ),
                ],
              ),
              children: [
                TextSpan(
                  text: state,
                  style: GoogleFonts.nunito(fontSize: 20, color: Palette.cream),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: RichText(
            text: TextSpan(
              text: 'Email\n',
              style: GoogleFonts.nunito(
                fontSize: 14,
                color: Palette.green,
                shadows: <Shadow>[
                  Shadow(
                    offset: const Offset(0, 2.0),
                    blurRadius: 2.0,
                    color: const Color(0xFF000000).withOpacity(0.25),
                  ),
                ],
              ),
              children: [
                TextSpan(
                  text: email,
                  style: GoogleFonts.nunito(fontSize: 20, color: Palette.cream),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class _Signout extends StatelessWidget {
  const _Signout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.4),
                backgroundColor: MaterialStateProperty.all(Palette.red)),
            child: Text(
              'Sign out',
              style: Styles.normalTextBold,
            ),
            onPressed: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
