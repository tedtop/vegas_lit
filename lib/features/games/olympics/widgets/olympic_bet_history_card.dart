import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/helpers/olympic_helper.dart';
import 'package:vegas_lit/data/models/olympics/olympic_bet.dart';

class OlympicsBetHistoryCard extends StatelessWidget {
  const OlympicsBetHistoryCard({
    Key key,
    @required this.betHistoryData,
  })  : assert(betHistoryData != null),
        super(key: key);

  final OlympicsBetData betHistoryData;

  @override
  Widget build(BuildContext context) {
    final isWin = betHistoryData.betTeam == betHistoryData.winner;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 2),
      child: Container(
        width: 390,
        height: 180,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '${OlympicHelper.countryFlagFromCode(countryCode: betHistoryData.playerCountry)} ${betHistoryData.playerName}',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: Palette.cream,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${OlympicHelper.countryFlagFromCode(countryCode: betHistoryData.rivalCountry)} ${betHistoryData.rivalName}',
                        style: GoogleFonts.nunito(
                          color: Palette.green,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        betHistoryData.gameName
                            .replaceAll(RegExp('-'), '\/')
                            .toUpperCase(),
                        style: Styles.betHistoryCardNormal
                            .copyWith(color: Palette.green),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        betHistoryData.event,
                        style: Styles.betHistoryCardNormal,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '${OlympicHelper.countryFlagFromCode(countryCode: betHistoryData.betTeam == 'player' ? betHistoryData.playerCountry : betHistoryData.rivalCountry)} TO WIN',
                        style: Styles.betHistoryCardNormal,
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
                                      .format(betHistoryData.gameStartDateTime),
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
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Palette.darkGrey,
                    ),
                    child: OlympicHelper.badgeFromEventType(
                        eventType: betHistoryData.eventType),
                  ),
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
    );
  }
}
