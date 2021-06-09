import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/palette.dart';
import '../../../../../../config/styles.dart';
import '../../../../../../data/models/nhl/nhl_player.dart';
import '../../../../../shared_widgets/app_bar/app_bar.dart';

class PlayerDetailsPage extends StatelessWidget {
  PlayerDetailsPage({this.playerId, this.gameName, this.playerDetails});
  final String playerId;
  final String gameName;
  final NhlPlayer playerDetails;

  static Route route(
      {@required String playerId,
      @required String gameName,
      @required NhlPlayer playerDetails}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'PlayerDetails'),
      builder: (context) =>
          // BlocProvider<PlayerDetailsCubit>(
          //   create: (_) => PlayerDetailsCubit(
          //       sportsRepository: SportsRepository(), gameName: gameName)
          //     ..fetchPlayerDetails(playerID: playerId),
          //   child:
          PlayerDetailsPage(
              playerId: playerId,
              gameName: gameName,
              playerDetails: playerDetails),
      //),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: adaptiveAppBar(width: size.width),
      body: ListView(
        children: [
          Center(
            child: Text(
              'PLAYER STATS',
              style: GoogleFonts.nunito(
                fontSize: 24,
                color: Palette.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _playerBadge(size, playerDetails),
          _playerDescription(playerDetails),
          //_playerStats(playerDetails),
          _playerInjury(playerDetails)
          //_buildProfileWidget(size),
        ],
      ),
    );
  }

  Widget _playerBadge(Size size, NhlPlayer playerDetails) {
    return SizedBox(
      width: size.width,
      height: 130,
      child: Row(
        children: [
          const SizedBox(width: 12),
          Container(
            height: 100,
            width: 100,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Image.network(
                playerDetails.photoUrl,
                height: 100,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${playerDetails.firstName} ${playerDetails.lastName}',
                maxLines: 2,
                softWrap: true,
                style: Styles.largeTextBold.copyWith(fontSize: 30),
              ),
              Text(
                '#${playerDetails.jersey} ${playerDetails.position} ${playerDetails.team}',
                style: Styles.largeTextBold.copyWith(fontSize: 20),
              ),
              Text(
                '${playerDetails.birthState.toString().toUpperCase()} STATE',
                style: Styles.normalText.copyWith(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _playerDescription(NhlPlayer playerDetails) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 95,
              child: Center(
                child: Text(
                  'HEIGHT',
                  style: Styles.normalText
                      .copyWith(color: Palette.green, fontSize: 25),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              width: 95,
              child: Center(
                child: Text(
                  '${playerDetails.height ~/ 10}\'${playerDetails.height % 10}',
                  style: Styles.normalText
                      .copyWith(color: Palette.green, fontSize: 34),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 105,
              child: Center(
                child: Text(
                  'WEIGHT',
                  style: Styles.normalText
                      .copyWith(color: Palette.cream, fontSize: 25),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              width: 105,
              child: Center(
                child: Text(
                  '${playerDetails.weight}',
                  style: Styles.normalText
                      .copyWith(color: Palette.cream, fontSize: 34),
                ),
              ),
            ),
          ],
        ),
        // Column(
        //   children: [
        //     Container(
        //       margin: const EdgeInsets.symmetric(horizontal: 8),
        //       width: 105,
        //       child: Center(
        //         child: Text(
        //           'SEASON',
        //           style: Styles.normalText
        //               .copyWith(color: Palette.red, fontSize: 25),
        //         ),
        //       ),
        //     ),
        //     Container(
        //       margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        //       width: 105,
        //       child: Center(
        //         child: Text(
        //           //NOT SURE
        //           '${playerDetails.experience}',
        //           style: Styles.normalText
        //               .copyWith(color: Palette.red, fontSize: 34),
        //         ),
        //       ),
        //     )
        //   ],
        // )
      ],
    );
  }

  // Widget _playerStats(NhlPlayer playerDetails) {
  //   //CHANGE REAL DATA HERE
  //   final tableStats = {
  //     'FIELD GOALS': [2937, 6953, 52.6],
  //     'TWO POINTERS': [2937, 6953, 52.6],
  //     'THREE POINTERS': [2937, 6953, 52.6],
  //     'FREE THROWS': [2937, 6953, 52.6]
  //   };
  //   return Column(
  //     children: [
  //       Container(
  //         width: 380,
  //         decoration: BoxDecoration(
  //           color: Palette.lightGrey,
  //           border: Border.all(
  //             color: Palette.cream,
  //           ),
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         padding: const EdgeInsets.all(8),
  //         child: Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 SizedBox(
  //                     width: 60,
  //                     child: Text(
  //                       'MADE',
  //                       style: Styles.normalText.copyWith(fontSize: 13),
  //                       textAlign: TextAlign.center,
  //                     )),
  //                 SizedBox(
  //                     width: 80,
  //                     child: Text(
  //                       'ATTEMPTED',
  //                       style: Styles.normalText.copyWith(fontSize: 13),
  //                       textAlign: TextAlign.center,
  //                     )),
  //                 SizedBox(
  //                     width: 90,
  //                     child: Text(
  //                       'PERCENTAGE',
  //                       style: Styles.normalText.copyWith(fontSize: 13),
  //                       textAlign: TextAlign.center,
  //                     ))
  //               ],
  //             ),
  //             ...tableStats.keys
  //                 .map(
  //                   (fieldName) => Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       Text(
  //                         fieldName,
  //                         style: Styles.normalText.copyWith(fontSize: 13),
  //                       ),
  //                       const SizedBox(
  //                         width: 10,
  //                       ),
  //                       SizedBox(
  //                           width: 60,
  //                           child: Text(
  //                             tableStats[fieldName][0].toString(),
  //                             style:
  //                                 Styles.greenTextBold.copyWith(fontSize: 13),
  //                             textAlign: TextAlign.center,
  //                           )),
  //                       SizedBox(
  //                           width: 80,
  //                           child: Text(
  //                             tableStats[fieldName][1].toString(),
  //                             style: Styles.greenTextBold
  //                                 .copyWith(fontSize: 13, color: Palette.red),
  //                             textAlign: TextAlign.center,
  //                           )),
  //                       SizedBox(
  //                           width: 90,
  //                           child: Text(
  //                             tableStats[fieldName][2].toString(),
  //                             style:
  //                                 Styles.normalTextBold.copyWith(fontSize: 13),
  //                             textAlign: TextAlign.center,
  //                           ))
  //                     ],
  //                   ),
  //                 )
  //                 .toList(),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 15,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Column(
  //             children: [
  //               Container(
  //                 width: 90,
  //                 margin: const EdgeInsets.symmetric(horizontal: 8),
  //                 child: Center(
  //                   child: Text(
  //                     'REBOUNDS',
  //                     style: Styles.normalText
  //                         .copyWith(color: Palette.green, fontSize: 15),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 width: 90,
  //                 margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
  //                 child: Center(
  //                   child: Text(
  //                     '45',
  //                     style: Styles.normalText
  //                         .copyWith(color: Palette.green, fontSize: 20),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 width: 90,
  //                 margin: const EdgeInsets.symmetric(horizontal: 8),
  //                 child: Center(
  //                   child: Text(
  //                     'ASSISTS',
  //                     style: Styles.normalText
  //                         .copyWith(color: Palette.green, fontSize: 15),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
  //                 width: 90,
  //                 child: Center(
  //                   child: Text(
  //                     '45',
  //                     style: Styles.normalText
  //                         .copyWith(color: Palette.green, fontSize: 20),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Column(
  //             children: [
  //               Container(
  //                 width: 90,
  //                 margin: const EdgeInsets.symmetric(horizontal: 8),
  //                 child: Center(
  //                   child: Text(
  //                     'BLOCKED',
  //                     style: Styles.normalText
  //                         .copyWith(color: Palette.cream, fontSize: 15),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 width: 90,
  //                 margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
  //                 child: Center(
  //                   child: Text(
  //                     '65',
  //                     style: Styles.normalText
  //                         .copyWith(color: Palette.cream, fontSize: 20),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 width: 90,
  //                 margin: const EdgeInsets.symmetric(horizontal: 8),
  //                 child: Center(
  //                   child: Text(
  //                     'STEALS',
  //                     style: Styles.normalText
  //                         .copyWith(color: Palette.cream, fontSize: 15),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 width: 90,
  //                 margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
  //                 child: Center(
  //                   child: Text(
  //                     '65',
  //                     style: Styles.normalText
  //                         .copyWith(color: Palette.cream, fontSize: 20),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Column(
  //             children: [
  //               Container(
  //                 width: 100,
  //                 margin: const EdgeInsets.symmetric(horizontal: 8),
  //                 child: Center(
  //                   child: Text(
  //                     'TURNOVERS',
  //                     style: Styles.normalText
  //                         .copyWith(color: Palette.red, fontSize: 15),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 width: 100,
  //                 margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
  //                 child: Center(
  //                   child: Text(
  //                     '12',
  //                     style: Styles.normalText
  //                         .copyWith(color: Palette.red, fontSize: 20),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 width: 135,
  //                 margin: const EdgeInsets.symmetric(horizontal: 8),
  //                 child: Center(
  //                   child: Text(
  //                     'PERSONAL FOULS',
  //                     style: Styles.normalText
  //                         .copyWith(color: Palette.red, fontSize: 15),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 width: 140,
  //                 margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
  //                 child: Center(
  //                   child: Text(
  //                     '12',
  //                     style: Styles.normalText
  //                         .copyWith(color: Palette.red, fontSize: 20),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           )
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _playerInjury(NhlPlayer playerDetails) {
    return Container(
      width: 380,
      decoration: BoxDecoration(
        color: Palette.lightGrey,
        border: Border.all(
          color: Palette.cream,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'INJURY STATUS',
                    style: Styles.greenText.copyWith(fontSize: 16),
                  ),
                  Text(
                    playerDetails.injuryStatus?.toUpperCase() ?? 'NONE',
                    style: Styles.normalText.copyWith(fontSize: 16),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'BODY PART',
                    style: Styles.greenText.copyWith(fontSize: 16),
                  ),
                  Text(
                    playerDetails.injuryBodyPart?.toUpperCase() ?? 'NONE',
                    style: Styles.normalText.copyWith(fontSize: 16),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'INJURY NOTES',
            style: Styles.normalText.copyWith(color: Palette.red, fontSize: 16),
          ),
          Text(
            playerDetails.injuryNotes ?? 'NONE',
            style: Styles.normalText.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
