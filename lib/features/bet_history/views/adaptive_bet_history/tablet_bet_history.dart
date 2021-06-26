import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../shared_widgets/bottom_bar.dart';
import '../../cubit/history_cubit.dart';
import '../../widgets/bet_history_board_items.dart';
import '../../widgets/bet_history_card.dart';

class TabletBetHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<HistoryCubit>().state;
    return state.status == HistoryStatus.loading
        ? const Padding(
            padding: EdgeInsets.only(top: 160),
            child: Center(
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
        final state = context.watch<HistoryCubit>().state;
        switch (state.status) {
          case HistoryStatus.initial:
            return const SizedBox();
            break;
          case HistoryStatus.loading:
            return const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                color: Palette.cream,
              ),
            );
            break;
          case HistoryStatus.success:
            return const _TabletBetHistoryBoardContent();
            break;
          case HistoryStatus.failure:
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

class _TabletBetHistoryBoardContent extends StatelessWidget {
  const _TabletBetHistoryBoardContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userWallet =
        context.select((HistoryCubit cubit) => cubit.state.userWallet);
    return Container(
      constraints: const BoxConstraints(minWidth: 380, maxWidth: 600),
      child: Row(
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
                      BetHistoryBoardText(
                        leftText: 'Total Bet',
                        rightText: '\$${userWallet.totalRiskedAmount}',
                      ),
                      BetHistoryBoardText(
                        leftText: 'Total Won',
                        rightText:
                            '\$${userWallet.totalRiskedAmount + userWallet.totalProfit - userWallet.totalLoss - userWallet.pendingRiskedAmount}',
                      ),
                      // BetHistoryBoardText(
                      //   leftText: 'Biggest Win',
                      //   rightText: '\$${userWallet.biggestWinAmount}',
                      // ),

                      BetHistoryBoardText(
                        leftText: 'Ad Rewards',
                        rightText: '\$${userWallet.totalRewards}',
                      ),
                      //  Should replace with biggest win
                      BetHistoryBoardText(
                        leftText: 'Total Profit',
                        rightText: '\$${userWallet.totalProfit}',
                      ),
                      BetHistoryBoardText(
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
      ),
    );
  }
}

class _TabletHistoryContent extends StatelessWidget {
  const _TabletHistoryContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((HistoryCubit cubit) => cubit.state.status);
    final bets = context.select((HistoryCubit cubit) => cubit.state.bets);
    switch (status) {
      case HistoryStatus.initial:
        return const SizedBox();
      case HistoryStatus.loading:
        return const Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(
            color: Palette.cream,
          ),
        );
      case HistoryStatus.success:
        if (bets.isEmpty) {
          return const _TabletHistoryEmpty();
        }
        return const _TabletHistoryList();
      case HistoryStatus.failure:
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
    final bets = context.select((HistoryCubit cubit) => cubit.state.bets);
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
              child: BetHistorySlip(betHistoryData: betData),
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
    return Row(
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
