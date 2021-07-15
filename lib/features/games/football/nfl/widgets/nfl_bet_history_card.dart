import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/helpers/bets_data_helper.dart';
import 'package:vegas_lit/data/models/bet.dart';
import 'package:vegas_lit/data/models/nfl/nfl_bet.dart';

class NflBetHistoryCard extends StatelessWidget {
  const NflBetHistoryCard({
    Key key,
    @required this.betHistoryData,
  })  : assert(betHistoryData != null),
        super(key: key);

  final NflBetData betHistoryData;

  @override
  Widget build(BuildContext context) {
    final isWin = betHistoryData.winningTeam == betHistoryData.betTeam;
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
                                      '${betHistoryData.awayTeamName.toUpperCase()}',
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
                                      '${betHistoryData.homeTeamName.toUpperCase()}',
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
                          BetsDataHelper.whichBetTextWidget(betHistoryData),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Max Payout ${betHistoryData.betAmount + betHistoryData.betProfit}',
                            style: Styles.openBetsCardNormal,
                          ),

                          // Last Row
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    DateFormat('E, MMMM, c, y @ hh:mm a')
                                        .format(
                                      DateTime.parse(
                                              betHistoryData.gameStartDateTime)
                                          .toLocal(),
                                    ),
                                    style: Styles.openBetsCardTime,
                                  ),
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
                        decoration: BoxDecoration(
                            color: isWin ? Palette.green : Palette.red),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ticket cost',
                              style: Styles.betHistoryDescription.copyWith(
                                color: Palette.cream,
                              ),
                            ),
                            Text(
                              '${betHistoryData.betAmount}',
                              style: Styles.betHistoryAmount.copyWith(
                                color: Palette.cream,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 61,
                        decoration: const BoxDecoration(color: Palette.cream),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${isWin ? 'you won' : 'you lost'}',
                              style: Styles.betHistoryDescription.copyWith(
                                  color: isWin ? Palette.green : Palette.red),
                            ),
                            Text(
                              isWin
                                  ? '${betHistoryData.betProfit}'
                                  : '${betHistoryData.betAmount}',
                              style: Styles.betHistoryAmount.copyWith(
                                  color: isWin ? Palette.green : Palette.red),
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
          Positioned(
            top: -15,
            left: 15,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Palette.cream,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Palette.darkGrey,
              ),
              height: 25,
              width: 80,
              child: Center(
                child: Text(
                  BetsDataHelper.whichBetSystemFromString(
                      betHistoryData.betType),
                  style: GoogleFonts.nunito(
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
