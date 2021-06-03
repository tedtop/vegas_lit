import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/repositories/bets_repository.dart';
import 'package:vegas_lit/features/history/cubit/history_cubit.dart';
import 'package:vegas_lit/features/history/views/adaptive_widgets/mobile_bet_history.dart';
import 'package:vegas_lit/features/history/views/adaptive_widgets/tablet_bet_history.dart';
import 'package:vegas_lit/features/history/views/adaptive_widgets/web_bet_history.dart';
import 'package:vegas_lit/features/home/widgets/bottombar.dart';

class History extends StatelessWidget {
  const History._({Key key}) : super(key: key);

  static Builder route({@required String uid}) {
    return Builder(
      builder: (context) {
        return BlocProvider<HistoryCubit>(
          create: (context) => HistoryCubit(
            betsRepository: context.read<BetsRepository>(),
          )..fetchAllBets(uid: uid),
          child: const History._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const _HistoryHeading(),
        ScreenTypeLayout(
          mobile: MobileHistory(),
          tablet: TabletHistory(),
          desktop: WebHistory(),
        ),
        kIsWeb ? const BottomBar() : const SizedBox(),
      ],
    );
  }
}

class _HistoryHeading extends StatelessWidget {
  const _HistoryHeading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'BET HISTORY',
            style: Styles.pageTitle,
          ),
        ),
      ],
    );
  }
}
