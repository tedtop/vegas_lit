import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

class OpenBetsSlip extends StatelessWidget {
  const OpenBetsSlip({
    Key key,
    @required this.openBets,
  })  : assert(openBets != null),
        super(key: key);

  final OpenBetsData openBets;

  @override
  Widget build(BuildContext context) {
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
                        // TODO: Refactor
                        Text(
                          '${openBets.homeTeam} TO WIN',
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            color: Palette.cream,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
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
                        Text('${openBets.betType}   ${openBets.odd}',
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
                              'You bet \$${openBets.amountBet} to win \$${openBets.amountWin}!',
                              style: GoogleFonts.nunito(
                                color: Palette.green,
                                fontSize: 18,
                              )),
                        ),
                        Row(
                          children: [
                            Text(
                              openBets.dateTime,
                              style: Styles.matchupTime,
                            ),
                            // const SizedBox(
                            //   width: 2,
                            // ),
                            // RichText(
                            //   text: TextSpan(
                            //     style: Styles.small,
                            //     children: [
                            //       TextSpan(
                            //         text: 'Starting in',
                            //         style: Styles.creamColor,
                            //       ),
                            //       TextSpan(
                            //         text: '20hr:17m:18s',
                            //         style: Styles.redColor,
                            //       ),
                            //     ],
                            //   ),
                            // ),
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
}
