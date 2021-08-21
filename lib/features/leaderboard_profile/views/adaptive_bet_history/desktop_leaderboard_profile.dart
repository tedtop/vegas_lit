import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/bet.dart';
import '../../../../data/models/wallet.dart';
import '../../../../utils/bottom_bar.dart';
import '../../cubit/leaderboard_profile_cubit.dart';
import '../../widgets/leaderboard_profile_board_items.dart';

class DesktopLeaderboardProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<LeaderboardProfileCubit>().state;
    return state.status == LeaderboardProfileStatus.loading
        ? const Padding(
            padding: EdgeInsets.only(top: 160),
            child: Center(
              child: CircularProgressIndicator(
                color: Palette.cream,
              ),
            ),
          )
        : Container(
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
        final state = context.watch<LeaderboardProfileCubit>().state;
        switch (state.status) {
          case LeaderboardProfileStatus.initial:
            return const SizedBox();
            break;
          case LeaderboardProfileStatus.loading:
            return const CircularProgressIndicator(
              color: Palette.cream,
            );
            break;
          case LeaderboardProfileStatus.success:
            return _DesktopHistoryBoardContent(wallet: state.userWallet);
            break;
          case LeaderboardProfileStatus.failure:
            return const Center(
              child: AutoSizeText('Some error occured.'),
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

class _DesktopHistoryBoardContent extends StatelessWidget {
  const _DesktopHistoryBoardContent({Key key, this.wallet}) : super(key: key);

  final Wallet wallet;
  @override
  Widget build(BuildContext context) {
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
                bottomText: 'Player Rank',
                topText:
                    '${wallet.rank == 0 ? 'N/A' : wallet.rank.ordinalNumber}',
              ),
              DesktopBetHistoryBoardItem(
                bottomText: 'Total Bets',
                topText: '${wallet.totalBets}',
              ),
              DesktopBetHistoryBoardItem(
                bottomText: 'Total Risked',
                topText: '${wallet.totalRiskedAmount}',
              ),
              DesktopBetHistoryBoardItem(
                bottomText: 'Total Profit',
                topText: '${wallet.totalProfit}',
                color: wallet.totalProfit >= 0 ? Palette.green : Palette.red,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DesktopBetHistoryBoardItem(
                bottomText: 'Winnings',
                topText:
                    '${wallet.totalRiskedAmount + wallet.totalProfit - wallet.totalLoss - wallet.pendingRiskedAmount}',
              ),
              DesktopBetHistoryBoardItem(
                bottomText: betHistoryWinningBetsRatioText(),
                topText: betHistoryWinningBetsRatio(
                  wallet.totalBetsWon,
                  wallet.totalBetsLost,
                ),
              ),
              DesktopBetHistoryBoardItem(
                bottomText: 'Ad Rewards',
                topText: '${wallet.totalRewards}',
              ),
              DesktopBetHistoryBoardItem(
                bottomText: 'Won/Lost/Open/Total',
                topText:
                    '${wallet.totalBetsWon}/${wallet.totalBetsLost}/${wallet.totalOpenBets}/${wallet.totalBets}',
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _DesktopHistoryContent extends StatelessWidget {
  const _DesktopHistoryContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardProfileCubit, LeaderboardProfileState>(
      builder: (context, state) {
        switch (state.status) {
          case LeaderboardProfileStatus.success:
            if (state.bets.isEmpty) {
              return const _DesktopBetHistoryTableEmpty();
            } else {
              return _DesktopBetHistoryTable(
                bets: state.bets,
              );
            }
            break;
          case LeaderboardProfileStatus.initial:
            return const SizedBox();
            break;
          case LeaderboardProfileStatus.loading:
            return const CircularProgressIndicator(
              color: Palette.cream,
            );
            break;
          case LeaderboardProfileStatus.failure:
            return const Center(
              child: AutoSizeText('Some Error Occured'),
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
        child: AutoSizeText(
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
    final betHistoryState =
        context.select((LeaderboardProfileCubit cubit) => cubit.state);

    return betHistoryState.status == LeaderboardProfileStatus.success
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  '${betHistoryState.userWallet.username}',
                  style: Styles.pageTitle,
                ),
              ),
            ],
          )
        : const SizedBox();
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
                child:
                    AutoSizeText(entry, style: Styles.betHistoryDesktopField),
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
  final dynamic bet;
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
                              child: AutoSizeText(
                                  '${DateFormat('dd-MMM-yyyy').format(startTime)} at ${DateFormat('hh:mm a').format(
                                    startTime,
                                  )} EST',
                                  style: Styles.betHistoryDesktopTime),
                            );
                          case 'League':
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 18),
                              child: AutoSizeText('${bet.league.toUpperCase()}',
                                  style: Styles.betHistoryDesktopItem),
                            );
                          case 'Game':
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 18),
                              child: AutoSizeText(
                                  '${bet.awayTeamName.toUpperCase()} @ ${bet.homeTeamName.toUpperCase()}',
                                  style: Styles.betHistoryDesktopItem),
                            );
                          case 'Bet':
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 18),
                              child: AutoSizeText(
                                  '${whichBetSystemFromString(bet.betType)}  ${isMoneyline ? '' : spread}  $odd',
                                  style: Styles.betHistoryDesktopItem),
                            );
                          case 'Risked':
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 18),
                                child: AutoSizeText('${bet.betAmount}',
                                    style: Styles.betHistoryDesktopItem));
                          case 'Result':
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 18),
                                child: AutoSizeText(
                                    isWin
                                        ? '${bet.betProfit}'
                                        : '-${bet.betAmount}',
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

String whichBetSystemFromString(String betType) {
  if (betType == 'moneyline') {
    return 'MONEYLINE';
  }
  if (betType == 'pointspread') {
    return 'POINT SPREAD';
  }
  if (betType == 'total') {
    return 'TOTAL O/U';
  }
  if (betType == 'olympics') {
    return 'OLYMPICS';
  } else {
    return 'ERROR';
  }
}

String betHistoryWinningBetsRatio(int betsWon, int betsLost) {
  return '${(betsWon / (betsWon + betsLost)).isNaN ? 0 : (betsWon / (betsWon + betsLost) * 100).toStringAsFixed(0)}%';
}

String betHistoryWinningBetsRatioText() {
  return 'Winning Bets';
}
