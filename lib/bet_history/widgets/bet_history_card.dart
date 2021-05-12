import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:intl/intl.dart';

class BetHistorySlip extends StatelessWidget {
  const BetHistorySlip({
    Key key,
    @required this.betHistory,
  })  : assert(betHistory != null),
        super(key: key);

  final BetData betHistory;

  @override
  Widget build(BuildContext context) {
    final odd = betHistory.odds.isNegative
        ? betHistory.odds.toString()
        : '+${betHistory.odds}';
    final isMoneyLine = betHistory.betType == 'moneyline';
    final betSpread = betHistory.betType == 'total'
        ? betHistory.betOverUnder
        : betHistory.betPointSpread;
    final spread = betSpread == 0
        ? ''
        : betSpread.isNegative
            ? betSpread.toString()
            : '+$betSpread';

    final isWin =
        betHistory.winningTeamName == betHistory.betTeam ? 'won' : 'lost';
    final betTeam = betHistory.betTeam == 'home'
        ? betHistory.homeTeamName
        : betHistory.awayTeamName;

    final isMoneyline = betHistory.betType == 'MONEYLINE';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Container(
        width: 390,
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.cream,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          color: Palette.darkGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12,
                      bottom: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        betHistory.winningTeamName == 'home'
                            ? isMoneyline
                                ? Text(
                                    '${betHistory.homeTeamName.toUpperCase()} TO WIN',
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      color: Palette.cream,
                                    ),
                                  )
                                : Container()
                            : isMoneyline
                                ? Text(
                                    '${betHistory.awayTeamName.toUpperCase()} TO WIN',
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      color: Palette.cream,
                                    ),
                                  )
                                : Container(),
                        Text(
                          '${betTeam.toUpperCase()} ${isWin.toUpperCase()} ${betHistory.awayTeamScore}-${betHistory.homeTeamScore}',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Palette.cream,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        RichText(
                          text: TextSpan(
                            style: Styles.normalText,
                            children: [
                              TextSpan(
                                text:
                                    '${betHistory.awayTeamName.toUpperCase()}',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(text: '  @  '),
                              TextSpan(
                                text:
                                    '${betHistory.homeTeamName.toUpperCase()}',
                                style: GoogleFonts.nunito(
                                  color: Palette.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          '${whichBetSystem(betHistory.betType)}  ${isMoneyLine ? '' : spread}  $odd',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Palette.cream,
                          ),
                        ),
                        betHistory.winningTeamName == betHistory.betTeam
                            ? Text(
                                // ignore: lines_longer_than_80_chars
                                'You bet \$${betHistory.betAmount} and won \$${betHistory.betProfit}!',
                                style: GoogleFonts.nunito(
                                  color: Palette.green,
                                  fontSize: 14,
                                ),
                              )
                            : Text(
                                // ignore: lines_longer_than_80_chars
                                'You lost \$${betHistory.betAmount}!',
                                style: GoogleFonts.nunito(
                                  color: Palette.red,
                                  fontSize: 14,
                                ),
                              ),
                        Row(
                          children: [
                            Text(
                              DateFormat('E, MMMM, c, y @ hh:mm a').format(
                                DateTime.parse(betHistory.gameDateTime)
                                    .toLocal(),
                              ),
                              style: Styles.matchupTime,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: betHistory.winningTeamName == betHistory.betTeam
                        ? Palette.green
                        : Palette.red,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      Images.betHistoryLogo,
                    ),
                  ),
                  height: 160,
                  width: 90,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String whichBetSystem(String betType) {
    if (betType == 'moneyline') {
      return 'MONEYLINE';
    }
    if (betType == 'pointspread') {
      return 'POINT SPREAD';
    }
    if (betType == 'total') {
      return 'TOTAL O/U';
    } else {
      if (betType == 'MONEYLINE') {
        return 'MONEYLINE';
      }
      if (betType == 'POINT SPREAD') {
        return 'POINT SPREAD';
      }
      if (betType == 'TOTAL SPREAD') {
        return 'TOTAL O/U';
      } else {
        return 'Error';
      }
    }
  }
}
