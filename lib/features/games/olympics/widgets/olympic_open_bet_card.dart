import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/helpers/olympic_helper.dart';
import 'package:vegas_lit/data/models/olympics/olympic_bet.dart';

class OlympicsOpenBetCard extends StatelessWidget {
  const OlympicsOpenBetCard({
    Key key,
    @required this.openBets,
  })  : assert(openBets != null),
        super(key: key);

  final OlympicsBetData openBets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 2),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 390,
            height: 124,
            decoration: BoxDecoration(
              border: Border.all(
                color: Palette.cream,
              ),
              borderRadius: BorderRadius.circular(12),
              color: Palette.cream,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    color: Palette.darkGrey,
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 11,
                        bottom: 3,
                        left: 6,
                        right: 6,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 3,
                          ),
                          RichText(
                            text: TextSpan(
                              style: Styles.openBetsCardNormal,
                              children: [
                                TextSpan(
                                  text:
                                      '${OlympicHelper.countryFlagFromCode(countryCode: openBets.playerCountry)} ${openBets.playerName}',
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: Palette.cream,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '  @  ',
                                  style: GoogleFonts.nunito(
                                    color: Palette.cream,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${OlympicHelper.countryFlagFromCode(countryCode: openBets.rivalCountry)} ${openBets.rivalName}',
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
                            openBets.gameName.toUpperCase(),
                            style: Styles.openBetsCardNormal
                                .copyWith(color: Palette.green),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            openBets.event,
                            style: Styles.openBetsCardNormal,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Max Payout ${openBets.betAmount + openBets.betProfit}',
                            style: Styles.openBetsCardNormal,
                          ),

                          // Last Row
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat('E, MMMM, c, y @ hh:mm a')
                                          .format(openBets.gameStartDateTime),
                                      style: Styles.openBetsCardTime,
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
                ),
                const SizedBox(width: 1),
                Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 90,
                        height: 61,
                        decoration: const BoxDecoration(
                          color: Palette.green,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ticket cost',
                                style: Styles.openBetsCardBetText),
                            Text('${openBets.betAmount}',
                                style: Styles.openBetsCardBetMoney),
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 61,
                        decoration: const BoxDecoration(
                          color: Palette.cream,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'max win',
                              style: Styles.openBetsCardBetText.copyWith(
                                color: Palette.green,
                              ),
                            ),
                            Text(
                              '${openBets.betProfit}',
                              style: Styles.openBetsCardBetMoney
                                  .copyWith(color: Palette.green),
                            ),
                          ],
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
    );
  }
}
