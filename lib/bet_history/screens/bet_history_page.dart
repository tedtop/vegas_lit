import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/bet_history/cubit/bet_history_cubit.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/home/widgets/bottombar.dart';
import 'package:vegas_lit/open_bets/cubit/open_bets_cubit.dart';

import 'bet_history_card.dart';

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
                const TextBar(
                  text: 'All Bet Types',
                ),
                const TextBar(
                  text: 'All Leagues',
                ),
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
                                    text2: (betPlacedLength +
                                            state.betHistoryDataList.length)
                                        .toString(),
                                  ),
                                  BetHistoryRow(
                                    text: 'Total Risk',
                                    text2:
                                        // ignore: lines_longer_than_80_chars
                                        '\$${totalRisk(firstList: betAmountRisk, secondList: state.betHistoryDataList.map((e) => e.amountBet).toList())}',
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

  String totalRisk({List<int> firstList, List<int> secondList}) {
    final firstListSum = firstList.isEmpty
        ? 0
        : firstList.reduce((value, element) => value + element).toDouble();
    final secondListSum = secondList.isEmpty
        ? 0
        : secondList.reduce((value, element) => value + element).toDouble();
    final totalSum = firstListSum + secondListSum;
    return totalSum.toString();
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

class TextBar extends StatelessWidget {
  const TextBar({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Container(
          color: Palette.green,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          height: 40,
          width: double.infinity,
          child: Center(
            child: DropdownButton<String>(
              dropdownColor: Palette.green,
              isDense: true,
              value: 'All Bet Types',
              icon: const Icon(
                Icons.arrow_circle_down,
                color: Palette.cream,
              ),
              isExpanded: true,
              underline: Container(
                height: 0,
              ),
              style: GoogleFonts.nunito(
                fontSize: 18,
              ),
              onChanged: print,
              items: <String>[
                'All Bet Types',
              ].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Palette.cream,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
