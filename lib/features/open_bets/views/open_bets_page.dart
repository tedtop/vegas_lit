import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/data/repositories/bets_repository.dart';
import 'package:vegas_lit/features/home/widgets/bottombar.dart';
import 'package:vegas_lit/features/open_bets/cubit/open_bets_cubit.dart';

import 'adaptive_views/desktop_open_bets.dart';
import 'adaptive_views/mobile_open_bets.dart';
import 'adaptive_views/tablet_open_bets.dart';

class OpenBets extends StatelessWidget {
  const OpenBets._({Key key}) : super(key: key);

  static Builder route({@required String uid}) {
    return Builder(
      builder: (context) {
        return BlocProvider<OpenBetsCubit>(
          create: (context) => OpenBetsCubit(
            betsRepository: context.read<BetsRepository>(),
          )..fetchAllBets(uid: uid),
          child: const OpenBets._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ScreenTypeLayout(
            mobile: MobileOpenBets(),
            tablet: TabletOpenBets(),
            desktop: DesktopOpenBets(),
          ),
          kIsWeb ? const BottomBar() : const SizedBox(),
        ],
      ),
    );
  }
}
