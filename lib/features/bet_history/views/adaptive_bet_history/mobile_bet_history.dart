import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/features/home/cubit/home_cubit.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../cubit/history_cubit.dart';
import '../../widgets/bet_history_board_items.dart';
import '../../widgets/bet_history_card.dart';

class MobileBetHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MobileHistoryHeading(),
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
            return const _MobileHistoryBoardContent();
            break;
          case HistoryStatus.failure:
            return const Center(
              child: Text('Some Error Occured'),
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

class _MobileHistoryBoardContent extends StatelessWidget {
  const _MobileHistoryBoardContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userWallet =
        context.select((HistoryCubit cubit) => cubit.state.userWallet);
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
                    '${userWallet.rank == 0 ? 'N/A' : userWallet.rank.ordinalNumber}',
              ),
              BetHistoryBoardText(
                leftText: 'Winnings',
                rightText:
                    '\$${userWallet.totalRiskedAmount + userWallet.totalProfit - userWallet.totalLoss - userWallet.pendingRiskedAmount}',
                color: Palette.cream,
              ),
              BetHistoryBoardText(
                leftText: 'Winning Bets',
                rightText:
                    '${((userWallet.totalBetsWon / userWallet.totalBets).isNaN ? 0 : (userWallet.totalBetsWon / userWallet.totalBets) * 100).toStringAsFixed(0)}%',
                color: Palette.cream,
              ),
              BetHistoryBoardText(
                leftText: 'Rewards',
                rightText: '\$${userWallet.totalRewards}',
                color: Palette.cream,
              ),
              BetHistoryBoardText(
                leftText: 'Won/Lost/Open/Total',
                rightText:
                    '${userWallet.totalBetsWon}/${userWallet.totalBetsLost}/${userWallet.totalOpenBets}/${userWallet.totalBets}',
              ),
              BetHistoryBoardText(
                leftText: 'Total Risked',
                rightText: '\$${userWallet.totalRiskedAmount}',
                color: Palette.cream,
              ),
              BetHistoryBoardText(
                leftText: 'Total Profit',
                rightText: '\$${userWallet.totalProfit}',
                color:
                    userWallet.totalProfit >= 0 ? Palette.green : Palette.red,
              ),
            ],
          ),
        ),
      ),
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
        return const Padding(
          padding: EdgeInsets.only(top: 25),
          child: CircularProgressIndicator(
            color: Palette.cream,
          ),
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
        return Center(
          child: BetHistorySlip(
            betHistoryData: bets[index],
          ),
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

class _MobileHistoryHeading extends StatelessWidget {
  const _MobileHistoryHeading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final betHistoryState = context.select((HistoryCubit cubit) => cubit.state);
    final currentUserUid =
        context.select((HomeCubit cubit) => cubit.state?.userWallet?.uid);

    return betHistoryState.status == HistoryStatus.success
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: currentUserUid == betHistoryState.userWallet.uid
                    ? Text(
                        'BET HISTORY',
                        style: Styles.pageTitle,
                      )
                    : Text(
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
