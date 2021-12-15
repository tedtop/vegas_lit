import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

import '../../../../../config/assets.dart';
import '../../../../../config/palette.dart';
import '../../../../../config/styles.dart';
import '../../../../../data/models/nhl/nhl_bet.dart';

class NhlOpenBetCard extends StatelessWidget {
  const NhlOpenBetCard(
      {Key? key, required this.openBets, this.isParlayLeg = false})
      : assert(openBets != null),
        super(key: key);

  final NhlBetData openBets;
  final bool isParlayLeg;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isMoneyline = openBets.betType == 'moneyline';
        final isPointSpread = openBets.betType == 'pointspread';
        final odds = openBets.odds?.isNegative ?? 0.isNegative
            ? openBets.odds.toString()
            : '+${openBets.odds}';
        final isPointSpreadNegative = openBets.betPointSpread == null
            ? true
            : openBets.betPointSpread?.isNegative;
        final pointSpread = openBets.betPointSpread != null
            ? (openBets.betTeam == 'home'
                ? (isPointSpreadNegative!
                    ? '-${openBets.betPointSpread!.abs()}'
                    : '+${openBets.betPointSpread!.abs()}')
                : (isPointSpreadNegative!
                    ? '+${openBets.betPointSpread!.abs()}'
                    : '-${openBets.betPointSpread!.abs()}'))
            : '';

        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: isParlayLeg ? 0 : 2, horizontal: 12),
          child: Card(
            margin: EdgeInsets.zero,
            child: Container(
              width: 390,
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
              decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.srcOver,
                image: DecorationImage(
                  image: AssetImage(
                      '${Images.betGameBGPath}nhl-${isParlayLeg ? 'parlay' : 'single'}.png'),
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
                          ? openBets.betTeam == 'home'
                              ? '${openBets.homeTeamCity ?? ''} ${openBets.homeTeamName}'
                              : '${openBets.awayTeamCity ?? ''} ${openBets.awayTeamName}'
                          : '',
                      style: Styles.betSlipAwayTeam,
                      children: <TextSpan>[
                        if (isMoneyline)
                          TextSpan(
                            text: ' ($odds)',
                          )
                        else
                          isPointSpread
                              ? TextSpan(text: ' ($pointSpread)')
                              : TextSpan(
                                  text:
                                      '${openBets.betTeam == 'away' ? 'OVER' : 'UNDER'} ${openBets.betOverUnder}', //     TOT ${openBets.text.split(' ').last}',
                                  style: Styles.betSlipHomeTeam,
                                ),
                      ],
                    ),
                  ),
                  Text(
                    whichBetSystemFromString(openBets.betType).toUpperCase(),
                    style: Styles.betSlipHomeTeam,
                  ),
                  RichText(
                    text: TextSpan(
                      text: openBets.betTeam == 'home'
                          ? openBets.homeTeamName!.toUpperCase()
                          : openBets.awayTeamName!.toUpperCase(),
                      style: Styles.betSlipHomeTeam,
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              ' @ ${openBets.betTeam == 'away' ? openBets.homeTeamName!.toUpperCase() : openBets.awayTeamName!.toUpperCase()}',
                          style: Styles.betSlipAwayTeam,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (isParlayLeg)
                    const SizedBox()
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DisabledDefaultButton(
                          text: 'wager ${openBets.betAmount}',
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Win ${openBets.betProfit}',
                                  style: Styles.betSlipSmallBoldText,
                                ),
                                Text(
                                  'Payout ${openBets.betProfit! + openBets.betAmount!}',
                                  style: Styles.betSlipSmallBoldText
                                      .copyWith(color: Palette.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
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

String getRemainingTimeText({required CurrentRemainingTime time}) {
  final days = time.days == null ? '' : '${time.days}d ';
  final hours = time.hours == null ? '' : '${time.hours}hr';
  final min = time.min == null ? '' : ' ${time.min}m';
  final sec = time.sec == null ? '' : ' ${time.sec}s';
  return days + hours + min + sec;
}

class DisabledDefaultButton extends StatelessWidget {
  const DisabledDefaultButton({
    Key? key,
    required this.text,
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
          onPressed: null,
          child: Text(
            text,
            style: Styles.betSlipSmallText.copyWith(color: Palette.green),
          ),
        ),
      ),
    );
  }
}
