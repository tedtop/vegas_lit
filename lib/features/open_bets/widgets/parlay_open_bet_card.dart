import 'package:flutter/material.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/parlay/parlay_bet.dart';
import 'package:vegas_lit/features/games/baseball/mlb/widgets/mlb_open_bet_card.dart';
import 'package:vegas_lit/features/games/basketball/nba/widgets/nba_open_bet_card.dart';
import 'package:vegas_lit/features/games/basketball/ncaab/widgets/ncaab_open_bet_card.dart';
import 'package:vegas_lit/features/games/football/ncaaf/widgets/ncaaf_open_bet_card.dart';
import 'package:vegas_lit/features/games/football/nfl/widgets/nfl_open_bet_card.dart';
import 'package:vegas_lit/features/games/hockey/nhl/widgets/nhl_open_bet_card.dart';

class ParlayOpenBetCard extends StatelessWidget {
  const ParlayOpenBetCard({Key key, @required this.openBets}) : super(key: key);
  final ParlayBets openBets;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: openBets.bets.length,
          itemBuilder: (BuildContext context, int index) {
            return Align(
              alignment: Alignment.topCenter,
              heightFactor: openBets.bets.length - 1 == index ? 1.0 : 0.80,
              child: Builder(builder: (context) {
                switch (
                    openBets.bets[openBets.bets.length - index - 1].league) {
                  case 'mlb':
                    return MlbOpenBetCard(
                      openBets: openBets.bets[openBets.bets.length - index - 1],
                      isParlayBet: true,
                    );
                    break;
                  case 'nba':
                    return NbaOpenBetCard(
                      openBets: openBets.bets[openBets.bets.length - index - 1],
                      isParlayBet: true,
                    );
                    break;
                  case 'cbb':
                    return NcaabOpenBetCard(
                      openBets: openBets.bets[openBets.bets.length - index - 1],
                      isParlayBet: true,
                    );
                    break;
                  case 'cfb':
                    return NcaafOpenBetCard(
                      openBets: openBets.bets[openBets.bets.length - index - 1],
                      isParlayBet: true,
                    );
                    break;
                  case 'nfl':
                    return NflOpenBetCard(
                      openBets: openBets.bets[openBets.bets.length - index - 1],
                      isParlayBet: true,
                    );
                    break;
                  case 'nhl':
                    return NhlOpenBetCard(
                      openBets: openBets.bets[openBets.bets.length - index - 1],
                      isParlayBet: true,
                    );
                    break;
                  default:
                    return const SizedBox();
                }
              }),
            );
          },
        ),
        Positioned(
          right: 18,
          bottom: 12,
          child: Text(
            '\$${openBets.betProfit}',
            style: Styles.openBetsNormalText,
          ),
        ),
      ],
    );
  }
}
