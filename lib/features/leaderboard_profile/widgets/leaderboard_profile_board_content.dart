import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/palette.dart';

import '../leaderboard_profile.dart';
import 'leaderboard_profile_board_items.dart';

class LeaderboardProfileBoardContent extends StatelessWidget {
  const LeaderboardProfileBoardContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userWallet = context
        .select((LeaderboardProfileCubit cubit) => cubit.state.userWallet);
    return Row(
      children: [
        SizedBox(
          width: 140,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                    LeaderboardProfileHistoryBoardText(
                      leftText: 'Rank',
                      rightText:
                          '${userWallet.rank == 0 ? 'N/A' : userWallet.rank.ordinalNumber}',
                    ),
                    LeaderboardProfileHistoryBoardText(
                      leftText: 'Won',
                      rightText: '${userWallet.totalBetsWon}',
                    ),
                    LeaderboardProfileHistoryBoardText(
                      leftText: 'Lost',
                      rightText: '${userWallet.totalBetsLost}',
                    ),
                    LeaderboardProfileHistoryBoardText(
                      leftText: 'Open',
                      rightText: '${userWallet.totalOpenBets}',
                    ),
                    LeaderboardProfileHistoryBoardText(
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
            padding: const EdgeInsets.all(8.0),
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
                    LeaderboardProfileHistoryBoardText(
                      leftText: 'Total Bet',
                      rightText: '\$${userWallet.totalRiskedAmount}',
                    ),
                    LeaderboardProfileHistoryBoardText(
                      leftText: 'Total Won',
                      rightText:
                          '\$${userWallet.totalRiskedAmount + userWallet.totalProfit - userWallet.totalLoss - userWallet.pendingRiskedAmount}',
                    ),
                    // LeaderboardProfileHistoryBoardText(
                    //   leftText: 'Biggest Win',
                    //   rightText: '\$${userWallet.biggestWinAmount}',
                    // ),
                    LeaderboardProfileHistoryBoardText(
                      leftText: 'Ad Rewards',
                      rightText: '\$${userWallet.totalRewards}',
                    ),
                    //  Should replace with biggest win
                    LeaderboardProfileHistoryBoardText(
                      leftText: 'Total Profit',
                      rightText: '\$${userWallet.totalProfit}',
                    ),
                    LeaderboardProfileHistoryBoardText(
                      leftText: 'Balance',
                      rightText: '\$${userWallet.accountBalance}',
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
