import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vegas_lit/config/assets.dart';

import '../../../../../config/palette.dart';
import '../../../../../config/styles.dart';
import '../../../../../data/models/mlb/mlb_bet.dart';

class MlbBetHistoryCard extends StatelessWidget {
  const MlbBetHistoryCard(
      {Key? key, required this.betHistoryData, this.isParlayLeg = false})
      : assert(betHistoryData != null),
        super(key: key);

  final MlbBetData betHistoryData;
  final bool isParlayLeg;
  @override
  Widget build(BuildContext context) {
    final isWin = betHistoryData.winningTeam == betHistoryData.betTeam;
    final isMoneyline = betHistoryData.betType == 'moneyline';
    final isPointSpread = betHistoryData.betType == 'pointspread';
    final odds = betHistoryData.odds?.isNegative ?? 0.isNegative
        ? betHistoryData.odds.toString()
        : '+${betHistoryData.odds}';
    final isPointSpreadNegative = betHistoryData.betPointSpread == null
        ? true
        : betHistoryData.betPointSpread?.isNegative;
    final pointSpread = betHistoryData.betPointSpread != null
        ? (betHistoryData.betTeam == 'home'
            ? (isPointSpreadNegative!
                ? '-${betHistoryData.betPointSpread!.abs()}'
                : '+${betHistoryData.betPointSpread!.abs()}')
            : (isPointSpreadNegative!
                ? '+${betHistoryData.betPointSpread!.abs()}'
                : '-${betHistoryData.betPointSpread!.abs()}'))
        : '';
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: isParlayLeg ? 0 : 2, horizontal: 12),
      child: Card(
        margin: EdgeInsets.zero,
        child: Container(
          width: 390,
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.srcOver,
            image: DecorationImage(
              image: AssetImage(
                  '${Images.betGameBGPath}mlb-${isParlayLeg ? 'parlay' : 'single'}.png'),
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerRight,
            ),
            color: Palette.lightGrey,
            border: Border.all(
              color: Palette.cream,
            ),
            borderRadius: isParlayLeg
                ? BorderRadius.zero
                : const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: isMoneyline || isPointSpread
                      ? '${betHistoryData.betTeam == 'home' ? '${betHistoryData.homeTeamCity ?? ''} ${betHistoryData.homeTeamName}' : '${betHistoryData.awayTeamCity ?? ''} ${betHistoryData.awayTeamName}'}'
                      : '',
                  style: Styles.betSlipAwayTeam,
                  children: <TextSpan>[
                    isMoneyline
                        ? TextSpan(
                            text: ' ($odds)',
                          )
                        : isPointSpread
                            ? TextSpan(text: ' ($pointSpread)')
                            : TextSpan(
                                text:
                                    '${betHistoryData.betTeam == 'away' ? 'OVER' : 'UNDER'} ${betHistoryData.betOverUnder}', //     TOT ${betHistoryData.text.split(' ').last}',
                                style: Styles.betSlipHomeTeam,
                              ),
                  ],
                ),
              ),
              Text(
                whichBetSystemFromString(betHistoryData.betType).toUpperCase(),
                style: isWin
                    ? Styles.betSlipHomeTeam
                    : Styles.betHistoryCardBoldRed,
              ),
              RichText(
                text: TextSpan(
                  text:
                      '${betHistoryData.betTeam == 'home' ? '${betHistoryData.homeTeamName!.toUpperCase()} ${betHistoryData.homeTeamScore ?? ''}' : '${betHistoryData.awayTeamName!.toUpperCase()} ${betHistoryData.awayTeamScore ?? ''}'}',
                  style: Styles.betSlipHomeTeam,
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          ' @ ${betHistoryData.betTeam == 'away' ? '${betHistoryData.homeTeamName!.toUpperCase()} ${betHistoryData.homeTeamScore ?? ''}' : '${betHistoryData.awayTeamName!.toUpperCase()} ${betHistoryData.awayTeamScore ?? ''}'}',
                      style: Styles.betSlipAwayTeam,
                    ),
                  ],
                ),
              ),
              isParlayLeg
                  ? const SizedBox()
                  : isWin
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            'YOU WON ${betHistoryData.betProfit} with a PAYOUT of ${betHistoryData.betProfit! + betHistoryData.betAmount!}',
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
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

String whichBetSystemFromString(String? betType) {
  if (betType == 'moneyline') {
    return 'MONEYLINE';
  }
  if (betType == 'pointspread') {
    return 'POINT SPREAD';
  }
  if (betType == 'total') {
    return 'TOTAL O/U';
  }
  if (betType == 'olympics') {
    return 'OLYMPICS';
  } else {
    return 'ERROR';
  }
}
