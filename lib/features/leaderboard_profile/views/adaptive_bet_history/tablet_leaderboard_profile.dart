import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../utils/bottom_bar.dart';
import '../../../games/baseball/mlb/widgets/mlb_bet_history_card.dart';
import '../../../games/basketball/nba/widgets/nba_bet_history_card.dart';
import '../../../games/basketball/ncaab/widgets/ncaab_bet_history_card.dart';
import '../../../games/football/ncaaf/widgets/ncaaf_bet_history_card.dart';
import '../../../games/football/nfl/widgets/nfl_bet_history_card.dart';
import '../../../games/hockey/nhl/widgets/nhl_bet_history_card.dart';
import '../../cubit/leaderboard_profile_cubit.dart';
import '../../widgets/leaderboard_profile_board_content.dart';

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
            return const LeaderboardProfileBoardContent();
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
          child: Text("Couldn't load bet history data"),
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
      children: bets.map((betData) {
        switch (betData.league) {
          case 'mlb':
            return FittedBox(
              child: MlbBetHistoryCard(betHistoryData: betData),
              fit: BoxFit.scaleDown,
            );
            break;
          case 'nba':
            return FittedBox(
              child: NbaBetHistoryCard(betHistoryData: betData),
              fit: BoxFit.scaleDown,
            );
            break;
          case 'cbb':
            return FittedBox(
              child: NcaabBetHistoryCard(betHistoryData: betData),
              fit: BoxFit.scaleDown,
            );
            break;
          case 'cfb':
            return FittedBox(
              child: NcaafBetHistoryCard(betHistoryData: betData),
              fit: BoxFit.scaleDown,
            );
            break;
          case 'nfl':
            return FittedBox(
              child: NflBetHistoryCard(betHistoryData: betData),
              fit: BoxFit.scaleDown,
            );
            break;
          case 'nhl':
            return FittedBox(
              child: NhlBetHistoryCard(betHistoryData: betData),
              fit: BoxFit.scaleDown,
            );
            break;
          // case 'olympic':
          //   return FittedBox(
          //     child: OlympicOpenBetCard(openBets:betData),
          //     fit: BoxFit.scaleDown,
          //   );
          //   break;
          default:
            return const SizedBox();
        }
        // return FittedBox(
        //   child: BetHistorySlip(betHistoryData:betDatas),
        //   fit: BoxFit.scaleDown,
        // );
      }).toList(),
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
            Expanded(
              child: betHistoryState.status == LeaderboardProfileStatus.success
                  ? Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${betHistoryState.userWallet.username}',
                        style: Styles.pageTitle,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
