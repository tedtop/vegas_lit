import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/history/cubit/history_cubit.dart';
import 'package:vegas_lit/features/history/views/bet_history_card.dart';
import 'package:vegas_lit/features/history/widgets/bet_history_board_text.dart';
import 'package:vegas_lit/features/home/cubit/home_cubit.dart';

class MobileHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MobileHistoryBoard(),
        const _MobileHistoryContent(),
      ],
    );
  }
}

class _MobileHistoryBoard extends StatelessWidget {
  const _MobileHistoryBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final state = context.watch<HomeCubit>().state;
        switch (state.status) {
          case HomeStatus.initial:
            return const CircularProgressIndicator(
              color: Palette.cream,
            );
            break;
          default:
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
                        rightText: state.userWallet.totalBets.toString(),
                      ),
                      BetHistoryBoardText(
                        leftText: 'Total Risked',
                        rightText: '\$${state.userWallet.totalRiskedAmount}',
                        color: Palette.red,
                      ),
                      BetHistoryBoardText(
                        leftText: 'Total Profit',
                        rightText: '\$${state.userWallet.totalProfit}',
                        color: state.userWallet.totalProfit >= 0
                            ? Palette.green
                            : Palette.red,
                      ),
                      BetHistoryBoardText(
                        leftText: 'Win/Loss Ratio',
                        rightText:
                            '${(state.userWallet.totalBetsWon / state.userWallet.totalBetsLost) > 0 ? (state.userWallet.totalBetsWon / state.userWallet.totalBetsLost).toStringAsFixed(3) : 0}',
                        color: Palette.cream,
                      ),
                    ],
                  ),
                ),
              ),
            );
            break;
        }
      },
    );
  }
}

class _MobileHistoryContent extends StatelessWidget {
  const _MobileHistoryContent({Key key}) : super(key: key);

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
          return const _MobileHistoryEmpty();
        }
        return const _MobileHistoryList();
      case HistoryStatus.failure:
        return const Center(
          child: Text('Some Error Occured'),
        );
      default:
        return const SizedBox();
    }
  }
}

class _MobileHistoryList extends StatelessWidget {
  const _MobileHistoryList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bets = context.select((HistoryCubit cubit) => cubit.state.bets);
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      key: Key('${bets.length}'),
      itemCount: bets.length,
      itemBuilder: (context, index) {
        return BetHistorySlip(
          betHistoryData: bets[index],
        );
      },
    );
  }
}

class _MobileHistoryEmpty extends StatelessWidget {
  const _MobileHistoryEmpty({Key key}) : super(key: key);

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
