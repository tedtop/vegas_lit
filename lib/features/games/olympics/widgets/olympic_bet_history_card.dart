

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../config/assets.dart';
import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/olympics/olympic_bet.dart';

class OlympicsBetHistoryCard extends StatelessWidget {
  const OlympicsBetHistoryCard({
    Key? key,
    required this.betHistoryData,
  })  : assert(betHistoryData != null),
        super(key: key);

  final OlympicsBetData betHistoryData;

  @override
  Widget build(BuildContext context) {
    final isWin = betHistoryData.betTeam == betHistoryData.winner;
    final isPlayerWin = betHistoryData.betTeam == 'player' ? true : false;
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
                Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
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
                            const SizedBox(
                              height: 10,
                            ),
                            Image.asset(
                              '${Images.olympicsIconsPath}Olympics.png',
                              height: 20,
                            ),
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
                            Image.asset(
                              '${Images.olympicsIconsPath}${betHistoryData.gameName}.png',
                              height: 40,
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 1),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      
                    ),
                    color: Palette.darkGrey,
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 3,
                        left: 6,
                        right: 6,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  if (isPlayerWin) Text(
                                          countryFlagFromCode(countryCode: betHistoryData.playerCountry!),
                                          style: GoogleFonts.nunito(
                                            fontSize: 20,
                                            color: Palette.cream,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ) else Text(
                                          countryFlagFromCode(countryCode: betHistoryData.rivalCountry!),
                                          style: GoogleFonts.nunito(
                                            fontSize: 20,
                                            color: Palette.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                  if (isPlayerWin) Text(
                                          countryFlagFromCode(countryCode: betHistoryData.rivalCountry!),
                                          style: GoogleFonts.nunito(
                                            fontSize: 20,
                                            color: Palette.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ) else Text(
                                          countryFlagFromCode(countryCode: betHistoryData.playerCountry!),
                                          style: GoogleFonts.nunito(
                                            fontSize: 20,
                                            color: Palette.cream,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: isPlayerWin
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  betHistoryData.playerName!.toUpperCase(),
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 15,
                                                    color: Palette.cream,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                ),
                                              ),
                                              Text(
                                                ' TO WIN',
                                                style: GoogleFonts.nunito(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          SizedBox(
                                            child: Text(
                                              betHistoryData.rivalName!.toUpperCase(),
                                              style: GoogleFonts.nunito(
                                                fontSize: 15,
                                                color: Palette.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  betHistoryData.rivalName!.toUpperCase(),
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 15,
                                                    color: Palette.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                ),
                                              ),
                                              Text(
                                                ' TO WIN',
                                                style: GoogleFonts.nunito(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          SizedBox(
                                            child: Text(
                                              betHistoryData.playerName!.toUpperCase(),
                                              style: GoogleFonts.nunito(
                                                fontSize: 15,
                                                color: Palette.cream,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  betHistoryData.gameName!.replaceAll(RegExp('-'), '/').toUpperCase(),
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: Palette.cream,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: betHistoryData.eventType == 'gold'
                                    ? Text(
                                        '🥇',
                                        style: Styles.emoji(size: 14),
                                      )
                                    : betHistoryData.eventType == 'silver'
                                        ? Text(
                                            '🥈',
                                            style: Styles.emoji(size: 14),
                                          )
                                        : betHistoryData.eventType == 'bronze'
                                            ? Text(
                                                '🥉',
                                                style: Styles.emoji(size: 14),
                                              )
                                            : const SizedBox(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  betHistoryData.event!,
                                  style: Styles.openBetsCardNormal,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          // Last Row
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  DateFormat('E, MMM c, y @ hh:mm a').format(
                                    DateTime.parse(
                                        betHistoryData.gameStartDateTime!),
                                  ),
                                  style: GoogleFonts.nunito(
                                    color: Palette.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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
                              isWin ? 'you won' : 'you lost',
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
            left: 8,
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
                  'MONEYLINE',
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

String countryFlagFromCode({required String countryCode}) {
  return String.fromCharCode(countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6) +
      String.fromCharCode(countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6);
}
