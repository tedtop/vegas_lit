import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/features/shared_widgets/bottom_bar.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../cubit/leaderboard_profile_cubit.dart';
import '../../widgets/leaderboard_profile_board_items.dart';
import '../../widgets/leaderboard_profile_card.dart';

class TabletLeaderboardProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<LeaderboardProfileCubit>().state;
    return state.status == LeaderboardProfileStatus.loading
        ? const Padding(
          padding:  EdgeInsets.only(top:160),
          child:  Center(
              child: CircularProgressIndicator(
                color: Palette.cream,
              ),
            ),
        )
        : Column(
      children: [
        const _TabletHistoryHeading(),
        const _TabletHistoryBoard(),
        const _TabletHistoryContent(),
        const BottomBar()
      ],
    );
  }
}

class _TabletHistoryBoard extends StatelessWidget {
  const _TabletHistoryBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final state = context.watch<LeaderboardProfileCubit>().state;
        switch (state.status) {
          case LeaderboardProfileStatus.initial:
            return const SizedBox();
            break;
          case LeaderboardProfileStatus.loading:
            return const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                color: Palette.cream,
              ),
            );
            break;
          case LeaderboardProfileStatus.success:
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
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Your Rank',
                        rightText:
                            '${state.userWallet.rank == 0 ? 'N/A' : state.userWallet.rank.ordinalNumber}',
                      ),
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Winnings',
                        rightText:
                            '\$${state.userWallet.totalRiskedAmount + state.userWallet.totalProfit - state.userWallet.totalLoss - state.userWallet.pendingRiskedAmount}',
                        color: Palette.cream,
                      ),
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Winning Bets',
                        rightText:
                            '${((state.userWallet.totalBetsWon / state.userWallet.totalBets).isNaN ? 0 : (state.userWallet.totalBetsWon / state.userWallet.totalBets) * 100).toStringAsFixed(0)}%',
                        color: Palette.cream,
                      ),
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Ad Rewards',
                        rightText: '\$${state.userWallet.totalRewards}',
                        color: Palette.cream,
                      ),
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Won/Lost/Open/Total',
                        rightText:
                            '${state.userWallet.totalBetsWon}/${state.userWallet.totalBetsLost}/${state.userWallet.totalOpenBets}/${state.userWallet.totalBets}',
                      ),
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Total Risked',
                        rightText: '\$${state.userWallet.totalRiskedAmount}',
                        color: Palette.cream,
                      ),
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Total Profit',
                        rightText: '\$${state.userWallet.totalProfit}',
                        color: state.userWallet.totalProfit >= 0
                            ? Palette.green
                            : Palette.red,
                      ),
                    ],
                  ),
                ),
              ),
            );

            break;
          case LeaderboardProfileStatus.failure:
            return const Center(
              child: Text('Some error occured.'),
            );
            break;
          default:
            return const SizedBox();
            break;
        }
      },
    );
  }
}

class _TabletHistoryContent extends StatelessWidget {
  const _TabletHistoryContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((LeaderboardProfileCubit cubit) => cubit.state.status);
    final bets = context.select((LeaderboardProfileCubit cubit) => cubit.state.bets);
    switch (status) {
      case LeaderboardProfileStatus.initial:
        return const SizedBox();
      case LeaderboardProfileStatus.loading:
        return const Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(
            color: Palette.cream,
          ),
        );
      case LeaderboardProfileStatus.success:
        if (bets.isEmpty) {
          return const _TabletHistoryEmpty();
        }
        return const _TabletHistoryList();
      case LeaderboardProfileStatus.failure:
        return const Center(
          child: Text('Some Error Occured'),
        );
      default:
        return const SizedBox();
    }
  }
}

class _TabletHistoryList extends StatelessWidget {
  const _TabletHistoryList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bets = context.select((LeaderboardProfileCubit cubit) => cubit.state.bets);
    return GridView.count(
      primary: true,
      childAspectRatio: 2.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      key: Key('${bets.length}'),
      children: bets
          .map(
            (betData) => FittedBox(
              child: LeaderboardProfileHistorySlip(betHistoryData: betData),
              fit: BoxFit.scaleDown,
            ),
          )
          .toList(),
    );
  }
}

class _TabletHistoryEmpty extends StatelessWidget {
  const _TabletHistoryEmpty({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 120),
      child: Text(
        'No bets resolved yet.',
        textAlign: TextAlign.center,
        style: Styles.betHistoryNormal,
      ),
    );
  }
}

class _TabletHistoryHeading extends StatelessWidget {
  const _TabletHistoryHeading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final betHistoryState = context.select((LeaderboardProfileCubit cubit) => cubit.state);

    return betHistoryState.status == LeaderboardProfileStatus.success
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                        '${betHistoryState.userWallet.username}',
                        style: Styles.pageTitle,
                      ),
              ),
            ],
          )
        : const SizedBox();
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
