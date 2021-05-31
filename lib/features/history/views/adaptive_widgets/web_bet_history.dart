import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/history/cubit/history_cubit.dart';
import 'package:vegas_lit/features/history/views/bet_history_card.dart';
import 'package:vegas_lit/features/history/widgets/bet_history_board_text.dart';
import 'package:vegas_lit/features/home/home.dart';

class WebHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wallet = context.select((HomeCubit cubit) => cubit.state.userWallet);
    return Container(
      constraints: const BoxConstraints(maxWidth: 1220),
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ),
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
                  horizontal: 25,
                  vertical: 15,
                ),
                child: BlocBuilder<HistoryCubit, HistoryState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case HistoryStatus.success:
                        return Column(
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
                              color: wallet.totalProfit > 0
                                  ? Palette.green
                                  : Palette.red,
                            ),
                          ],
                        );
                        break;
                      default:
                        return const CircularProgressIndicator(
                          color: Palette.cream,
                        );
                        break;
                    }
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<HistoryCubit, HistoryState>(
            builder: (context, state) {
              switch (state.status) {
                case HistoryStatus.success:
                  if (state.bets.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 120),
                      child: Text(
                        'No bets resolved yet.',
                        textAlign: TextAlign.center,
                        style: Styles.betHistoryNormal,
                      ),
                    );
                  }
                  return Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: GridView.count(
                      primary: true,
                      childAspectRatio: 2.8,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      key: Key('${state.bets.length}'),
                      children: state.bets
                          .map((betData) => Center(
                                child: FittedBox(
                                  child:
                                      BetHistorySlip(betHistoryData: betData),
                                  fit: BoxFit.scaleDown,
                                ),
                              ))
                          .toList(),
                    ),
                  );
                  break;
                default:
                  return const CircularProgressIndicator(
                    color: Palette.cream,
                  );
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
