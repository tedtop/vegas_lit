import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/models/mlb/mlb_player_stats.dart';
import 'package:vegas_lit/data/repositories/sports_repository.dart';
import 'package:vegas_lit/features/games/baseball/mlb/widgets/stat_widgets.dart';

import '../../../../../../config/palette.dart';
import '../../../../../../config/styles.dart';
import '../../../../../../data/models/mlb/mlb_player.dart';
import '../../../../../shared_widgets/app_bar/app_bar.dart';
import 'cubit/player_details_cubit.dart';

class PlayerDetailsPage extends StatelessWidget {
  PlayerDetailsPage({this.playerId, this.gameName, this.playerDetails});
  final String playerId;
  final String gameName;
  final MlbPlayer playerDetails;

  static Route route(
      {@required String playerId,
      @required String gameName,
      @required MlbPlayer playerDetails}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'PlayerDetails'),
      builder: (context) => BlocProvider<PlayerDetailsCubit>(
        create: (_) => PlayerDetailsCubit(
            sportsRepository: context.read<SportsRepository>())
          ..getPlayerDetails(playerId: playerId),
        child: PlayerDetailsPage(
            playerId: playerId,
            gameName: gameName,
            playerDetails: playerDetails),
      ),
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
          BlocBuilder<PlayerDetailsCubit, PlayerDetailsState>(
            builder: (context, state) {
              if (state is PlayerDetailsOpened) {
                return _playerStats(state.playerStats);
              } else {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Palette.cream,
                  )),
                );
              }
            },
          ),
          _playerInjury(playerDetails)
          //_buildProfileWidget(size),
        ],
      ),
    );
  }

  Widget _playerStats(MlbPlayerStats stats) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: 380,
          margin: const EdgeInsets.only(top: 20, bottom: 40),
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 22),
          decoration: BoxDecoration(
              color: Palette.lightGrey,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: Palette.cream,
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 145,
                child: Column(
                  children: [
                    StatsText(
                      leftText: 'AT BATS',
                      rightText: '${stats.atBats ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'RUNS',
                      rightText: '${stats.runs ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'HITS',
                      rightText: '${stats.hits ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'SINGLES',
                      rightText: '${stats.singles ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'DOUBLES',
                      rightText: '${stats.doubles ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'TRIPLES',
                      rightText: '${stats.triples ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'HOME RUNS',
                      rightText: '${stats.homeRuns ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'RUNS BATTED IN',
                      rightText: '${stats.runsBattedIn ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'BATTING AVERAGE',
                      rightText: '${stats.battingAverage ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'OUTS',
                      rightText: '${stats.outs ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'STRIKEOUTS',
                      rightText: '${stats.strikeouts ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'WALKS',
                      rightText: '${stats.walks ?? 'NA'}',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  children: [
                    StatsText(
                      leftText: 'BATTING ORDER',
                      rightText: '${stats.battingOrder ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'HIT BY PITCH',
                      rightText: '${stats.hitByPitch ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'SACRIFICES',
                      rightText: '${stats.sacrifices ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'SACRIFICE FLIES',
                      rightText: '${stats.sacrificeFlies ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'GROUND INTO DOUBLE PLAY',
                      rightText: '${stats.groundIntoDoublePlay ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'STOLEN BASES',
                      rightText: '${stats.stolenBases ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'CAUGHT STEALING',
                      rightText: '${stats.caughtStealing ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'PITCHES SEEN',
                      rightText: '${stats.pitchesSeen ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'ON BASE PERCENTAGE',
                      rightText: '${stats.onBasePercentage ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'SLUGGING PERCENTAGE',
                      rightText: '${stats.sluggingPercentage ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'ON BASE PLUS SLUGGING',
                      rightText: '${stats.onBasePlusSlugging ?? 'NA'}',
                    ),
                    StatsText(
                      leftText: 'ERRORS',
                      rightText: '${stats.errors ?? 'NA'}',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          child: Container(
            height: 35,
            width: 100,
            decoration: const BoxDecoration(
                color: Palette.green,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 0.5,
                      offset: Offset(-2, 1),
                      color: Palette.darkGrey)
                ]),
            child: const Center(
              child: Text('FULL STATS'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _playerBadge(Size size, MlbPlayer playerDetails) {
    return SizedBox(
      width: size.width,
      height: 150,
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${playerDetails.firstName} ${playerDetails.lastName}',
                  maxLines: 3,
                  softWrap: true,
                  style: Styles.largeTextBold.copyWith(fontSize: 30),
                ),
                Text(
                  '#${playerDetails.jersey} ${playerDetails.position} ${playerDetails.team}',
                  style: Styles.largeTextBold.copyWith(fontSize: 20),
                ),
                Text(
                  '${'${playerDetails.birthState ?? 'NA'}'.toUpperCase()} STATE',
                  style: Styles.normalText.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _playerDescription(MlbPlayer playerDetails) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              'HEIGHT',
              style: Styles.teamStatsMain.copyWith(color: Palette.green),
            ),
            Text(
              '${playerDetails.height ?? 'NA'}',
              style: Styles.teamStatsMain.copyWith(color: Palette.green),
            )
          ],
        ),
        Column(
          children: [
            Text(
              'WEIGHT',
              style: Styles.teamStatsMain.copyWith(color: Palette.cream),
            ),
            Text(
              '${playerDetails.weight ?? 'NA'}',
              style: Styles.teamStatsMain.copyWith(color: Palette.cream),
            )
          ],
        ),
        Column(
          children: [
            Text(
              'AGE',
              style: Styles.teamStatsMain.copyWith(color: Palette.red),
            ),
            Text(
              '${ESTDateTime.fetchTimeEST().difference(playerDetails.birthDate).inDays ~/ 365}',
              style: Styles.teamStatsMain.copyWith(color: Palette.red),
            )
          ],
        ),
      ],
    );
  }

  // Widget _playerStats(MlbPlayer playerDetails) {
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
  //                             tableStats[fieldName][0]??'NA'}',
  //                             style:
  //                                 Styles.greenTextBold.copyWith(fontSize: 13),
  //                             textAlign: TextAlign.center,
  //                           )),
  //                       SizedBox(
  //                           width: 80,
  //                           child: Text(
  //                             tableStats[fieldName][1]??'NA'}',
  //                             style: Styles.greenTextBold
  //                                 .copyWith(fontSize: 13, color: Palette.red),
  //                             textAlign: TextAlign.center,
  //                           )),
  //                       SizedBox(
  //                           width: 90,
  //                           child: Text(
  //                             tableStats[fieldName][2]??'NA'}',
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

  Widget _playerInjury(MlbPlayer playerDetails) {
    return Container(
      width: 380,
      decoration: BoxDecoration(
        color: Palette.lightGrey,
        border: Border.all(
          color: Palette.cream,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
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
                    style: Styles.normalText.copyWith(
                      fontSize: 16,
                      color: playerDetails.injuryBodyPart == null
                          ? Palette.cream
                          : Palette.red,
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            width: 25,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'INJURY NOTES',
                  style: Styles.normalText
                      .copyWith(color: Palette.red, fontSize: 16),
                ),
                Text(
                  playerDetails.injuryNotes ?? 'NONE',
                  style: Styles.normalText.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
