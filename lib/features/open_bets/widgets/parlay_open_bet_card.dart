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
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: openBets.bets.length,
      itemBuilder: (BuildContext context, int index) {
        return Align(
          alignment: Alignment.topCenter,
          heightFactor: index == openBets.bets.length - 1 ? 1.0 : 0.80,
          child: Builder(builder: (context) {
            Widget betCard;
            switch (openBets.bets[openBets.bets.length - index - 1].league) {
              case 'mlb':
                betCard = MlbOpenBetCard(
                  openBets: openBets.bets[openBets.bets.length - index - 1],
                  isParlayBet: true,
                );
                break;
              case 'nba':
                betCard = NbaOpenBetCard(
                  openBets: openBets.bets[openBets.bets.length - index - 1],
                  isParlayBet: true,
                );
                break;
              case 'cbb':
                betCard = NcaabOpenBetCard(
                  openBets: openBets.bets[openBets.bets.length - index - 1],
                  isParlayBet: true,
                );
                break;
              case 'cfb':
                betCard = NcaafOpenBetCard(
                  openBets: openBets.bets[openBets.bets.length - index - 1],
                  isParlayBet: true,
                );
                break;
              case 'nfl':
                betCard = NflOpenBetCard(
                  openBets: openBets.bets[openBets.bets.length - index - 1],
                  isParlayBet: true,
                );
                break;
              case 'nhl':
                betCard = NhlOpenBetCard(
                  openBets: openBets.bets[openBets.bets.length - index - 1],
                  isParlayBet: true,
                );
                break;
              default:
                betCard = const SizedBox();
            }
            if (index == openBets.bets.length - 1) {
              betCard = Stack(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 410),
                    child: betCard,
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
            return betCard;
          }),
        );
      },
    );
  }
}
