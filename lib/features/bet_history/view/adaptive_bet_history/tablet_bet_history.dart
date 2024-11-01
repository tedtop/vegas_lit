import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/mlb/mlb_bet.dart';
import '../../../../data/models/nba/nba_bet.dart';
import '../../../../data/models/ncaab/ncaab_bet.dart';
import '../../../../data/models/ncaaf/ncaaf_bet.dart';
import '../../../../data/models/nfl/nfl_bet.dart';
import '../../../../data/models/nhl/nhl_bet.dart';
import '../../../../utils/bottom_bar.dart';
import '../../../games/baseball/mlb/widgets/mlb_bet_history_card.dart';
import '../../../games/basketball/nba/widgets/nba_bet_history_card.dart';
import '../../../games/basketball/ncaab/widgets/ncaab_bet_history_card.dart';
import '../../../games/football/ncaaf/widgets/ncaaf_bet_history_card.dart';
import '../../../games/football/nfl/widgets/nfl_bet_history_card.dart';
import '../../../games/hockey/nhl/widgets/nhl_bet_history_card.dart';
import '../../cubit/history_cubit.dart';
import '../../widgets/bet_history_board_content.dart';

class TabletBetHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<HistoryCubit>().state;
    return state.status == HistoryStatus.loading
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
              _TabletHistoryHeading(),
              _TabletHistoryBoard(),
              _TabletHistoryContent(),
              BottomBar()
            ],
          );
  }
}

class _TabletHistoryBoard extends StatelessWidget {
  const _TabletHistoryBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final state = context.watch<HistoryCubit>().state;
        switch (state.status) {
          case HistoryStatus.initial:
            return const SizedBox();

          case HistoryStatus.loading:
            return const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                color: Palette.cream,
              ),
            );

          case HistoryStatus.success:
            return const BetHistoryBoardContent();

          case HistoryStatus.failure:
            return const Center(
              child: Text('Some error occured.'),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}

class _TabletHistoryContent extends StatelessWidget {
  const _TabletHistoryContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((HistoryCubit cubit) => cubit.state.status);
    final bets = context.select((HistoryCubit cubit) => cubit.state.bets);
    switch (status) {
      case HistoryStatus.initial:
        return const SizedBox();
      case HistoryStatus.loading:
        return const Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(
            color: Palette.cream,
          ),
        );
      case HistoryStatus.success:
        if (bets.isEmpty) {
          return const _TabletHistoryEmpty();
        }
        return const _TabletHistoryList();
      case HistoryStatus.failure:
        return const Center(
          child: Text("Couldn't load bet history data"),
        );
      default:
        return const SizedBox();
    }
  }
}

class _TabletHistoryList extends StatelessWidget {
  const _TabletHistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bets = context.select((HistoryCubit cubit) => cubit.state.bets);
    return GridView.count(
      primary: true,
      childAspectRatio: 2.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      key: Key('${bets.length}'),
      children: bets.map(
        (betData) {
          if (betData is MlbBetData) {
            return FittedBox(
              fit: BoxFit.scaleDown,
              child: MlbBetHistoryCard(betHistoryData: betData),
            );
          } else if (betData is NbaBetData) {
            return FittedBox(
              fit: BoxFit.scaleDown,
              child: NbaBetHistoryCard(betHistoryData: betData),
            );
          } else if (betData is NcaabBetData) {
            return FittedBox(
              fit: BoxFit.scaleDown,
              child: NcaabBetHistoryCard(betHistoryData: betData),
            );
          } else if (betData is NcaafBetData) {
            return FittedBox(
              fit: BoxFit.scaleDown,
              child: NcaafBetHistoryCard(betHistoryData: betData),
            );
          } else if (betData is NflBetData) {
            return FittedBox(
              fit: BoxFit.scaleDown,
              child: NflBetHistoryCard(betHistoryData: betData),
            );
          } else if (betData is NhlBetData) {
            return FittedBox(
              fit: BoxFit.scaleDown,
              child: NhlBetHistoryCard(betHistoryData: betData),
            );
          } else {
            return const SizedBox();
          }
        },
      ).toList(),
    );
  }
}

class _TabletHistoryEmpty extends StatelessWidget {
  const _TabletHistoryEmpty({Key? key}) : super(key: key);

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
  const _TabletHistoryHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final betHistoryState = context.select((HistoryCubit cubit) => cubit.state);
    return betHistoryState.status == HistoryStatus.success
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'BET HISTORY',
                  style: Styles.pageTitle,
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
