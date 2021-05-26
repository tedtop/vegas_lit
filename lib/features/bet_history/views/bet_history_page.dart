import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/bet_history/views/adaptive_widgets/mobile_bet_history.dart';
import 'package:vegas_lit/features/bet_history/views/adaptive_widgets/tablet_bet_history.dart';
import 'package:vegas_lit/features/bet_history/views/adaptive_widgets/web_bet_history.dart';
import 'package:vegas_lit/features/home/widgets/bottombar.dart';
import 'package:vegas_lit/features/open_bets/cubit/open_bets_cubit.dart';

class BetHistoryPage extends StatelessWidget {
  const BetHistoryPage._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return const BetHistoryPage._();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final openBetsState = context.watch<OpenBetsCubit>().state;

        if (openBetsState.status == OpenBetsStatus.opened) {
          final betPlacedLength = openBetsState.openBetsDataList.length;
          final betAmountRisk =
              openBetsState.openBetsDataList.map((e) => e.betAmount).toList();

          return ListView(
            children: [
              Row(
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
              ),
              ScreenTypeLayout(
                mobile: MobileBetHistory(
                  betPlacedLength: betPlacedLength,
                  betAmountRisk: betAmountRisk,
                ),
                tablet: TabletBetHistory(
                  betAmountRisk: betAmountRisk,
                  betPlacedLength: betPlacedLength,
                ),
                desktop: WebBetHistory(
                  betAmountRisk: betAmountRisk,
                  betPlacedLength: betPlacedLength,
                ),
              ),
              kIsWeb ? const BottomBar() : const SizedBox(),
            ],
          );
        } else {
          return const CircularProgressIndicator(
            color: Palette.cream,
          );
        }
      },
    );
  }
}
