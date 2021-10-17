import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
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

    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 6),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
            width: 390,
            decoration: BoxDecoration(
                color: Palette.lightGrey,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                ),
                border: Border.all(color: Palette.cream)),
            child: Column(
              children: [
                Text(
                  '${betHistoryData.bets.length} leg parlay',
                  style: Styles.betHistoryNormal,
                ),
                isWin
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          'YOU WON ${betHistoryData.betProfit} with a PAYOUT of ${betHistoryData.betProfit + betHistoryData.betAmount}',
                          style: Styles.betHistoryCardBoldGreen,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          'YOU LOST ${betHistoryData.betAmount}',
                          style: Styles.betHistoryCardBoldRed,
                        ),
                      ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            reverse: true,
            itemCount: betHistoryData.bets.length,
            itemBuilder: (BuildContext context, int index) {
              return Builder(builder: (context) {
                switch (betHistoryData
                    .bets[betHistoryData.bets.length - index - 1].league) {
                  case 'mlb':
                    return MlbBetHistoryCard(
                      betHistoryData: betHistoryData
                          .bets[betHistoryData.bets.length - index - 1],
                      isParlayLeg: true,
                    );
                    break;
                  case 'nba':
                    return NbaBetHistoryCard(
                      betHistoryData: betHistoryData
                          .bets[betHistoryData.bets.length - index - 1],
                      isParlayLeg: true,
                    );
                    break;
                  case 'cbb':
                    return NcaabBetHistoryCard(
                      betHistoryData: betHistoryData
                          .bets[betHistoryData.bets.length - index - 1],
                      isParlayLeg: true,
                    );
                    break;
                  case 'cfb':
                    return NcaafBetHistoryCard(
                      betHistoryData: betHistoryData
                          .bets[betHistoryData.bets.length - index - 1],
                      isParlayLeg: true,
                    );
                    break;
                  case 'nfl':
                    return NflBetHistoryCard(
                      betHistoryData: betHistoryData
                          .bets[betHistoryData.bets.length - index - 1],
                      isParlayLeg: true,
                    );
                    break;
                  case 'nhl':
                    return NhlBetHistoryCard(
                      betHistoryData: betHistoryData
                          .bets[betHistoryData.bets.length - index - 1],
                      isParlayLeg: true,
                    );
                    break;
                  default:
                    return const SizedBox();
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
