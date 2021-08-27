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
import '../../../games/olympics/widgets/olympic_bet_history_card.dart';
import '../../cubit/leaderboard_profile_cubit.dart';
import '../../widgets/leaderboard_profile_board_content.dart';

class MobileLeaderboardProfile extends StatelessWidget {
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
              const _MobileHistoryHeading(),
              const _MobileHistoryBoard(),
              const _MobileHistoryContent(),
              const BottomBar()
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
            return const LeaderboardProfileBoardContent();
            break;
          case LeaderboardProfileStatus.failure:
            return const Center(
              child: Text("Couldn't load bet history data"),
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

class _MobileHistoryContent extends StatelessWidget {
  const _MobileHistoryContent({Key key}) : super(key: key);

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
          padding: EdgeInsets.only(top: 25),
          child: CircularProgressIndicator(
            color: Palette.cream,
          ),
        );
      case LeaderboardProfileStatus.success:
        if (bets.isEmpty) {
          return const _MobileHistoryEmpty();
        }
        return const _MobileHistoryList();
      case LeaderboardProfileStatus.failure:
        return const Center(
          child: Text("Couldn't load bet history data"),
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
    final bets =
        context.select((LeaderboardProfileCubit cubit) => cubit.state.bets);
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      key: Key('${bets.length}'),
      itemCount: bets.length,
      itemBuilder: (context, index) {
        switch (bets[index].league) {
          case 'mlb':
            return MlbBetHistoryCard(betHistoryData: bets[index]);
            break;
          case 'nba':
            return NbaBetHistoryCard(betHistoryData: bets[index]);
            break;
          case 'cbb':
            return NcaabBetHistoryCard(betHistoryData: bets[index]);
            break;
          case 'cfb':
            return NcaafBetHistoryCard(betHistoryData: bets[index]);
            break;
          case 'nfl':
            return NflBetHistoryCard(betHistoryData: bets[index]);
            break;
          case 'nhl':
            return NhlBetHistoryCard(betHistoryData: bets[index]);
            break;
          case 'olympics':
            return OlympicsBetHistoryCard(betHistoryData: bets[index]);
            break;
          default:
            return const SizedBox();
        }
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
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: betHistoryState.status == LeaderboardProfileStatus.success
                  ? Container(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          '${betHistoryState.userWallet.username}',
                          style: Styles.pageTitle,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
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
