import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/data/models/bet.dart';
import 'package:vegas_lit/features/open_bets/views/open_bets_card.dart';
import 'package:vegas_lit/features/shared_widgets/bottom_bar.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../cubit/history_cubit.dart';
import '../../widgets/bet_history_board_items.dart';

class DesktopBetHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1220),
      child: Column(
        children: [
          const _DesktopHistoryHeading(),
          const _DesktopHistoryBoard(),
          const _DesktopHistoryContent(),
          const BottomBar()
        ],
      ),
    );
  }
}

class _DesktopHistoryBoard extends StatelessWidget {
  const _DesktopHistoryBoard({Key key}) : super(key: key);

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
            return Container(
              constraints: const BoxConstraints(maxWidth: 1220),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Palette.lightGrey,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        blurRadius: 0.4,
                        offset: const Offset(0, 4.0),
                        color: Palette.lightGrey.withAlpha(80))
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DesktopBetHistoryBoardItem(
                        bottomText: 'Your Rank',
                        topText:
                            '${state.userWallet.rank == 0 ? 'N/A' : state.userWallet.rank.ordinalNumber}',
                      ),
                      DesktopBetHistoryBoardItem(
                        bottomText: 'Total Bets',
                        topText: '\$${state.userWallet.totalBets}',
                      ),
                      DesktopBetHistoryBoardItem(
                        bottomText: 'Total Risked',
                        topText: '\$${state.userWallet.totalRiskedAmount}',
                      ),
                      DesktopBetHistoryBoardItem(
                        bottomText: 'Total Profit',
                        topText: '\$${state.userWallet.totalProfit}',
                        color: state.userWallet.totalProfit >= 0
                            ? Palette.green
                            : Palette.red,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DesktopBetHistoryBoardItem(
                        bottomText: 'Winnings',
                        topText:
                            '\$${state.userWallet.totalRiskedAmount + state.userWallet.totalProfit - state.userWallet.totalLoss - state.userWallet.pendingRiskedAmount}',
                      ),
                      DesktopBetHistoryBoardItem(
                        bottomText: 'Winning Bets',
                        topText:
                            '${((state.userWallet.totalBetsWon / state.userWallet.totalBets).isNaN ? 0 : (state.userWallet.totalBetsWon / state.userWallet.totalBets) * 100).toStringAsFixed(0)}%',
                      ),
                      DesktopBetHistoryBoardItem(
                        bottomText: 'Rewards',
                        topText: '\$${state.userWallet.totalRewards}',
                      ),
                      DesktopBetHistoryBoardItem(
                        bottomText: 'Won/Lost/Open/Total',
                        topText:
                            '${state.userWallet.totalBetsWon}/${state.userWallet.totalBetsLost}/${state.userWallet.totalOpenBets}/${state.userWallet.totalBets}',
                      ),
                    ],
                  )
                ],
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

class _DesktopHistoryContent extends StatelessWidget {
  const _DesktopHistoryContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        switch (state.status) {
          case HistoryStatus.success:
            if (state.bets.isEmpty) {
              return const _DesktopBetHistoryTableEmpty();
            } else {
              return _DesktopBetHistoryTable(
                bets: state.bets,
              );
            }
            break;
          case HistoryStatus.initial:
            return const SizedBox();
            break;
          case HistoryStatus.loading:
            return const CircularProgressIndicator(
              color: Palette.cream,
            );
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

class _DesktopBetHistoryTableEmpty extends StatelessWidget {
  const _DesktopBetHistoryTableEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 120),
        child: Text(
          'No bets resolved yet.',
          textAlign: TextAlign.center,
          style: Styles.betHistoryNormal,
        ),
      ),
    );
  }
}

class _DesktopBetHistoryTable extends StatelessWidget {
  const _DesktopBetHistoryTable({Key key, this.bets}) : super(key: key);
  final List<BetData> bets;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Palette.cream),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1220),
              child: Column(
                children: [
                  const _DesktopBetHistoryTableHeading(),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 1220),
                    height: 8,
                    color: Palette.green,
                  ),
                  Column(
                    children: bets
                        .map((entry) => _DesktopBetHistoryTableRow(
                              bet: entry,
                            ))
                        .toList(),
                  ),
                  Container(
                    height: 8,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: Palette.lightGrey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DesktopHistoryHeading extends StatelessWidget {
  const _DesktopHistoryHeading({Key key}) : super(key: key);

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

class _DesktopBetHistoryTableHeading extends StatelessWidget {
  const _DesktopBetHistoryTableHeading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      color: Palette.lightGrey,
      child: Row(
        children: tableHeadingsWithWidth.keys
            .map(
              (entry) => SizedBox(
                child: Text(entry, style: Styles.betHistoryDesktopField),
                width: tableHeadingsWithWidth[entry].toDouble(),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _DesktopBetHistoryTableRow extends StatelessWidget {
  const _DesktopBetHistoryTableRow({Key key, this.bet}) : super(key: key);
  final BetData bet;
  @override
  Widget build(BuildContext context) {
    final isWin = bet.winningTeam == bet.betTeam;
    final startTime = DateTime.parse(bet.gameStartDateTime);
    final odd = bet.odds.isNegative ? bet.odds.toString() : '+${bet.odds}';

    var isMoneyline = true;
    var betSpread = 0.0;
    var spread = '0';

    if (bet.betOverUnder != null || bet.betPointSpread != null) {
      isMoneyline = bet.betType == 'moneyline';
      betSpread =
          bet.betType == 'total' ? bet.betOverUnder : bet.betPointSpread;
      spread = betSpread == 0
          ? ''
          : betSpread.isNegative
              ? betSpread.toString()
              : '+$betSpread';
    }

    return Container(
        constraints: const BoxConstraints(minHeight: 50),
        color: Palette.lightGrey,
        child: Row(
            children: tableHeadingsWithWidth.keys
                .map((entry) => SizedBox(
                      child: Builder(builder: (context) {
                        switch (entry) {
                          case 'Date/Time':
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 18),
                              child: Text(
                                  '${DateFormat('dd-MMM-yyyy').format(startTime)} at ${DateFormat('hh:mm a').format(
                                    startTime,
                                  )} EST',
                                  style: Styles.betHistoryDesktopTime),
                            );
                          case 'League':
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 18),
                              child: Text('${bet.league.toUpperCase()}',
                                  style: Styles.betHistoryDesktopItem),
                            );
                          case 'Game':
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 18),
                              child: Text(
                                  '${bet.awayTeamName.toUpperCase()} @ ${bet.homeTeamName.toUpperCase()}',
                                  style: Styles.betHistoryDesktopItem),
                            );
                          case 'Bet':
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 18),
                              child: Text(
                                  '${whichBetSystem(bet.betType)}  ${isMoneyline ? '' : spread}  $odd',
                                  style: Styles.betHistoryDesktopItem),
                            );
                          case 'Risked':
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 18),
                                child: Text('\$${bet.betAmount}',
                                    style: Styles.betHistoryDesktopItem));
                          case 'Result':
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 18),
                                child: Text(
                                    isWin
                                        ? '\$${bet.betProfit}'
                                        : '-\$${bet.betAmount}',
                                    style: Styles.betHistoryDesktopItem));
                          default:
                            return const SizedBox();
                        }
                      }),
                      width: tableHeadingsWithWidth[entry].toDouble(),
                    ))
                .toList()));
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

const tableHeadingsWithWidth = {
  '': 20,
  'Date/Time': 310,
  'League': 150,
  'Game': 150,
  'Bet': 300,
  'Risked': 140,
  'Result': 140
};
