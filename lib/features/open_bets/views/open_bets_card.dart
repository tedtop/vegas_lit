import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../../data/models/bet.dart';

class OpenBetsSlip extends StatelessWidget {
  const OpenBetsSlip({
    Key key,
    @required this.openBets,
  })  : assert(openBets != null),
        super(key: key);

  final BetData openBets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 2),
      child: Container(
        width: 390,
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Palette.cream, width: 0.8)),
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
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 3,
                        left: 4,
                        right: 4,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  'GAME',
                                  style: Styles.openBetsCardNormal,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(child: whichBetGame(betData: openBets)),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  'BET TYPES',
                                  style: Styles.openBetsCardNormal,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(child: whichBetType(betData: openBets)),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  'ODD',
                                  style: Styles.openBetsCardNormal,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(child: whichBetOdds(betData: openBets)),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  'YOU BET',
                                  style: Styles.openBetsCardNormal,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: whichBetYouBet(betData: openBets)),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        child: Container(
                          width: 3,
                          height: 110,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: Palette.green,
                          ),
                        ),
                        top: 8,
                        left: 94)
                  ],
                ),
              ),
            ),
            const SizedBox(width: 1),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              clipBehavior: Clip.antiAlias,
              width: 60,
              height: 130,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 64,
                    width: 60,
                    color: Palette.cream,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            DateFormat('c, MMM')
                                .format(
                                    DateTime.parse(openBets.gameStartDateTime)
                                        .toLocal())
                                .toUpperCase(),
                            style: Styles.openBetsCardTime),
                        Text(
                            DateFormat('y')
                                .format(
                                    DateTime.parse(openBets.gameStartDateTime)
                                        .toLocal())
                                .toUpperCase(),
                            style: Styles.openBetsCardTime),
                        Text(
                            DateFormat('hh:mm a')
                                .format(
                                    DateTime.parse(openBets.gameStartDateTime)
                                        .toLocal())
                                .toUpperCase(),
                            style: Styles.openBetsCardTime),
                      ],
                    ),
                  ),
                  Container(
                    height: 64,
                    width: 60,
                    color: Palette.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'TO WIN',
                          style: Styles.openBetsCardBetText.copyWith(
                            color: Palette.cream,
                          ),
                        ),
                        Text(
                          '\$${openBets.betProfit}',
                          style: Styles.openBetsCardBetMoney,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget whichBetGame({@required BetData betData}) {
  return RichText(
    text: TextSpan(
      style: Styles.openBetsCardNormal,
      children: [
        TextSpan(
          text: '${betData.awayTeamName.toUpperCase()}',
        ),
        const TextSpan(text: '  @  '),
        TextSpan(
          text: '${betData.homeTeamName.toUpperCase()}',
          style: GoogleFonts.nunito(color: Palette.green),
        ),
      ],
    ),
  );
}

Widget whichBetType({@required BetData betData}) {
  return Text(
    whichBetSystem(betData.betType),
    style: Styles.openBetsCardNormal,
    textAlign: TextAlign.start,
  );
}

Widget whichBetOdds({@required BetData betData}) {
  final odds = betData?.odds?.isNegative ?? 0.isNegative
      ? betData.odds.toString()
      : '+${betData.odds}';
  final isPointSpreadNegative =
      betData?.betPointSpread?.isNegative ?? 0.isNegative;
  final awayTeamPointSpread = isPointSpreadNegative
      ? '+${betData?.betPointSpread?.abs() ?? 0}'
      : betData?.betPointSpread != null
          ? '-${betData?.betPointSpread?.abs()}'
          : '0';
  final homeTeamPointSpread = isPointSpreadNegative
      ? betData?.betPointSpread != null
          ? '-${betData?.betPointSpread?.abs()}'
          : '0'
      : '+${betData?.betPointSpread?.abs()}' ?? '0';
  final overUnder = betData.betTeam == 'away'
      ? '+${betData.betOverUnder}'
      : '-${betData.betOverUnder}';
  switch (betData.betType) {
    case 'moneyline':
      return Text(
        odds,
        style: Styles.openBetsCardNormal,
      );
    case 'pointspread':
      return Text(
        '${betData.betTeam == 'away' ? awayTeamPointSpread : homeTeamPointSpread} @ $odds',
        style: Styles.openBetsCardNormal,
      );
    case 'total':
      return Text(
        '$overUnder @ $odds',
        style: Styles.openBetsCardNormal,
      );
    default:
      return Center(
        child: Text(
          'NO DATA FOUND',
          style: Styles.openBetsCardNormal,
        ),
      );
  }
}

Widget whichBetYouBet({@required BetData betData}) {
  final isPointSpreadNegative =
      betData?.betPointSpread?.isNegative ?? 0.isNegative;
  final overUnder = betData.betTeam == 'away'
      ? '+${betData.betOverUnder}'
      : '-${betData.betOverUnder}';
  switch (betData.betType) {
    case 'moneyline':
      return RichText(
        softWrap: true,
        text: TextSpan(
          style: Styles.openBetsCardNormal,
          children: [
            TextSpan(text: '\$${betData.betAmount} '),
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
      );
    case 'pointspread':
      return RichText(
          softWrap: true,
          text: TextSpan(style: Styles.openBetsCardNormal, children: [
            TextSpan(text: '\$${betData.betAmount} '),
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
            betData.betTeam == 'home'
                ? (isPointSpreadNegative
                    ? TextSpan(
                        text: 'WIN BY +${betData?.betPointSpread?.ceil() ?? 0}')
                    : TextSpan(
                        text:
                            'NOT LOSE BY -${betData?.betPointSpread?.ceil() ?? 0}'))
                : (isPointSpreadNegative
                    ? TextSpan(
                        text:
                            'NOT LOSE BY -${betData?.betPointSpread?.ceil() ?? 0}')
                    : TextSpan(
                        text:
                            'WIN BY +${betData?.betPointSpread?.ceil() ?? 0}'))
          ]));
    case 'total':
      return RichText(
        softWrap: true,
        maxLines: 2,
        text: TextSpan(
          style: Styles.openBetsCardNormal,
          children: [
            TextSpan(text: '\$${betData.betAmount} '),
            betData.betTeam == 'away'
                ? TextSpan(
                    text: 'TOTAL SCORE MORE THAN $overUnder ',
                    style: Styles.openBetsCardNormal,
                  )
                : TextSpan(
                    text: 'TOTAL SCORE LESS THAN $overUnder ',
                    style: Styles.openBetsCardNormal,
                  ),
          ],
        ),
      );
    default:
      return Center(
        child: Text(
          'NO DATA FOUND',
          style: Styles.openBetsCardNormal,
        ),
      );
  }
}
// Widget whichBetText({@required BetData betData}) {
//   final odds = betData?.odds?.isNegative ?? 0.isNegative
//       ? betData.odds.toString()
//       : '+${betData.odds}';
//   final isPointSpreadNegative =
//       betData?.betPointSpread?.isNegative ?? 0.isNegative;
//   final overUnder = betData.betTeam == 'away'
//       ? '${betData.betOverUnder}'
//       : '${betData.betOverUnder}';
//   final awayTeamPointSpread = isPointSpreadNegative
//       ? betData?.betPointSpread?.abs() ?? 0
//       : betData?.betPointSpread != null
//           ? -betData?.betPointSpread?.abs()
//           : 0;
//   final homeTeamPointSpread = isPointSpreadNegative
//       ? betData?.betPointSpread != null
//           ? -betData?.betPointSpread?.abs()
//           : 0
//       : betData?.betPointSpread?.abs() ?? 0;
//   switch (betData.betType) {
//     case 'moneyline':
//       return Column(
//         children: [
//           Text(
//             '${whichBetSystem(betData.betType)}  ($odds)',
//             style: Styles.openBetsCardNormal,
//           ),
//           const SizedBox(
//             height: 4,
//           ),
//           RichText(
//             text: TextSpan(
//               style: Styles.openBetsCardNormal,
//               children: [
//                 betData.betTeam == 'away'
//                     ? TextSpan(
//                         text: '${betData.awayTeamName.toUpperCase()} ',
//                         style: Styles.openBetsCardNormal,
//                       )
//                     : TextSpan(
//                         text: '${betData.homeTeamName.toUpperCase()} ',
//                         style: Styles.openBetsCardNormal
//                             .copyWith(color: Palette.green),
//                       ),
//                 const TextSpan(text: 'TO WIN'),
//               ],
//             ),
//           )
//         ],
//       );
//       break;
//     case 'pointspread':
//       if (betData.betTeam == 'away') {
//         return Column(
//           children: [
//             Text(
//               '${betData.awayTeamName.toUpperCase()} TO WIN ($odds)',
//               style: Styles.openBetsCardNormal,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             awayTeamPointSpread.isNegative
//                 ? Text(
//                     'BY MORE THAN ${awayTeamPointSpread.abs()} POINTS',
//                     style: Styles.openBetsCardNormal,
//                   )
//                 : Text(
//                     'OR LOSE BY LESS THAN ${awayTeamPointSpread.abs()} POINTS',
//                     maxLines: 1,
//                     textAlign: TextAlign.center,
//                     style: Styles.openBetsCardNormal,
//                   ),
//           ],
//         );
//       } else {
//         return Column(
//           children: [
//             RichText(
//               text: TextSpan(
//                 style: Styles.openBetsCardNormal,
//                 children: [
//                   TextSpan(
//                     text: '${betData.homeTeamName.toUpperCase()} ',
//                     style: Styles.openBetsCardNormal.copyWith(
//                       color: Palette.green,
//                     ),
//                   ),
//                   TextSpan(text: 'TO WIN ($odds)'),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             homeTeamPointSpread.isNegative
//                 ? Text(
//                     'BY MORE THAN ${homeTeamPointSpread.abs()} POINTS',
//                     style: Styles.openBetsCardNormal,
//                   )
//                 : Text(
//                     'OR LOSE BY LESS THAN ${homeTeamPointSpread.abs()} POINTS',
//                     maxLines: 1,
//                     textAlign: TextAlign.center,
//                     style: Styles.openBetsCardNormal,
//                   ),
//           ],
//         );
//       }
//       break;
//     case 'total':
//       if (betData.betTeam == 'away') {
//         return Column(
//           children: [
//             Text(
//               'YOU BET THE COMBINED SCORE',
//               style: Styles.openBetsCardNormal,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               'WILL BE ABOVE $overUnder @ ($odds)',
//               style: Styles.openBetsCardNormal,
//             )
//           ],
//         );
//       } else {
//         return Column(
//           children: [
//             Text(
//               'YOU BET THE COMBINED SCORE',
//               style: Styles.openBetsCardNormal,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               'WILL BE BELOW $overUnder @ ($odds)',
//               style: Styles.openBetsCardNormal,
//             )
//           ],
//         );
//       }
//       break;
//     default:
//       return Center(
//         child: Text(
//           'NO DATA FOUND',
//           style: Styles.openBetsCardNormal,
//         ),
//       );
//   }
// }

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
    return 'ERROR';
  }
}
