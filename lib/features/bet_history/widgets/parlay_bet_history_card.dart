import 'package:flutter/material.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/parlay/parlay_bet.dart';
import 'package:vegas_lit/features/games/baseball/mlb/widgets/mlb_bet_history_card.dart';
import 'package:vegas_lit/features/games/basketball/nba/widgets/nba_bet_history_card.dart';
import 'package:vegas_lit/features/games/basketball/ncaab/widgets/ncaab_bet_history_card.dart';
import 'package:vegas_lit/features/games/football/ncaaf/widgets/ncaaf_bet_history_card.dart';
import 'package:vegas_lit/features/games/football/nfl/widgets/nfl_bet_history_card.dart';
import 'package:vegas_lit/features/games/hockey/nhl/widgets/nhl_bet_history_card.dart';

class ParlayBetHistoryCard extends StatelessWidget {
  const ParlayBetHistoryCard({Key key, @required this.betHistoryData})
      : super(key: key);

  final ParlayBets betHistoryData;

  @override
  Widget build(BuildContext context) {
    bool isWin;
    for (final dynamic bet in betHistoryData.bets) {
      if (isWin == null)
        isWin = (bet.winningTeam == bet.betTeam);
      else
        isWin = isWin && (bet.winningTeam == bet.betTeam);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: betHistoryData.bets.length,
      itemBuilder: (BuildContext context, int index) {
        return Align(
          alignment: Alignment.topCenter,
          heightFactor: index == betHistoryData.bets.length - 1 ? 1.0 : 0.80,
          child: Builder(
            builder: (context) {
              Widget betCard;
              switch (betHistoryData
                  .bets[betHistoryData.bets.length - index - 1].league) {
                case 'mlb':
                  betCard = MlbBetHistoryCard(
                    betHistoryData: betHistoryData
                        .bets[betHistoryData.bets.length - index - 1],
                    isParlayBet: true,
                  );
                  break;
                case 'nba':
                  betCard = NbaBetHistoryCard(
                    betHistoryData: betHistoryData
                        .bets[betHistoryData.bets.length - index - 1],
                    isParlayBet: true,
                  );
                  break;
                case 'cbb':
                  betCard = NcaabBetHistoryCard(
                    betHistoryData: betHistoryData
                        .bets[betHistoryData.bets.length - index - 1],
                    isParlayBet: true,
                  );
                  break;
                case 'cfb':
                  betCard = NcaafBetHistoryCard(
                    betHistoryData: betHistoryData
                        .bets[betHistoryData.bets.length - index - 1],
                    isParlayBet: true,
                  );
                  break;
                case 'nfl':
                  betCard = NflBetHistoryCard(
                    betHistoryData: betHistoryData
                        .bets[betHistoryData.bets.length - index - 1],
                    isParlayBet: true,
                  );
                  break;
                case 'nhl':
                  betCard = NhlBetHistoryCard(
                    betHistoryData: betHistoryData
                        .bets[betHistoryData.bets.length - index - 1],
                    isParlayBet: true,
                  );
                  break;
                default:
                  betCard = const SizedBox();
              }
              // if (index == betHistoryData.bets.length - 1) {
              //   betCard = Stack(
              //     children: [
              //       ConstrainedBox(
              //         constraints: const BoxConstraints(maxWidth: 410),
              //         child: betCard,
              //       ),
              //       Positioned(
              //         right: 15,
              //         bottom: 12,
              //         child: Text(
              //           isWin ? '\$${betHistoryData.betProfit}' : 'LOST',
              //           style: Styles.betHistoryNormal,
              //         ),
              //       ),
              //     ],
              //   );
              // }
              return betCard;
            },
          ),
        );
      },
    );
  }
}
