import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

class BetHistorySlip extends StatelessWidget {
  const BetHistorySlip({
    Key key,
    @required this.betHistory,
  })  : assert(betHistory != null),
        super(key: key);

  final BetHistoryData betHistory;

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
                        Text(
                          '${betHistory.homeTeam} TO WIN',
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            color: Palette.cream,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: Styles.normalText,
                            children: [
                              TextSpan(
                                text: '${betHistory.awayTeam}',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(text: '  @  '),
                              TextSpan(
                                text: '${betHistory.homeTeam}',
                                style: GoogleFonts.nunito(
                                  color: Palette.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${betHistory.betType}   ${betHistory.odd}',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Palette.cream,
                          ),
                        ),
                        Text(
                          // ignore: lines_longer_than_80_chars
                          'You bet \$${betHistory.amountBet} and won \$${betHistory.amountWin}!',
                          style: GoogleFonts.nunito(
                            color: Palette.green,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              betHistory.dateTime,
                              style: Styles.matchupTime,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Palette.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      Images.betHistoryLogo,
                    ),
                  ),
                  height: 150,
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
