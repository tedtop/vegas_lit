import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/features/bet_history/cubit/history_cubit.dart';
import 'package:vegas_lit/features/bet_history/views/bet_history_card.dart';
import 'package:vegas_lit/features/bet_history/widgets/bet_history_board_text.dart';
import 'package:vegas_lit/features/home/home.dart';

class TabletHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wallet = context.select((HomeCubit cubit) => cubit.state.userWallet);
    return Column(
      children: [
        Padding(
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
                      style: GoogleFonts.nunito(
                        color: Palette.cream,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                }
                return Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: GridView.count(
                    primary: true,
                    childAspectRatio: 2.5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    key: Key('${state.bets.length}'),
                    children: state.bets
                        .map((betData) => FittedBox(
                              child: BetHistorySlip(betHistoryData: betData),
                              fit: BoxFit.scaleDown,
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
    );
  }
}
