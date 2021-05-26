import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/features/bet_history/cubit/bet_history_cubit.dart';
import 'package:vegas_lit/features/bet_history/views/bet_history_card.dart';
import 'package:vegas_lit/features/bet_history/widgets/bet_history_board_text.dart';
import 'package:vegas_lit/features/bet_history/widgets/bet_history_functions.dart';

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
                    final totalProfit = state.betHistoryListData.isEmpty
                        ? 0
                        : state.betHistoryListData
                            .map((e) => e.betProfit)
                            .toList()
                            .reduce((value, element) => value + element)
                            .toDouble();
                    switch (state.status) {
                      case BetHistoryStatus.opened:
                        return Column(
                          children: [
                            const BetHistoryBoardText(
                              leftText: 'Your Rank',
                              rightText: 'N/A',
                            ),
                            BetHistoryBoardText(
                              leftText: 'Total Bets Placed',
                              rightText: (widget.betPlacedLength +
                                      state.betHistoryListData.length)
                                  .toString(),
                            ),
                            BetHistoryBoardText(
                              leftText: 'Total Risk',
                              rightText:
                                  '\$${totalRisk(firstList: widget.betAmountRisk, secondList: state.betHistoryListData.map((e) => e.betAmount).toList())}',
                              color: Palette.red,
                            ),
                            BetHistoryBoardText(
                              leftText: 'Total Profit',
                              rightText: '\$$totalProfit',
                              color:
                                  totalProfit > 0 ? Palette.green : Palette.red,
                            ),
                          ],
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
              ),
            ),
          ),
          BlocBuilder<BetHistoryCubit, BetHistoryState>(
            builder: (context, state) {
              switch (state.status) {
                case BetHistoryStatus.opened:
                  if (state.betHistoryListData.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 120),
                      child: Text(
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
                      key: Key('${state.betHistoryListData.length}'),
                      children: state.betHistoryListData
                          .map((betData) => Center(
                                child: FittedBox(
                                  child:
                                      BetHistorySlip(betHistoryData: betData),
                                  fit: BoxFit.scaleDown,
                                ),
                              ))
                          .toList(),
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
    );
  }
}
