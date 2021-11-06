import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../bet_history.dart';
import 'bet_history_board_items.dart';

class BetHistoryBoardContent extends StatelessWidget {
  const BetHistoryBoardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyState = context.watch<HistoryCubit>().state;
    if (historyState.status == HistoryStatus.success) {
      final userWallet = historyState.userWallet!;
      return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Palette.lightGrey,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 35,
              width: double.infinity,
              decoration: const BoxDecoration(color: Palette.cream),
              child: Center(
                child: Text(
                  'Rank ${userWallet.rank}',
                  style: Styles.homeTeam
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 165,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 6, left: 8, right: 2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          BetHistoryBoardText(
                            leftText: 'Won',
                            rightText: '${userWallet.totalBetsWon}',
                          ),
                          BetHistoryBoardText(
                            leftText: 'Lost',
                            rightText: '${userWallet.totalBetsLost}',
                          ),
                          BetHistoryBoardText(
                            leftText: 'Open',
                            rightText:
                                '${userWallet.totalOpenBets! < 0 ? 0 : userWallet.totalOpenBets}',
                          ),
                          BetHistoryBoardText(
                            leftText: 'Cancelled',
                            rightText:
                                '${userWallet.totalBets! - (userWallet.totalBetsWon! + userWallet.totalBetsLost! + userWallet.totalOpenBets!)}',
                          ),
                          BetHistoryBoardText(
                            leftText: 'Total',
                            rightText: '${userWallet.totalBets}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 6, left: 2, right: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          BetHistoryBoardText(
                            leftText: 'Total Bet',
                            rightText: '${userWallet.totalRiskedAmount}',
                          ),
                          BetHistoryBoardText(
                            leftText: 'Total Won',
                            rightText:
                                '${userWallet.totalRiskedAmount! + userWallet.totalProfit! - userWallet.totalLoss! - userWallet.pendingRiskedAmount!}',
                          ),
                          // BetHistoryBoardText(
                          //   leftText: 'Biggest Win',
                          //   rightText: '${userWallet.biggestWinAmount}',
                          // ),
                          BetHistoryBoardText(
                            leftText: 'Ad Rewards',
                            rightText: '${userWallet.totalRewards}',
                          ),
                          //  Should replace with biggest win
                          BetHistoryBoardText(
                            leftText: 'Total Profit',
                            rightText: '${userWallet.totalProfit}',
                          ),
                          // BetHistoryBoardText(
                          //   leftText: 'Total Refund',
                          //   rightText:
                          //       '${userWallet.totalRiskedAmount - userWallet.totalRewards - (userWallet.totalRiskedAmount - userWallet.totalLoss - userWallet.pendingRiskedAmount) - 1000}',
                          // ),
                          BetHistoryBoardText(
                            leftText: 'Balance',
                            rightText: '${userWallet.accountBalance}',
                            color: Palette.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
