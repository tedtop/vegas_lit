import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../config/palette.dart';
import '../../../../../config/styles.dart';
import '../../../../../data/models/ncaab/ncaab_bet.dart';

class NcaabOpenBetCard extends StatelessWidget {
  const NcaabOpenBetCard(
      {Key key, @required this.openBets, this.isParlayBet = false})
      : assert(openBets != null),
        super(key: key);

  final NcaabBetData openBets;
  final bool isParlayBet;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isMoneyline = openBets.betType == 'moneyline';
        final isPointSpread = openBets.betType == 'pointspread';
        final odds = openBets?.odds?.isNegative ?? 0.isNegative
            ? openBets.odds.toString()
            : '+${openBets.odds}';
        final isPointSpreadNegative = openBets?.betPointSpread == null
            ? true
            : openBets?.betPointSpread?.isNegative;
        final pointSpread = openBets.betPointSpread != null
            ? (openBets.betTeam == 'home'
                ? (isPointSpreadNegative
                    ? '-${openBets.betPointSpread.abs()}'
                    : '+${openBets.betPointSpread.abs()}')
                : (isPointSpreadNegative
                    ? '+${openBets.betPointSpread.abs()}'
                    : '-${openBets.betPointSpread.abs()}'))
            : '';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          child: Center(
            child: Stack(
              children: [
                Container(
                    width: 390,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Palette.cream,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Palette.lightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(12.5, 12, 12.5, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  text: TextSpan(
                                    text:
                                        '${openBets.betTeam == 'home' ? openBets.homeTeamName.toUpperCase() : openBets.awayTeamName.toUpperCase()}',
                                    style: Styles.betSlipHomeTeam,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            ' @ ${openBets.betTeam == 'away' ? openBets.homeTeamName.toUpperCase() : openBets.awayTeamName.toUpperCase()}\n',
                                        style: Styles.betSlipAwayTeam,
                                      ),
                                      TextSpan(
                                        text: openBets.betTeam == 'home'
                                            ? openBets.homeTeamName
                                                .toUpperCase()
                                            : openBets.awayTeamName
                                                .toUpperCase(),
                                        style: Styles.betSlipHomeTeam,
                                      ),
                                      isMoneyline
                                          ? TextSpan(
                                              text: ' (ML) $odds',
                                              style: Styles.betSlipHomeTeam,
                                            )
                                          : isPointSpread
                                              ? TextSpan(
                                                  text:
                                                      ' $pointSpread (PTS) $odds',
                                                  style: Styles.betSlipHomeTeam,
                                                )
                                              : TextSpan(
                                                  text:
                                                      ' ${openBets.betTeam == 'away' ? 'OVER' : 'UNDER'} ${openBets.betOverUnder} (TOT) $odds',
                                                  style: Styles.betSlipHomeTeam,
                                                ),
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  openBets.league.toUpperCase(),
                                  style: Styles.betSlipButtonText,
                                ),
                              ),
                              isParlayBet
                                  ? const SizedBox(height: 25)
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.only(top: 9),
                                            child: Center(
                                              child: DisabledDefaultButton(
                                                  text: 'BET PLACED'),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Palette.darkGrey,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          height: 35,
                                          width: 80,
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Center(
                                              child: Text(
                                                '${openBets.betAmount}',
                                                style: Styles.greenTextBold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '@ $odds',
                                                style: Styles.betSlipSmallText,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  style:
                                                      Styles.betSlipSmallText,
                                                  text: 'Payout ',
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: openBets.betProfit
                                                          .toString(),
                                                      style: Styles
                                                          .betSlipBoxNormalText
                                                          .copyWith(
                                                        color: Palette.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    )),
                Positioned(
                  top: 0,
                  left: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Palette.cream,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Palette.darkGrey,
                    ),
                    height: 20,
                    width: 90,
                    child: Center(
                      child: Text(
                        (whichBetSystemFromString(openBets.betType)),
                        style: GoogleFonts.nunito(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

String whichBetSystemFromString(String betType) {
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

String getRemainingTimeText({CurrentRemainingTime time}) {
  final days = time.days == null ? '' : '${time.days}d ';
  final hours = time.hours == null ? '' : '${time.hours}hr';
  final min = time.min == null ? '' : ' ${time.min}m';
  final sec = time.sec == null ? '' : ' ${time.sec}s';
  return days + hours + min + sec;
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
            style: Styles.betSlipButtonText,
          ),
          onPressed: null,
        ),
      ),
    );
  }
}
