import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../../data/models/bet.dart';

class BetHistorySlip extends StatelessWidget {
  const BetHistorySlip({
    Key key,
    @required this.betHistoryData,
  })  : assert(betHistoryData != null),
        super(key: key);

  final BetData betHistoryData;

  @override
  Widget build(BuildContext context) {
    final isWin = betHistoryData.winningTeam == betHistoryData.betTeam;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          width: 390,
          height: 108,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9.0,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.normal,
                                color: Palette.cream,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '${betHistoryData.awayTeamName.toUpperCase()}',
                                ),
                                const TextSpan(text: '  @  '),
                                TextSpan(
                                  text:
                                      '${betHistoryData.homeTeamName.toUpperCase()}',
                                  style:
                                      GoogleFonts.nunito(color: Palette.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                        whichBetText(betData: betHistoryData),
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  DateFormat('E, MMMM, c, y @ hh:mm a').format(
                                    DateTime.parse(
                                            betHistoryData.gameStartDateTime)
                                        .toLocal(),
                                  ),
                                  style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    color: isWin ? Palette.green : Palette.red,
                                  ),
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
                      height: 53,
                      decoration: const BoxDecoration(
                        color: Palette.cream,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'you bet',
                            style: Styles.betHistoryDescription.copyWith(
                              color: isWin ? Palette.green : Palette.red,
                            ),
                          ),
                          Text(
                            '\$${betHistoryData.betAmount}',
                            style: Styles.betHistoryAmount.copyWith(
                              color: isWin ? Palette.green : Palette.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 53,
                      decoration: BoxDecoration(
                        color: isWin ? Palette.green : Palette.red,
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${isWin ? 'and won' : 'you lost'}',
                            style: Styles.betHistoryDescription,
                          ),
                          Text(
                              isWin
                                  ? '\$${betHistoryData.betProfit}'
                                  : '\$${betHistoryData.betAmount}',
                              style: Styles.betHistoryAmount),
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
                betTypeString(betHistoryData.betType),
                style: GoogleFonts.nunito(
                  fontSize: 10,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget whichBetText({@required BetData betData}) {
    final odds =
        betData.odds.isNegative ? betData.odds.toString() : '+${betData.odds}';

    final isWin = betData.winningTeam == betData.betTeam;
    final betTeam =
        betData.betTeam == 'home' ? betData.homeTeamName : betData.awayTeamName;

    final isPointSpreadNegative =
        betData?.betPointSpread?.isNegative ?? 0.isNegative;

    final overUnder = betData.betTeam == 'away'
        ? '+${betData.betOverUnder}'
        : '-${betData.betOverUnder}';

    final awayTeamPointSpread = isPointSpreadNegative
        ? '+${betData?.betPointSpread?.abs() ?? 0}'
        : '-${betData?.betPointSpread?.abs() ?? 0}';
    final homeTeamPointSpread = isPointSpreadNegative
        ? '-${betData?.betPointSpread?.abs() ?? 0}'
        : '+${betData?.betPointSpread?.abs() ?? 0}';

    switch (betData.betType) {
      case 'moneyline':
        return Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                  text: TextSpan(
                    style: Styles.betHistoryCardNormal,
                    children: [
                      betData.betTeam == 'away'
                          ? TextSpan(
                              text: '${betTeam.toUpperCase()} ',
                              style: Styles.betHistoryTeamAway,
                            )
                          : TextSpan(
                              text: '${betTeam.toUpperCase()} ',
                              style: Styles.betHistoryTeamNotAway,
                            ),
                      TextSpan(text: isWin ? 'WON' : 'LOST'),
                      TextSpan(
                          text:
                              ' ${betData.awayTeamScore}-${betData.homeTeamScore}'),
                    ],
                  ),
                ),
                Text(
                  '${betTypeString(betData.betType)}  ($odds)',
                  style: Styles.betHistoryCardNormal,
                ),
              ],
            ),
          ),
        );
        break;
      case 'pointspread':
        return Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                  text: TextSpan(
                    style: Styles.betHistoryCardNormal,
                    children: [
                      betData.betTeam == 'away'
                          ? TextSpan(
                              text: '${betTeam.toUpperCase()} ',
                              style: Styles.betHistoryTeamAway,
                            )
                          : TextSpan(
                              text: '${betTeam.toUpperCase()} ',
                              style: Styles.betHistoryTeamNotAway,
                            ),
                      TextSpan(
                        text:
                            '${isWin ? 'WON' : 'LOST'} ${betData.awayTeamScore}-${betData.homeTeamScore}',
                      ),
                    ],
                  ),
                ),
                betData.betTeam == 'away'
                    ? Text(
                        isWin
                            ? 'AUTOMATIC WIN $awayTeamPointSpread ($odds)'
                            : 'AUTOMATIC LOSS $awayTeamPointSpread ($odds)',
                        style: Styles.betHistoryCardNormal,
                      )
                    : Text(
                        isWin
                            ? 'AUTOMATIC WIN $homeTeamPointSpread ($odds)'
                            : 'AUTOMATIC LOSS $homeTeamPointSpread ($odds)',
                        style: Styles.betHistoryCardNormal,
                      ),
              ],
            ),
          ),
        );

        break;
      case 'total':
        return Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                  text: TextSpan(
                    style: Styles.betHistoryCardNormal,
                    children: [
                      betData.betTeam == 'away'
                          ? TextSpan(
                              text: '${betTeam.toUpperCase()} ',
                              style: Styles.betHistoryTeamAway,
                            )
                          : TextSpan(
                              text: '${betTeam.toUpperCase()} ',
                              style: Styles.betHistoryTeamNotAway,
                            ),
                      TextSpan(text: isWin ? 'WON' : 'LOST'),
                      TextSpan(
                          text:
                              ' ${betData.awayTeamScore}-${betData.homeTeamScore}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: Styles.betHistoryCardNormal,
                    children: [
                      TextSpan(
                          text: betData.totalGameScore > betData.betOverUnder
                              ? 'ABOVE YOUR $overUnder ($odds)'
                              : 'BELOW YOUR $overUnder ($odds)'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      default:
        return Center(
          child: Text(
            'NO DATA FOUND',
            style: Styles.betHistoryCardNormal,
          ),
        );
    }
  }

  String betTypeString(String betType) {
    if (betType == 'moneyline') {
      return 'MONEYLINE';
    }
    if (betType == 'pointspread') {
      return 'POINT SPREAD';
    }
    if (betType == 'total') {
      return 'TOTAL O/U';
    } else {
      return 'ERROR';
    }
  }
}