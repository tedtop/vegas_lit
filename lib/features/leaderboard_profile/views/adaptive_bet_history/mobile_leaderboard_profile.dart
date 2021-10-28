import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/data/models/mlb/mlb_bet.dart';
import 'package:vegas_lit/data/models/nba/nba_bet.dart';
import 'package:vegas_lit/data/models/ncaab/ncaab_bet.dart';
import 'package:vegas_lit/data/models/ncaaf/ncaaf_bet.dart';
import 'package:vegas_lit/data/models/nfl/nfl_bet.dart';
import 'package:vegas_lit/data/models/nhl/nhl_bet.dart';
import 'package:vegas_lit/data/models/olympics/olympic_bet.dart';
import 'package:vegas_lit/data/models/paralympics/paralympics_bet.dart';
import 'package:vegas_lit/data/models/parlay/parlay_bet.dart';
import 'package:vegas_lit/features/bet_history/widgets/parlay_bet_history_card.dart';
import 'package:vegas_lit/features/games/paralympics/widgets/paralympics_bet_history_card.dart';

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
    final state =
        context.watch<LeaderboardProfileCubit>().state;
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
            children: const [
              _MobileHistoryHeading(),
              _MobileHistoryBoard(),
              _MobileHistoryContent(),
              BottomBar()
            ],
          );
  }
}

class _MobileHistoryBoard extends StatelessWidget {
  const _MobileHistoryBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final state =
            context.watch<LeaderboardProfileCubit>().state;
        switch (state.status) {
          case LeaderboardProfileStatus.initial:
            return const SizedBox();

          case LeaderboardProfileStatus.loading:
            return const CircularProgressIndicator(
              color: Palette.cream,
            );

          case LeaderboardProfileStatus.success:
            return const LeaderboardProfileBoardContent();

          case LeaderboardProfileStatus.failure:
            return const Center(
              child: Text("Couldn't load bet history data"),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}

class _MobileHistoryContent extends StatelessWidget {
  const _MobileHistoryContent({Key? key}) : super(key: key);

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
  const _MobileHistoryList({Key? key}) : super(key: key);

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
        final betData = bets[index];
        if (betData is MlbBetData) {
          return MlbBetHistoryCard(betHistoryData: betData);
        } else if (betData is NbaBetData) {
          return NbaBetHistoryCard(betHistoryData: betData);
        } else if (betData is NcaabBetData) {
          return NcaabBetHistoryCard(betHistoryData: betData);
        } else if (betData is NcaafBetData) {
          return NcaafBetHistoryCard(betHistoryData: betData);
        } else if (betData is NflBetData) {
          return NflBetHistoryCard(betHistoryData: betData);
        } else if (betData is NhlBetData) {
          return NhlBetHistoryCard(betHistoryData: betData);
        } else if (betData is OlympicsBetData) {
          return OlympicsBetHistoryCard(betHistoryData: betData);
        } else if (betData is ParalympicsBetData) {
          return ParalympicsBetHistoryCard(betHistoryData: betData);
        } else if (betData is ParlayBets) {
          return ParlayBetHistoryCard(betHistoryData: betData);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _MobileHistoryEmpty extends StatelessWidget {
  const _MobileHistoryEmpty({Key? key}) : super(key: key);

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
  const _MobileHistoryHeading({Key? key}) : super(key: key);

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
            if (betHistoryState.userWallet!.avatarUrl != null) CircleAvatar(
                    radius: 50,
                    backgroundImage: CachedNetworkImageProvider(
                      betHistoryState.userWallet!.avatarUrl!,
                    ), //Image for web configuration.
                  ) else CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: Container(
                        alignment: Alignment.center,
                        color: Palette.darkGrey,
                        height: 100.0,
                        width: 100.0,
                        child: Text(
                          betHistoryState.userWallet!.username!
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
                      padding: const EdgeInsets.all(8),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          '${betHistoryState.userWallet!.username}',
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
