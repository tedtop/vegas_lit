import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../config/palette.dart';
import '../../../data/repositories/bets_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../home/cubit/home_cubit.dart';
import '../cubit/leaderboard_profile_cubit.dart';
import 'adaptive_bet_history/desktop_leaderboard_profile.dart';
import 'adaptive_bet_history/mobile_leaderboard_profile.dart';
import 'adaptive_bet_history/tablet_leaderboard_profile.dart';

class LeaderboardProfile extends StatelessWidget {
  const LeaderboardProfile._({Key key}) : super(key: key);

  static Builder route({@required String uid}) {
    return Builder(
      builder: (context) {
        return const LeaderboardProfile._();
      },
    );
  }

  static Route navigation(
      {@required String uid, @required HomeCubit homeCubit}) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider.value(
        value: homeCubit,
        child: BlocProvider<LeaderboardProfileCubit>(
          create: (context) => LeaderboardProfileCubit(
            betsRepository: context.read<BetsRepository>(),
            userRepository: context.read<UserRepository>(),
          )..fetchAllBets(uid: uid),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'PROFILE',
                style: GoogleFonts.nunito(
                  fontSize: 30,
                  color: Palette.cream,
                ),
              ),
            ),
            body: const LeaderboardProfile._(),
          ),
        ),
      ),
      settings: const RouteSettings(name: 'LeaderboardProfile'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ScreenTypeLayout(
          mobile: MobileLeaderboardProfile(),
          tablet: TabletLeaderboardProfile(),
          desktop: DesktopLeaderboardProfile(),
        ),
      ],
    );
  }
}