import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/helpers/olympic_helper.dart';
import 'package:vegas_lit/data/models/olympics/olympic_bet.dart';

// class OlympicsOpenBetCard2 extends StatelessWidget {
//   const OlympicsOpenBetCard2({
//     Key key,
//     @required this.openBets,
//   })  : assert(openBets != null),
//         super(key: key);

//   final OlympicsBetData openBets;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(10, 20, 10, 2),
//       child: Container(
//         width: 390,
//         height: 180,
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Palette.cream,
//           ),
//           borderRadius: BorderRadius.circular(12),
//           color: Palette.cream,
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Card(
//                 margin: EdgeInsets.zero,
//                 shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     bottomLeft: Radius.circular(12),
//                   ),
//                 ),
//                 color: Palette.darkGrey,
//                 child: Container(
//                   padding: const EdgeInsets.only(
//                     top: 11,
//                     bottom: 3,
//                     left: 6,
//                     right: 6,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             '${OlympicHelper.countryFlagFromCode(countryCode: openBets.rivalCountry)}',
//                             style: GoogleFonts.nunito(
//                               color: Palette.green,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             maxLines: 2,
//                             textAlign: TextAlign.center,
//                           ),
//                           Text(
//                             '${openBets.rivalName}',
//                             style: GoogleFonts.nunito(
//                               color: Palette.green,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             maxLines: 2,
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             '${OlympicHelper.countryFlagFromCode(countryCode: openBets.playerCountry)}',
//                             style: GoogleFonts.nunito(
//                               color: Palette.green,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             maxLines: 2,
//                             textAlign: TextAlign.center,
//                           ),
//                           Text(
//                             '${openBets.playerName}',
//                             style: GoogleFonts.nunito(
//                               color: Palette.green,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             maxLines: 2,
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 3,
//                       ),
//                       Text(
//                         openBets.gameName
//                             .replaceAll(RegExp('-'), '\/')
//                             .toUpperCase(),
//                         style: Styles.openBetsCardNormal
//                             .copyWith(color: Palette.green),
//                       ),
//                       const SizedBox(
//                         height: 3,
//                       ),
//                       Text(
//                         openBets.event,
//                         style: Styles.openBetsCardNormal,
//                       ),
//                       const SizedBox(
//                         height: 3,
//                       ),
//                       Text(
//                         '${OlympicHelper.countryFlagFromCode(countryCode: openBets.betTeam == 'player' ? openBets.playerCountry : openBets.rivalCountry)} TO WIN',
//                         style: Styles.openBetsCardNormal,
//                       ),

//                       // Last Row
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   DateFormat('E, MMMM, c, y @ hh:mm a')
//                                       .format(openBets.gameStartDateTime),
//                                   style: Styles.openBetsCardTime,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 1),
//             Card(
//               margin: EdgeInsets.zero,
//               clipBehavior: Clip.antiAlias,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(12),
//                   bottomRight: Radius.circular(12),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 90,
//                     height: 56,
//                     decoration: const BoxDecoration(
//                       color: Palette.darkGrey,
//                     ),
//                     child: OlympicHelper.badgeFromEventType(
//                         eventType: openBets.eventType),
//                   ),
//                   Container(
//                     width: 90,
//                     height: 61,
//                     decoration: const BoxDecoration(
//                       color: Palette.green,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('ticket cost', style: Styles.openBetsCardBetText),
//                         Text('${openBets.betAmount}',
//                             style: Styles.openBetsCardBetMoney),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 90,
//                     height: 61,
//                     decoration: const BoxDecoration(
//                       color: Palette.cream,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'max win',
//                           style: Styles.openBetsCardBetText.copyWith(
//                             color: Palette.green,
//                           ),
//                         ),
//                         Text(
//                           '${openBets.betProfit}',
//                           style: Styles.openBetsCardBetMoney
//                               .copyWith(color: Palette.green),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${OlympicHelper.countryFlagFromCode(countryCode: openBets.playerCountry)}',
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      color: Palette.cream,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '${openBets.playerName}',
                                    style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      color: Palette.cream,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${OlympicHelper.countryFlagFromCode(countryCode: openBets.rivalCountry)}',
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      color: Palette.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '${openBets.rivalName}',
                                    style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      color: Palette.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    '${Images.olympicsIconsPath}${openBets.gameName}.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${openBets.gameName.replaceAll(RegExp('-'), '\/')}',
                                    style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      color: Palette.cream,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: FittedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      openBets.eventType == 'gold'
                                          ? const Text(
                                              '🥇',
                                              style: TextStyle(fontSize: 14),
                                            )
                                          : openBets.eventType == 'silver'
                                              ? const Text(
                                                  '🥈',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                )
                                              : openBets.eventType == 'bronze'
                                                  ? const Text(
                                                      '🥉',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    )
                                                  : const SizedBox.shrink(),
                                      Image.asset(
                                        '${Images.olympicsIconsPath}Olympics.png',
                                        height: 12,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 1,
                          ),

                          Text(
                            openBets.event,
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
