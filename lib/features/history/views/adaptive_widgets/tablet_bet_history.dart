import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/history/cubit/history_cubit.dart';
import 'package:vegas_lit/features/history/views/bet_history_card.dart';
import 'package:vegas_lit/features/history/widgets/bet_history_board_text.dart';
import 'package:vegas_lit/features/home/home.dart';

class TabletHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _TabletHistoryBoard(),
        const _TabletHistoryContent(),
      ],
    );
  }
}

class _TabletHistoryBoard extends StatelessWidget {
  const _TabletHistoryBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((HomeCubit cubit) => cubit.state.userWallet);
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
                rightText: wallet.totalBets.toString(),
              ),
              BetHistoryBoardText(
                leftText: 'Total Risk',
                rightText: wallet.totalRiskedAmount.toString(),
                color: Palette.red,
              ),
              BetHistoryBoardText(
                leftText: 'Total Profit',
                rightText: wallet.totalProfit.toString(),
                color: wallet.totalProfit > 0 ? Palette.green : Palette.red,
              ),
            ],
          ),
        ),
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
