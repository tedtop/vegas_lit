import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../config/palette.dart';
import '../../../../../config/styles.dart';
import '../../../../../data/models/ncaab/ncaab_bet.dart';

class NcaabBetHistoryCard extends StatelessWidget {
  const NcaabBetHistoryCard({
    Key key,
    @required this.betHistoryData,
  })  : assert(betHistoryData != null),
        super(key: key);

  final NcaabBetData betHistoryData;

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
                          whichBetTextWidget(betHistoryData),
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
                  whichBetSystemFromString(betHistoryData.betType),
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

Widget whichBetTextWidget(dynamic betData) {
  final odds = betData?.odds?.isNegative ?? 0.isNegative
      ? betData.odds.toString()
      : '+${betData.odds}';
  final isPointSpreadNegative =
      betData?.betPointSpread?.isNegative ?? 0.isNegative;
  final overUnder = betData.betTeam == 'away'
      ? '+${betData.betOverUnder}'
      : '-${betData.betOverUnder}';
  final awayTeamPointSpread = isPointSpreadNegative
      ? betData?.betPointSpread?.abs() ?? 0
      : betData?.betPointSpread != null
          ? -betData?.betPointSpread?.abs()
          : 0;
  final homeTeamPointSpread = isPointSpreadNegative
      ? betData?.betPointSpread != null
          ? -betData?.betPointSpread?.abs()
          : 0
      : betData?.betPointSpread?.abs() ?? 0;
  switch (betData.betType) {
    case 'moneyline':
      return Column(
        children: [
          RichText(
            text: TextSpan(
              style: Styles.openBetsCardNormal,
              children: [
                betData.betTeam == 'away'
                    ? TextSpan(
                        text: '${betData.awayTeamName.toUpperCase()} ',
                        style: Styles.openBetsCardNormal,
                      )
                    : TextSpan(
                        text: '${betData.homeTeamName.toUpperCase()} ',
                        style: Styles.openBetsCardNormal
                            .copyWith(color: Palette.green),
                      ),
                const TextSpan(text: 'TO WIN'),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '(ML) ${whichBetSystemFromString(betData.betType)}  ($odds)',
            style: Styles.openBetsCardNormal,
          ),
        ],
      );
      break;
    case 'pointspread':
      if (betData.betTeam == 'away') {
        return Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${betData.awayTeamName.toUpperCase()} ',
                    style: Styles.openBetsCardNormal,
                  ),
                  awayTeamPointSpread.isNegative
                      ? TextSpan(
                          text: '(-${awayTeamPointSpread.abs()})',
                          style: Styles.openBetsCardNormal,
                        )
                      : TextSpan(
                          text: '(+${awayTeamPointSpread.abs()})',
                          style: Styles.openBetsCardNormal,
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '(PTS) POINT SPREAD ($odds)',
              style: Styles.openBetsCardNormal,
            )
          ],
        );
      } else {
        return Column(
          children: [
            RichText(
              text: TextSpan(
                style: Styles.openBetsCardNormal,
                children: [
                  TextSpan(
                    text: '${betData.homeTeamName.toUpperCase()} ',
                    style: Styles.openBetsCardNormal.copyWith(
                      color: Palette.green,
                    ),
                  ),
                  homeTeamPointSpread.isNegative
                      ? TextSpan(
                          text: '(-${homeTeamPointSpread.abs()})',
                          style: Styles.openBetsCardNormal,
                        )
                      : TextSpan(
                          text: '(+${homeTeamPointSpread.abs()})',
                          style: Styles.openBetsCardNormal,
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '(PTS) POINT SPREAD ($odds)',
              style: Styles.openBetsCardNormal,
            )
          ],
        );
      }
      break;
    case 'total':
      if (betData.betTeam == 'away') {
        return Column(
          children: [
            Text(
              '${betData.awayTeamName.toUpperCase()} OVER ($overUnder)',
              style: Styles.openBetsCardNormal,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '(TOT) TOTAL O/U ($odds)',
              style: Styles.openBetsCardNormal,
            )
          ],
        );
      } else {
        return Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${betData.homeTeamName.toUpperCase()}',
                    style: Styles.openBetsCardNormal.copyWith(
                      color: Palette.green,
                    ),
                  ),
                  TextSpan(
                    text: ' UNDER ($overUnder)',
                    style: Styles.openBetsCardNormal,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '(TOT) TOTAL O/U ($odds)',
              style: Styles.openBetsCardNormal,
            )
          ],
        );
      }
      break;
    default:
      return Center(
        child: Text(
          'NO DATA FOUND',
          style: Styles.openBetsCardNormal,
        ),
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
