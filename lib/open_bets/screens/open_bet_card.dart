import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/sportsbook/bloc/sportsbook_bloc.dart';

class OpenBetsSlip extends StatelessWidget {
  const OpenBetsSlip({
    Key key,
    @required this.openBets,
  })  : assert(openBets != null),
        super(key: key);

  final BetData openBets;

  @override
  Widget build(BuildContext context) {
    final estTimeZone =
        context.select((SportsbookBloc bloc) => bloc.state?.estTimeZone);
    final odd = openBets.odds.isNegative
        ? openBets.odds.toString()
        : '+${openBets.odds}';

    bool isMoneyline = true;
    double betSpread = 0.0;
    String spread = '0';

    if (openBets.betOverUnder != null || openBets.betPointSpread != null) {
      isMoneyline = openBets.betType == 'MONEYLINE';
      betSpread = openBets.betType == 'total'
          ? openBets.betOverUnder
          : openBets.betPointSpread;
      spread = betSpread == 0
          ? ''
          : betSpread.isNegative
              ? betSpread.toString()
              : '+$betSpread';
    } else {}

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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        openBets.winTeam == 'home'
                            ? isMoneyline
                                ? Text(
                                    '${openBets.homeTeam} TO WIN',
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      color: Palette.cream,
                                    ),
                                  )
                                : Container()
                            : isMoneyline
                                ? Text(
                                    '${openBets.awayTeam} TO WIN',
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      color: Palette.cream,
                                    ),
                                  )
                                : Container(),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            style: Styles.normalText,
                            children: [
                              TextSpan(
                                text: '${openBets.awayTeam}',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(text: '  @  '),
                              TextSpan(
                                text: '${openBets.homeTeam}',
                                style: GoogleFonts.nunito(
                                  color: Palette.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                            '${whichBetSystem(openBets.betType)}  $spread  $odd',
                            style: GoogleFonts.nunito(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Palette.cream,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Text(
                              // ignore: lines_longer_than_80_chars
                              'You bet \$${openBets.betAmount} to win \$${openBets.betProfit}!',
                              style: GoogleFonts.nunito(
                                color: Palette.green,
                                fontSize: 18,
                              )),
                        ),
                        Row(
                          children: [
                            Text(
                              openBets.gameDateTime,
                              style: Styles.matchupTime,
                            ),
                            // TODO:
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Palette.lightGrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/open_bets_logo.png',
                    ),
                  ),
                  height: 175,
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
    if (betType == 'pointSpread') {
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
