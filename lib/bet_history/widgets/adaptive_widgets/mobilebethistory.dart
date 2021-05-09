import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/bet_history/cubit/bet_history_cubit.dart';
import 'package:vegas_lit/bet_history/screens/bet_history_page.dart';
import 'package:vegas_lit/bet_history/widgets/bet_history_card.dart';
import 'package:vegas_lit/bet_history/widgets/textbar.dart';
import 'package:vegas_lit/config/palette.dart';

class MobileBetHistory extends StatefulWidget {
  MobileBetHistory({this.betPlacedLength, this.betAmountRisk});
  final int betPlacedLength;
  final List<int> betAmountRisk;
  @override
  _MobileBetHistoryState createState() => _MobileBetHistoryState();
}

class _MobileBetHistoryState extends State<MobileBetHistory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       const Expanded(
        //         flex: 1,
        //         child: TextBar(
        //           text: 'All Bet Types',
        //         ),
        //       ),
        //       const Expanded(
        //         flex: 1,
        //         child: TextBar(
        //           text: 'All Leagues',
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 8,
          ),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Palette.lightGrey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8,
              ),
              child: BlocBuilder<BetHistoryCubit, BetHistoryState>(
                builder: (context, state) {
                  final totalProfit = state.betHistoryDataList.isEmpty
                      ? 0
                      : state.betHistoryDataList
                          .map((e) {
                            return e.winTeam == e.betTeam ? e.betProfit : 0;
                          })
                          .toList()
                          .reduce((value, element) => value + element);
                  switch (state.status) {
                    case BetHistoryStatus.opened:
                      return Column(
                        children: [
                          const BetHistoryRow(
                            text: 'Your Rank',
                            text2: 'N/A',
                          ),
                          BetHistoryRow(
                            text: 'Total Bets Placed',
                            text2: (widget.betPlacedLength +
                                    state.betHistoryDataList.length)
                                .toString(),
                          ),
                          BetHistoryRow(
                            text: 'Total Risked',
                            text2:
                                // ignore: lines_longer_than_80_chars
                                '\$${totalRisk(firstList: widget.betAmountRisk, secondList: state.betHistoryDataList.map((e) => e.betAmount).toList())}',
                            color: Palette.green,
                          ),
                          BetHistoryRow(
                            text: 'Total Profit',
                            text2:
                                // ignore: lines_longer_than_80_chars
                                '\$$totalProfit',
                            color: Palette.red,
                          ),
                        ],
                      );
                      break;
                    default:
                      return const CircularProgressIndicator();
                      break;
                  }
                },
              ),
            ),
          ),
        ),
        BlocBuilder<BetHistoryCubit, BetHistoryState>(
          builder: (context, state) {
            switch (state.status) {
              case BetHistoryStatus.opened:
                if (state.betHistoryDataList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 120),
                    child: Text(
                      // ignore: lines_longer_than_80_chars
                      'No bets resolved yet.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        color: Palette.cream,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  key: Key('${state.betHistoryDataList.length}'),
                  itemCount: state.betHistoryDataList.length,
                  itemBuilder: (context, index) {
                    return BetHistorySlip(
                      betHistory: state.betHistoryDataList[index],
                    );
                  },
                );
                break;
              default:
                return const CircularProgressIndicator();
                break;
            }
          },
        ),
      ],
    );
  }
}
