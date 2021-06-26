import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../shared_widgets/bottom_bar.dart';
import '../../cubit/leaderboard_profile_cubit.dart';
import '../../widgets/leaderboard_profile_board_items.dart';
import '../../widgets/leaderboard_profile_card.dart';

class TabletLeaderboardProfile extends StatelessWidget {
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
        : Column(
            children: [
              const _TabletHistoryHeading(),
              const _TabletHistoryBoard(),
              const _TabletHistoryContent(),
              const BottomBar()
            ],
          );
  }
}

class _TabletHistoryBoard extends StatelessWidget {
  const _TabletHistoryBoard({Key key}) : super(key: key);

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
            return const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                color: Palette.cream,
              ),
            );
            break;
          case LeaderboardProfileStatus.success:
            return const _TabletBetHistoryBoardContent();
            break;
          case LeaderboardProfileStatus.failure:
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

class _TabletBetHistoryBoardContent extends StatelessWidget {
  const _TabletBetHistoryBoardContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userWallet = context
        .select((LeaderboardProfileCubit cubit) => cubit.state.userWallet);
    return Container(
      constraints: const BoxConstraints(minWidth: 380, maxWidth: 600),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Rank',
                        rightText:
                            '${userWallet.rank == 0 ? 'N/A' : userWallet.rank.ordinalNumber}',
                      ),
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Won',
                        rightText: '${userWallet.totalBetsWon}',
                      ),
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Lost',
                        rightText: '${userWallet.totalBetsLost}',
                      ),
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Open',
                        rightText: '${userWallet.totalOpenBets}',
                      ),
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Total',
                        rightText: '${userWallet.totalBets}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Total Bet',
                        rightText: '\$${userWallet.totalRiskedAmount}',
                      ),
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Total Won',
                        rightText:
                            '\$${userWallet.totalRiskedAmount + userWallet.totalProfit - userWallet.totalLoss - userWallet.pendingRiskedAmount}',
                      ),
                      // LeaderboardProfileHistoryBoardText(
                      //   leftText: 'Biggest Win',
                      //   rightText: '\$${userWallet.biggestWinAmount}',
                      // ),

                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Ad Rewards',
                        rightText: '\$${userWallet.totalRewards}',
                      ),
                      //  Should replace with biggest win
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Total Profit',
                        rightText: '\$${userWallet.totalProfit}',
                      ),
                      LeaderboardProfileHistoryBoardText(
                        leftText: 'Balance',
                        rightText: '\$${userWallet.accountBalance}',
                        color: Palette.green,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TabletHistoryContent extends StatelessWidget {
  const _TabletHistoryContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((LeaderboardProfileCubit cubit) => cubit.state.status);
    final bets =
        context.select((LeaderboardProfileCubit cubit) => cubit.state.bets);
    switch (status) {
      case LeaderboardProfileStatus.initial:
        return const SizedBox();
      case LeaderboardProfileStatus.loading:
        return const Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(
            color: Palette.cream,
          ),
        );
      case LeaderboardProfileStatus.success:
        if (bets.isEmpty) {
          return const _TabletHistoryEmpty();
        }
        return const _TabletHistoryList();
      case LeaderboardProfileStatus.failure:
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
    final bets =
        context.select((LeaderboardProfileCubit cubit) => cubit.state.bets);
    return GridView.count(
      primary: true,
      childAspectRatio: 2.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      key: Key('${bets.length}'),
      children: bets
          .map(
            (betData) => FittedBox(
              child: LeaderboardProfileHistorySlip(betHistoryData: betData),
              fit: BoxFit.scaleDown,
            ),
          )
          .toList(),
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

class _TabletHistoryHeading extends StatelessWidget {
  const _TabletHistoryHeading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final betHistoryState =
        context.select((LeaderboardProfileCubit cubit) => cubit.state);

    return Center(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Palette.lightGrey,
        ),
        constraints: const BoxConstraints(minWidth: 380, maxWidth: 600),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            betHistoryState.userWallet.avatarUrl != null
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage: CachedNetworkImageProvider(
                        betHistoryState.userWallet.avatarUrl,
                        imageRenderMethodForWeb:
                            ImageRenderMethodForWeb.HttpGet),
                  )
                : CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: Container(
                        alignment: Alignment.center,
                        color: Palette.darkGrey,
                        height: 100.0,
                        width: 100.0,
                        child: Text(
                          betHistoryState.userWallet.username
                              .substring(0, 1)
                              .toUpperCase(),
                          style: GoogleFonts.nunito(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
            betHistoryState.status == LeaderboardProfileStatus.success
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${betHistoryState.userWallet.username}',
                          style: Styles.pageTitle,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
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
