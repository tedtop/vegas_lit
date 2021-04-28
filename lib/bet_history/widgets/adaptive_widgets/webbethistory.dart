import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/bet_history/cubit/bet_history_cubit.dart';
import 'package:vegas_lit/bet_history/screens/bet_history_page.dart';
import 'package:vegas_lit/bet_history/widgets/bet_history_card.dart';
import 'package:vegas_lit/bet_history/widgets/textbar.dart';
import 'package:vegas_lit/config/palette.dart';

class WebBetHistory extends StatefulWidget {
  WebBetHistory({this.betPlacedLength, this.betAmountRisk});
  final int betPlacedLength;
  final List<int> betAmountRisk;
  @override
  _WebBetHistoryState createState() => _WebBetHistoryState();
}

class _WebBetHistoryState extends State<WebBetHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1220),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const TextBar(
                  text: 'All Bet Types',
                ),
                const TextBar(
                  text: 'All Leagues',
                ),
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ),
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
                  horizontal: 25,
                  vertical: 15,
                ),
                child: BlocBuilder<BetHistoryCubit, BetHistoryState>(
                  builder: (context, state) {
                    final totalProfit = state.betHistoryDataList.isEmpty
                        ? 0
                        : state.betHistoryDataList
                            .map((e) => e.amountWin)
                            .toList()
                            .reduce((value, element) => value + element)
                            .toDouble();
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
                              text: 'Total Risk',
                              text2:
                                  // ignore: lines_longer_than_80_chars
                                  '\$${totalRisk(firstList: widget.betAmountRisk, secondList: state.betHistoryDataList.map((e) => e.amountBet).toList())}',
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
                  return Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: GridView.count(
                      primary: true,
                      childAspectRatio: 2.8,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      key: Key('${state.betHistoryDataList.length}'),
                      children: state.betHistoryDataList
                          .map((betData) => Center(
                                child: FittedBox(
                                  child: BetHistorySlip(betHistory: betData),
                                  fit: BoxFit.scaleDown,
                                ),
                              ))
                          .toList(),
                    ),
                  );
                  break;
                default:
                  return const CircularProgressIndicator();
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
