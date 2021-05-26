import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/features/bet_history/cubit/bet_history_cubit.dart';
import 'package:vegas_lit/features/bet_history/views/bet_history_card.dart';
import 'package:vegas_lit/features/bet_history/widgets/bet_history_board_text.dart';
import 'package:vegas_lit/features/home/cubit/home_cubit.dart';

class MobileBetHistory extends StatefulWidget {
  MobileBetHistory({this.betPlacedLength, this.betAmountRisk});
  final int betPlacedLength;
  final List<int> betAmountRisk;
  @override
  _MobileBetHistoryState createState() => _MobileBetHistoryState();
}

class _MobileBetHistoryState extends State<MobileBetHistory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MobileBetHistoryBoard(),
        MobileBetHistoryList(),
      ],
    );
  }
}

class MobileBetHistoryBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final userWallet = context
            .select((HomeCubit homeCubit) => homeCubit.state?.userWallet);
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
                    rightText: userWallet.totalBets.toString(),
                  ),
                  BetHistoryBoardText(
                    leftText: 'Total Risked',
                    rightText: userWallet.totalRiskedAmount.toString(),
                    color: Palette.red,
                  ),
                  BetHistoryBoardText(
                    leftText: 'Total Profit',
                    rightText: '\$${userWallet.totalProfit}',
                    color: userWallet.totalProfit >= 0
                        ? Palette.green
                        : Palette.red,
                  ),
                  BetHistoryBoardText(
                    leftText: 'Win/Loss Ratio',
                    rightText:
                        '${(userWallet.totalBetsWon / userWallet.totalBetsLost) > 0 ? (userWallet.totalBetsWon / userWallet.totalBetsLost).toStringAsFixed(3) : 0}',
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

class MobileBetHistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BetHistoryCubit, BetHistoryState>(
      builder: (context, state) {
        switch (state.status) {
          case BetHistoryStatus.opened:
            if (state.betHistoryListData.isEmpty) {
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
            return ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              key: Key('${state.betHistoryListData.length}'),
              itemCount: state.betHistoryListData.length,
              itemBuilder: (context, index) {
                return BetHistorySlip(
                  betHistoryData: state.betHistoryListData[index],
                );
              },
            );
            break;
          default:
            return const CircularProgressIndicator(
              color: Palette.cream,
            );
            break;
        }
      },
    );
  }
}
