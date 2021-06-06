import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/features/shared_widgets/bottom_bar.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../cubit/history_cubit.dart';
import '../../widgets/bet_history_board_items.dart';
import '../../widgets/bet_history_card.dart';

class TabletBetHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            return const CircularProgressIndicator(
              color: Palette.cream,
            );
            break;
          case HistoryStatus.success:
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
                      BetHistoryBoardText(
                        leftText: 'Your Rank',
                        rightText:
                            '${state.userWallet.rank == 0 ? 'N/A' : state.userWallet.rank.ordinalNumber}',
                      ),
                      BetHistoryBoardText(
                        leftText: 'Winnings',
                        rightText:
                            '\$${state.userWallet.totalRiskedAmount + state.userWallet.totalProfit - state.userWallet.totalLoss - state.userWallet.pendingRiskedAmount}',
                        color: Palette.cream,
                      ),
                      BetHistoryBoardText(
                        leftText: 'Winning Bets',
                        rightText:
                            '${((state.userWallet.totalBetsWon / state.userWallet.totalBets).isNaN ? 0 : (state.userWallet.totalBetsWon / state.userWallet.totalBets) * 100).toStringAsFixed(0)}%',
                        color: Palette.cream,
                      ),
                      BetHistoryBoardText(
                        leftText: 'Rewards',
                        rightText: '\$${state.userWallet.totalRewards}',
                        color: Palette.cream,
                      ),
                      BetHistoryBoardText(
                        leftText: 'Won/Lost/Open/Total',
                        rightText:
                            '${state.userWallet.totalBetsWon}/${state.userWallet.totalBetsLost}/${state.userWallet.totalOpenBets}/${state.userWallet.totalBets}',
                      ),
                      BetHistoryBoardText(
                        leftText: 'Total Risked',
                        rightText: '\$${state.userWallet.totalRiskedAmount}',
                        color: Palette.cream,
                      ),
                      BetHistoryBoardText(
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
        return const CircularProgressIndicator(
          color: Palette.cream,
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
    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: GridView.count(
        primary: true,
        childAspectRatio: 2.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        shrinkWrap: true,
        key: Key('${bets.length}'),
        children: bets
            .map(
              (betData) => FittedBox(
                child: BetHistorySlip(betHistoryData: betData),
                fit: BoxFit.scaleDown,
              ),
            )
            .toList(),
      ),
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
