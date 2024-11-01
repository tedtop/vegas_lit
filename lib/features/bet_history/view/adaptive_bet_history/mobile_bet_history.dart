import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/mlb/mlb_bet.dart';
import '../../../../data/models/nba/nba_bet.dart';
import '../../../../data/models/ncaab/ncaab_bet.dart';
import '../../../../data/models/ncaaf/ncaaf_bet.dart';
import '../../../../data/models/nfl/nfl_bet.dart';
import '../../../../data/models/nhl/nhl_bet.dart';
import '../../../../data/models/olympics/olympic_bet.dart';
import '../../../../data/models/paralympics/paralympics_bet.dart';
import '../../../../data/models/parlay/parlay_bet.dart';
import '../../../../utils/bottom_bar.dart';
import '../../../games/baseball/mlb/widgets/mlb_bet_history_card.dart';
import '../../../games/basketball/nba/widgets/nba_bet_history_card.dart';
import '../../../games/basketball/ncaab/widgets/ncaab_bet_history_card.dart';
import '../../../games/football/ncaaf/widgets/ncaaf_bet_history_card.dart';
import '../../../games/football/nfl/widgets/nfl_bet_history_card.dart';
import '../../../games/hockey/nhl/widgets/nhl_bet_history_card.dart';
import '../../../games/olympics/widgets/olympic_bet_history_card.dart';
import '../../../games/paralympics/widgets/paralympics_bet_history_card.dart';
import '../../cubit/history_cubit.dart';
import '../../widgets/bet_history_board_content.dart';
import '../../widgets/parlay_bet_history_card.dart';

class MobileBetHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<HistoryCubit>().state;

    switch (state.status) {
      case HistoryStatus.loading:
        return const Padding(
          padding: EdgeInsets.only(top: 160),
          child: Center(
            child: CircularProgressIndicator(
              color: Palette.cream,
            ),
          ),
        );

      case HistoryStatus.failure:
        return Column(
          children: [
            const _MobileHistoryDropdown(),
            Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Center(
                child: Text(
                  "Couldn't load bet history data",
                  style: GoogleFonts.nunito(),
                ),
              ),
            ),
            const BottomBar()
          ],
        );

      case HistoryStatus.empty:
        return Column(
          children: [
            const _MobileHistoryDropdown(),
            Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Center(
                child: Text(
                  'No Records Found',
                  style: GoogleFonts.nunito(),
                ),
              ),
            ),
            const BottomBar()
          ],
        );
      default:
        return Column(
          children: const [
            _MobileHistoryDropdown(),
            _MobileHistoryBoard(),
            _MobileHistoryContent(),
            BottomBar()
          ],
        );
    }
  }
}

class _MobileHistoryBoard extends StatelessWidget {
  const _MobileHistoryBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final state = context.watch<HistoryCubit>().state;
        switch (state.status) {
          case HistoryStatus.initial:
            return const SizedBox();

          case HistoryStatus.loading:
            return const Center(
              child: CircularProgressIndicator(
                color: Palette.cream,
              ),
            );

          case HistoryStatus.success:
            return const BetHistoryBoardContent();

          case HistoryStatus.failure:
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Couldn't load bet history data",
                  style: GoogleFonts.nunito(),
                ),
              ),
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
    final status = context.select((HistoryCubit cubit) => cubit.state.status);
    final bets = context.select((HistoryCubit cubit) => cubit.state.bets);
    switch (status) {
      case HistoryStatus.initial:
        return const SizedBox();
      case HistoryStatus.loading:
        return const Padding(
          padding: EdgeInsets.only(top: 25),
          child: CircularProgressIndicator(
            color: Palette.cream,
          ),
        );
      case HistoryStatus.success:
        if (bets.isEmpty) {
          return const _MobileHistoryEmpty();
        }
        return const _MobileHistoryList();
      case HistoryStatus.failure:
        return Center(
          child: Text(
            "Couldn't load bet history data",
            style: GoogleFonts.nunito(),
          ),
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
    final bets = context.select((HistoryCubit cubit) => cubit.state.bets);
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      key: Key('${bets.length}'),
      itemCount: bets.length,
      // ignore: missing_return
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

class _MobileHistoryDropdown extends StatelessWidget {
  const _MobileHistoryDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weeks = context.select((HistoryCubit cubit) => cubit.state.weeks);
    final week = context.select((HistoryCubit cubit) => cubit.state.week);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      height: 40,
      width: 220,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Container(
          color: Palette.green,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          width: double.infinity,
          child: Center(
            child: DropdownButton<String>(
              dropdownColor: Palette.green,
              isDense: true,
              value: week,
              icon: const Icon(
                FontAwesome.angle_down,
                color: Palette.cream,
              ),
              isExpanded: true,
              underline: Container(
                height: 0,
              ),
              style: GoogleFonts.nunito(
                fontSize: 18,
              ),
              onChanged: (week) =>
                  context.read<HistoryCubit>().changeWeek(week: week),
              items: weeks.isNotEmpty == true
                  ? weeks.map<DropdownMenuItem<String>>(
                      (String weekValue) {
                        String weekFormat;
                        if (weekValue != 'Current Week') {
                          final formatValue = weekValue.split('-');

                          weekFormat =
                              'Week ${formatValue[1]}, ${formatValue[0]}';
                        } else {
                          weekFormat = weekValue;
                        }
                        return DropdownMenuItem<String>(
                          value: weekValue,
                          child: Text(
                            weekFormat.toString(),
                            textAlign: TextAlign.left,
                            style: Styles.leaderboardDropdown,
                          ),
                        );
                      },
                    ).toList()
                  : const [],
            ),
          ),
        ),
      ),
    );
  }
}
