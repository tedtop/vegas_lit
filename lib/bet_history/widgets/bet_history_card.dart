import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
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
    final isWin = betHistory.winningTeam == betHistory.betTeam;
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
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.normal,
                              color: Palette.cream,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${betHistory.awayTeamName.toUpperCase()}',
                              ),
                              const TextSpan(text: '  @  '),
                              TextSpan(
                                text:
                                    '${betHistory.homeTeamName.toUpperCase()}',
                                style: GoogleFonts.nunito(color: Palette.green),
                              ),
                            ],
                          ),
                        ),
                        whichBetText(betData: betHistory),
                        // Last Row
                        Row(
                          children: [
                            // Text(
                            //   '${betHistory.betType == 'moneyline' ? 'M' : betHistory.betType == 'pointspread' ? 'P' : 'T'}',
                            //   style: GoogleFonts.nunito(
                            //     fontSize: 14,
                            //     color: Palette.cream,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  DateFormat('E, MMMM, c, y @ hh:mm a').format(
                                    DateTime.parse(betHistory.gameDateTime)
                                        .toLocal(),
                                  ),
                                  style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    color: isWin ? Palette.green : Palette.red,
                                  ),
                                ),
                              ),
                            ),
                            // Text(
                            //   '${betHistory.betType == 'moneyline' ? 'M' : betHistory.betType == 'pointspread' ? 'P' : 'T'}',
                            //   style: GoogleFonts.nunito(
                            //     fontSize: 14,
                            //     color: Palette.cream,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
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
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isWin ? Palette.green : Palette.red,
                            ),
                          ),
                          Text(
                            '\$${betHistory.betAmount}',
                            style: GoogleFonts.nunito(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
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
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: Palette.cream,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            isWin
                                ? '\$${betHistory.betProfit}'
                                : '\$${betHistory.betAmount}',
                            style: GoogleFonts.nunito(
                              fontSize: 24,
                              color: Palette.cream,
                              fontWeight: FontWeight.bold,
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
                whichBetSystem(betHistory.betType),
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
    final textStyle = GoogleFonts.nunito(
      fontSize: 14,
      color: Palette.cream,
    );
    final odds = betHistory.odds.isNegative
        ? betHistory.odds.toString()
        : '+${betHistory.odds}';
    final pointSpread = betHistory.betPointSpread;

    final isWin = betHistory.winningTeam == betHistory.betTeam;
    final betTeam = betHistory.betTeam == 'home'
        ? betHistory.homeTeamName
        : betHistory.awayTeamName;
    // final notBetTeam = betHistory.betTeam != 'home'
    //     ? betHistory.homeTeamName
    //     : betHistory.awayTeamName;
    final winTeamByScore = betData.awayTeamScore > betData.homeTeamScore
        ? betData.awayTeamName
        : betData.homeTeamName;
    final loseTeamByScore = betData.awayTeamScore > betData.homeTeamScore
        ? betData.homeTeamName
        : betData.awayTeamName;

    switch (betData.betType) {
      case 'moneyline':
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                text: TextSpan(
                  style: textStyle,
                  children: [
                    betHistory.betTeam == 'away'
                        ? TextSpan(
                            text: '${betTeam.toUpperCase()} ',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: Palette.cream,
                            ),
                          )
                        : TextSpan(
                            text: '${betTeam.toUpperCase()} ',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: Palette.green,
                            ),
                          ),
                    TextSpan(text: isWin ? 'WON' : 'LOST'),
                    TextSpan(
                        text:
                            ' ${betData.awayTeamScore}-${betData.homeTeamScore}'),
                  ],
                ),
              ),
              Text(
                '${whichBetSystem(betData.betType)}  ($odds)',
                style: textStyle,
              ),
            ],
          ),
        );
        break;
      case 'pointspread':
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                text: TextSpan(
                  style: textStyle,
                  children: [
                    betHistory.betTeam == 'away'
                        ? TextSpan(
                            text: '${betTeam.toUpperCase()} ',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: Palette.cream,
                            ),
                          )
                        : TextSpan(
                            text: '${betTeam.toUpperCase()} ',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: Palette.green,
                            ),
                          ),
                    TextSpan(
                      text:
                          '${isWin ? 'WON' : 'LOST'} ${betData.awayTeamScore}-${betData.homeTeamScore}',
                    ),
                  ],
                ),
              ),
              Text(
                isWin
                    ? 'AUTOMATIC WIN $pointSpread ($odds)'
                    : 'AUTOMATIC LOSS $pointSpread ($odds)',
                style: textStyle,
              ),
            ],
          ),
        );

        break;
      case 'total':
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                text: TextSpan(
                  style: textStyle,
                  children: [
                    betHistory.betTeam == 'away'
                        ? TextSpan(
                            text: '${betTeam.toUpperCase()} ',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: Palette.cream,
                            ),
                          )
                        : TextSpan(
                            text: '${betTeam.toUpperCase()} ',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: Palette.green,
                            ),
                          ),
                    TextSpan(text: isWin ? 'WON' : 'LOST'),
                    TextSpan(
                        text:
                            ' ${betData.awayTeamScore}-${betData.homeTeamScore}'),
                  ],
                ),
              ),
              // Text(
              //   'COMBINED SCORE WAS ${betData.totalGameScore} (${betData.awayTeamScore}-${betData.homeTeamScore})',
              //   textAlign: TextAlign.center,
              //   style: textStyle,
              // ),
              RichText(
                text: TextSpan(
                  style: textStyle,
                  children: [
                    TextSpan(
                        text: betData.totalGameScore > betData.betOverUnder
                            ? 'ABOVE YOUR ${betData.betOverUnder} ($odds)'
                            : 'BELOW YOUR ${betData.betOverUnder} ($odds)'),
                    // TextSpan(
                    //   text: betData.betTeam == 'away'
                    //       ? ' ${betData.betOverUnder} ($odds)'
                    //       : ' ${betData.betOverUnder} ($odds)',
                    // ),
                  ],
                ),
              ),
            ],
          ),
        );
        break;
      default:
        return Center(
          child: Text(
            'NO DATA FOUND',
            style: textStyle,
          ),
        );
    }
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
