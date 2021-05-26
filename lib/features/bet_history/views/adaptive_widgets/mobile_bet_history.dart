import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/features/bet_history/cubit/bet_history_cubit.dart';
import 'package:vegas_lit/features/bet_history/views/bet_history_card.dart';
import 'package:vegas_lit/features/bet_history/widgets/bet_history_board_text.dart';
import 'package:vegas_lit/features/bet_history/widgets/bet_history_functions.dart';

class MobileBetHistory extends StatelessWidget {
  MobileBetHistory({this.betPlacedLength, this.betAmountRisk});
  final int betPlacedLength;
  final List<int> betAmountRisk;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MobileBetHistoryBoard(
          betAmountRisk: betAmountRisk,
          betPlacedLength: betPlacedLength,
        ),
        MobileBetHistoryList(),
      ],
    );
  }
}

class MobileBetHistoryBoard extends StatelessWidget {
  const MobileBetHistoryBoard(
      {Key key, @required this.betPlacedLength, @required this.betAmountRisk})
      : super(key: key);
  final int betPlacedLength;
  final List<int> betAmountRisk;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final betHistoryDataList = context.select(
            (BetHistoryCubit betHistoryCubit) =>
                betHistoryCubit.state?.betHistoryListData);
        final totalWin = betHistoryDataList
            .where((element) => element.betTeam == element.winningTeam)
            .length;
        final totalLose = betHistoryDataList
            .where((element) => element.betTeam != element.winningTeam)
            .length;
        final totalProfit = betHistoryDataList.isEmpty
            ? 0
            : betHistoryDataList
                .map((e) {
                  return e.winningTeam == e.betTeam ? e.betProfit : 0;
                })
                .toList()
                .reduce((value, element) => value + element);
        return Padding(
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
              child: Column(
                children: [
                  const BetHistoryBoardText(
                    leftText: 'Your Rank',
                    rightText: 'N/A',
                  ),
                  BetHistoryBoardText(
                    leftText: 'Total Bets Placed',
                    rightText: (betPlacedLength + betHistoryDataList.length)
                        .toString(),
                  ),
                  BetHistoryBoardText(
                    leftText: 'Total Risked',
                    rightText:
                        '\$${totalRisk(firstList: betAmountRisk, secondList: betHistoryDataList.map((e) => e.betAmount).toList())}',
                    color: Palette.red,
                  ),
                  BetHistoryBoardText(
                    leftText: 'Total Profit',
                    rightText: '\$$totalProfit',
                    color: totalProfit >= 0 ? Palette.green : Palette.red,
                  ),
                  BetHistoryBoardText(
                    leftText: 'Win/Loss Ratio',
                    rightText:
                        '${(totalWin / totalLose) > 0 ? (totalWin / totalLose).toStringAsFixed(3) : 0}',
                    color: Palette.cream,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MobileBetHistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BetHistoryCubit, BetHistoryState>(
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
            return ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              key: Key('${state.betHistoryListData.length}'),
              itemCount: state.betHistoryListData.length,
              itemBuilder: (context, index) {
                return BetHistorySlip(
                  betHistoryData: state.betHistoryListData[index],
                );
              },
            );
            break;
          default:
            return const CircularProgressIndicator(
              color: Palette.cream,
            );
            break;
        }
      },
    );
  }
}
