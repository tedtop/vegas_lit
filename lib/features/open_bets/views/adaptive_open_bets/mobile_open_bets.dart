import 'package:flutter/gestures.dart';
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
import '../../../../data/models/olympics/olympic_bet.dart';
import '../../../../data/models/paralympics/paralympics_bet.dart';
import '../../../../data/models/parlay/parlay_bet.dart';
import '../../../../utils/bottom_bar.dart';
import '../../../games/baseball/mlb/widgets/mlb_open_bet_card.dart';
import '../../../games/basketball/nba/widgets/nba_open_bet_card.dart';
import '../../../games/basketball/ncaab/widgets/ncaab_open_bet_card.dart';
import '../../../games/football/ncaaf/widgets/ncaaf_open_bet_card.dart';
import '../../../games/football/nfl/widgets/nfl_open_bet_card.dart';
import '../../../games/hockey/nhl/widgets/nhl_open_bet_card.dart';
import '../../../games/olympics/widgets/open_bets/olympic_open_bet_card.dart';
import '../../../games/paralympics/widgets/paralympics_open_bet_card.dart';
import '../../../home/home.dart';
import '../../cubit/open_bets_cubit.dart';
import '../../widgets/parlay_open_bet_card.dart';

class MobileOpenBets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _MobileOpenBetsDescription(),
        _MobileOpenBetsContent(),
        BottomBar()
      ],
    );
  }
}

class _MobileOpenBetsDescription extends StatelessWidget {
  const _MobileOpenBetsDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      child: RichText(
        text: TextSpan(
          style: Styles.openBetsNormalText,
          children: <TextSpan>[
            const TextSpan(
              text:
                  // ignore: lines_longer_than_80_chars
                  'Bets shown here cannot be modified and are awaiting the outcome of the event. Once bets have been closed they will appear in your',
            ),
            TextSpan(
                text: ' BET HISTORY ',
                style: Styles.openBetsTextButton,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.read<HomeCubit>().homeChange(4);
                  }),
            const TextSpan(
              text: 'page.',
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileOpenBetsContent extends StatelessWidget {
  const _MobileOpenBetsContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((OpenBetsCubit cubit) => cubit.state.status);
    final bets = context.select((OpenBetsCubit cubit) => cubit.state.bets);
    switch (status) {
      case OpenBetsStatus.success:
        if (bets.isEmpty) {
          return const _MobileOpenBetsContentEmpty();
        }
        return const _MobileOpenBetsContentList();

      case OpenBetsStatus.initial:
        return const SizedBox();

      case OpenBetsStatus.loading:
        return const CircularProgressIndicator(
          color: Palette.cream,
        );

      case OpenBetsStatus.failure:
        return const Center(
          child: Text('Some Error Occured'),
        );

      default:
        return const SizedBox();
    }
  }
}

class _MobileOpenBetsContentList extends StatelessWidget {
  const _MobileOpenBetsContentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bets = context.select((OpenBetsCubit cubit) => cubit.state.bets);
    // final bets = context.select((OpenBetsCubit cubit) => cubit.state.bets);
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      key: Key('${bets.length}'),
      itemCount: bets.length,
      itemBuilder: (context, index) {
        final bet = bets[index];
        if (bet is MlbBetData) {
          return MlbOpenBetCard(openBets: bet);
        } else if (bet is NbaBetData) {
          return NbaOpenBetCard(openBets: bet);
        } else if (bet is NcaabBetData) {
          return NcaabOpenBetCard(openBets: bet);
        } else if (bet is NcaafBetData) {
          return NcaafOpenBetCard(openBets: bet);
        } else if (bet is NflBetData) {
          return NflOpenBetCard(openBets: bet);
        } else if (bet is NhlBetData) {
          return NhlOpenBetCard(openBets: bet);
        } else if (bet is OlympicsBetData) {
          return OlympicsOpenBetCard(openBets: bet);
        } else if (bet is ParalympicsBetData) {
          return ParalympicsOpenBetCard(openBets: bet);
        } else if (bet is ParlayBets) {
          return ParlayOpenBetCard(openBets: bet);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _MobileOpenBetsContentEmpty extends StatelessWidget {
  const _MobileOpenBetsContentEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 120),
      child: Text(
        // ignore: lines_longer_than_80_chars
        'No bets placed. \nPlace some bets to show them here.',
        textAlign: TextAlign.center,
        style: Styles.openBetsEmpty,
      ),
    );
  }
}
