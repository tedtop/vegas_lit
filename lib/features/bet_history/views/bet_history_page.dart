import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/data/repositories/bets_repository.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';
import 'package:vegas_lit/features/bet_history/bet_history.dart';
import 'package:vegas_lit/features/home/cubit/home_cubit.dart';

import 'adaptive_bet_history/desktop_bet_history.dart';
import 'adaptive_bet_history/mobile_bet_history.dart';
import 'adaptive_bet_history/tablet_bet_history.dart';

class History extends StatelessWidget {
  const History._({Key key}) : super(key: key);

  static Builder route({@required String uid}) {
    return Builder(
      builder: (context) {
        return const History._();
      },
    );
  }

  static Route navigation(
      {@required String uid, @required HomeCubit homeCubit}) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider.value(
        value: homeCubit,
        child: BlocProvider<HistoryCubit>(
          create: (context) => HistoryCubit(
            betsRepository: context.read<BetsRepository>(),
            userRepository: context.read<UserRepository>(),
          )..fetchAllBets(uid: uid),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'BET HISTORY',
                style: GoogleFonts.nunito(
                  fontSize: 30,
                  color: Palette.cream,
                ),
              ),
            ),
            body: const History._(),
          ),
        ),
      ),
      settings: const RouteSettings(name: 'UserProfile'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ScreenTypeLayout(
            mobile: MobileBetHistory(),
            tablet: TabletBetHistory(),
            desktop: DesktopBetHistory(),
          ),
        ],
      ),
    );
  }
}
