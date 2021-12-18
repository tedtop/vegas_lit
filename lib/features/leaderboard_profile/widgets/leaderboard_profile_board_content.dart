import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/bet_history/widgets/bet_history_board_items.dart';

import '../../../config/palette.dart';
import '../leaderboard_profile.dart';
import 'leaderboard_profile_board_items.dart';

class LeaderboardProfileBoardContent extends StatelessWidget {
  const LeaderboardProfileBoardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userWallet = context
        .select((LeaderboardProfileCubit cubit) => cubit.state.userWallet!);
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
