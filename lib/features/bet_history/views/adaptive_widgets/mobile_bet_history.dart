import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/features/bet_history/cubit/history_cubit.dart';
import 'package:vegas_lit/features/bet_history/views/bet_history_card.dart';
import 'package:vegas_lit/features/bet_history/widgets/bet_history_board_text.dart';
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
        final wallet =
            context.select((HomeCubit cubit) => cubit.state.userWallet);
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
                    leftText: 'Total Risked',
                    rightText: wallet.totalRiskedAmount.toString(),
                    color: Palette.red,
                  ),
                  BetHistoryBoardText(
                    leftText: 'Total Profit',
                    rightText: wallet.totalProfit.toString(),
                    color:
                        wallet.totalProfit >= 0 ? Palette.green : Palette.red,
                  ),
                  BetHistoryBoardText(
                    leftText: 'Win/Loss Ratio',
                    rightText:
                        '${(wallet.totalBetsWon / wallet.totalBetsLost) > 0 ? (wallet.totalBetsWon / wallet.totalBetsLost).toStringAsFixed(3) : 0}',
                    color: Palette.cream,
                  ),
                ],
              ),
            ),
          ),
        );
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
          return const _HistoryEmpty();
        }
        return const _HistoryList();
      case HistoryStatus.failure:
        return const Center(
          child: Text('Some Error Occured'),
        );
      default:
        return const SizedBox();
    }
  }
}

class _HistoryList extends StatelessWidget {
  const _HistoryList({Key key}) : super(key: key);

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

class _HistoryEmpty extends StatelessWidget {
  const _HistoryEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 120),
      child: Text(
        'No bets resolved yet.',
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(
          color: Palette.cream,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
