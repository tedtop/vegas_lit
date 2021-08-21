import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/palette.dart';

import '../bet_history.dart';
import 'bet_history_board_items.dart';

class BetHistoryBoardContent extends StatelessWidget {
  const BetHistoryBoardContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userWallet =
        context.select((HistoryCubit cubit) => cubit.state.userWallet);
    return Row(
      children: [
        SizedBox(
          width: 165,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 8.0, right: 2.0),
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
                    BetHistoryBoardText(
                      leftText: 'Rank',
                      rightText:
                          '${userWallet.rank == 0 ? 'N/A' : userWallet.rank.ordinalNumber}',
                    ),
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
                      rightText: '${userWallet.totalOpenBets}',
                    ),
                    BetHistoryBoardText(
                      leftText: 'Cancelled',
                      rightText:
                          '${userWallet.totalBets - (userWallet.totalBetsWon + userWallet.totalBetsLost + userWallet.totalOpenBets)}',
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
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 2.0, right: 8.0),
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
                    BetHistoryBoardText(
                      leftText: 'Total Bet',
                      rightText: '${userWallet.totalRiskedAmount}',
                    ),
                    BetHistoryBoardText(
                      leftText: 'Total Won',
                      rightText:
                          '${userWallet.totalRiskedAmount + userWallet.totalProfit - userWallet.totalLoss - userWallet.pendingRiskedAmount}',
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
          ),
        )
      ],
    );
  }
}

extension on int {
  String get ordinalNumber {
    if (this >= 11 && this <= 13) {
      return '${this}th';
    }
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }
}
