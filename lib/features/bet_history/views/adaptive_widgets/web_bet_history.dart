import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../home/home.dart';
import '../../cubit/history_cubit.dart';
import '../../widgets/bet_history_board_text.dart';
import '../bet_history_card.dart';

class WebHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                child: Builder(builder: (context) {
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
                            horizontal: 25,
                            vertical: 15,
                          ),
                          child: Column(
                            children: [
                              const BetHistoryBoardText(
                                leftText: 'Your Rank',
                                rightText: 'N/A',
                              ),
                              BetHistoryBoardText(
                                leftText: 'Total Bets Placed',
                                rightText:
                                    state.userWallet.totalBets.toString(),
                              ),
                              BetHistoryBoardText(
                                leftText: 'Total Risk',
                                rightText: state.userWallet.totalRiskedAmount
                                    .toString(),
                                color: Palette.red,
                              ),
                              BetHistoryBoardText(
                                leftText: 'Total Profit',
                                rightText:
                                    state.userWallet.totalProfit.toString(),
                                color: state.userWallet.totalProfit > 0
                                    ? Palette.green
                                    : Palette.red,
                              ),
                            ],
                          ));
                  }
                })),
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
