import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
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
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 6),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            width: 390,
            decoration: BoxDecoration(
                color: Palette.lightGrey,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  //bottomRight: Radius.circular(12),
                ),
                border: Border.all(color: Palette.cream)),
            //crossAxisAlignment: CrossAxisAlignment.start,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DisabledDefaultButton(text: 'wager ${openBets.betAmount}'),
                const SizedBox(width: 15),
                SizedBox(
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Win ${openBets.betProfit}',
                          style: Styles.betSlipSmallBoldText,
                        ),
                        Text(
                          'Payout ${openBets.betProfit + openBets.betAmount}',
                          style: Styles.betSlipSmallBoldText
                              .copyWith(color: Palette.green),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    child: Text(
                      '${openBets.bets.length} leg parlay',
                      style: Styles.betSlipBoxNormalText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            reverse: true,
            itemCount: openBets.bets.length,
            itemBuilder: (BuildContext context, int index) {
              return Builder(builder: (context) {
                switch (openBets.bets[index].league) {
                  case 'mlb':
                    return MlbOpenBetCard(
                      openBets: openBets.bets[index],
                      isParlayLeg: true,
                    );
                    break;
                  case 'nba':
                    return NbaOpenBetCard(
                      openBets: openBets.bets[index],
                      isParlayLeg: true,
                    );
                    break;
                  case 'cbb':
                    return NcaabOpenBetCard(
                      openBets: openBets.bets[index],
                      isParlayLeg: true,
                    );
                    break;
                  case 'cfb':
                    return NcaafOpenBetCard(
                      openBets: openBets.bets[index],
                      isParlayLeg: true,
                    );
                    break;
                  case 'nfl':
                    return NflOpenBetCard(
                      openBets: openBets.bets[index],
                      isParlayLeg: true,
                    );
                    break;
                  case 'nhl':
                    return NhlOpenBetCard(
                      openBets: openBets.bets[index],
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

class DisabledDefaultButton extends StatelessWidget {
  const DisabledDefaultButton({
    Key key,
    @required this.text,
    this.color = Palette.darkGrey,
  })  : assert(text != null),
        super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 110,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: TextButton(
          style: ButtonStyle(
              enableFeedback: false,
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: 10,
                ),
              ),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Palette.cream),
              ),
              backgroundColor: MaterialStateProperty.all(color),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Text(
            text,
            style: Styles.betSlipSmallText.copyWith(color: Palette.green),
          ),
          onPressed: null,
        ),
      ),
    );
  }
}
