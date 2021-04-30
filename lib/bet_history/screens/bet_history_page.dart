import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/bet_history/widgets/adaptive_widgets/mobilebethistory.dart';
import 'package:vegas_lit/bet_history/widgets/adaptive_widgets/tabletbethistory.dart';
import 'package:vegas_lit/bet_history/widgets/adaptive_widgets/webbethistory.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/home/widgets/bottombar.dart';
import 'package:vegas_lit/open_bets/cubit/open_bets_cubit.dart';

class BetHistory extends StatelessWidget {
  const BetHistory._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return const BetHistory._();
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
              openBetsState.openBetsDataList.map((e) => e.amountBet).toList();

          return SingleChildScrollView(
            child: Column(
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
                      betAmountRisk: betAmountRisk),
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
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class BetHistoryRow extends StatelessWidget {
  const BetHistoryRow({
    Key key,
    @required this.text,
    @required this.text2,
    this.color = Palette.cream,
  }) : super(key: key);

  final String text;
  final String text2;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Palette.cream,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              text2,
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String totalRisk({List<int> firstList, List<int> secondList}) {
  final firstListSum = firstList.isEmpty
      ? 0
      : firstList.reduce((value, element) => value + element);
  // final secondListSum = secondList.isEmpty
  //     ? 0
  //     : secondList.reduce((value, element) => value + element).toDouble();
  final totalSum = firstListSum;
  return totalSum.toString();
}
