import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/extensions.dart';
import '../../../../../../config/palette.dart';
import '../../../../../../config/styles.dart';
import '../../../../../../data/models/nfl/nfl_player.dart';
import '../../../../../../data/repositories/sport_repository.dart';
import '../../../../../../utils/app_bar.dart';
import 'cubit/player_details_cubit.dart';

class PlayerDetailsPage extends StatelessWidget {
  const PlayerDetailsPage({
    Key? key,
    this.playerId,
    this.gameName,
    this.playerDetails,
  }) : super(key: key);
  final String? playerId;
  final String? gameName;
  final NflPlayer? playerDetails;

  static Route route({
    required String playerId,
    required String? gameName,
    required NflPlayer playerDetails,
  }) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'PlayerDetails'),
      builder: (context) => BlocProvider<PlayerDetailsCubit>(
        create: (_) => PlayerDetailsCubit(
            sportsRepository: context.read<SportRepository>())
          ..getPlayerDetails(playerId: playerId),
        child: PlayerDetailsPage(
          playerId: playerId,
          gameName: gameName,
          playerDetails: playerDetails,
        ),
      ),
    );
  }

  Widget _playerBadge(Size size, NflPlayer playerDetails) {
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
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              foregroundImage: CachedNetworkImageProvider(
                playerDetails.photoUrl!,
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
                  '${playerDetails.number != null ? '#${playerDetails.number}' : ''} ${playerDetails.position ?? ''} ${playerDetails.team ?? ''}',
                  style: Styles.largeTextBold.copyWith(fontSize: 20),
                ),
                Text(
                  (playerDetails.college ?? 'NA').toUpperCase(),
                  style: Styles.normalText.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _playerDescription(NflPlayer playerDetails) {
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
              playerDetails.height ?? 'NA',
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
              '${ESTDateTime.fetchTimeEST().difference(playerDetails.birthDate!).inDays ~/ 365}',
              style: Styles.teamStatsMain.copyWith(color: Palette.red),
            )
          ],
        ),
      ],
    );
  }

  Widget _playerInjury(NflPlayer playerDetails) {
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
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'INJURY STATUS:',
                style: Styles.greenText
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    playerDetails.injuryStatus
                            ?.toString()
                            .substring(7)
                            .toUpperCase() ??
                        'NONE',
                    style: Styles.normalText
                        .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                width: 140,
                child: Column(
                  children: [
                    Text(
                      'BODY PART',
                      textAlign: TextAlign.center,
                      style: Styles.greenText.copyWith(fontSize: 16),
                    ),
                    Text(
                      playerDetails.injuryBodyPart?.toString().toUpperCase() ??
                          'NONE',
                      textAlign: TextAlign.center,
                      style: Styles.normalText.copyWith(
                        fontSize: 16,
                        color: playerDetails.injuryBodyPart == null
                            ? Palette.cream
                            : Palette.red,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'INJURY NOTES',
                        style: Styles.normalText
                            .copyWith(color: Palette.red, fontSize: 16),
                      ),
                      Text(
                        playerDetails.injuryNotes?.toString() ?? 'NONE',
                        style: Styles.normalText.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: adaptiveAppBar(width: size.width),
      body: Center(
        child: SizedBox(
          width: 380,
          child: ListView(
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
              _playerBadge(size, playerDetails!),
              _playerDescription(playerDetails!),
              BlocBuilder<PlayerDetailsCubit, PlayerDetailsState>(
                builder: (context, state) {
                  if (state is PlayerDetailsOpened) {
                    return NflPlayerStatsBox(
                      statset1: <String, dynamic>{
                        'TD': state.playerStats.touchdowns,
                        'FGA': state.playerStats.fieldGoalsAttempted,
                        'FGM': state.playerStats.fieldGoalsMade,
                      },
                      statset2: <String, dynamic>{
                        'R Att': state.playerStats.rushingAttempts,
                        'R Yds': state.playerStats.rushingYards,
                        'R Y/A': state.playerStats.rushingYardsPerAttempt,
                        'R TD': state.playerStats.rushingTouchdowns,
                        'Pnt': state.playerStats.punts,
                        'Lng': state.playerStats.puntLong,
                      },
                      statset3: <String, dynamic>{
                        'P TD': state.playerStats.passingTouchdowns,
                        'P Int': state.playerStats.passingInterceptions,
                        'P Y/A': state.playerStats.passingYardsPerAttempt,
                        'P Y/C': state.playerStats.passingYardsPerCompletion
                      },
                      statset4: <String, dynamic>{
                        'Solo': state.playerStats.soloTackles,
                        'Fmb': state.playerStats.fumbles,
                        'Ast': state.playerStats.assistedTackles,
                        'QBHits': state.playerStats.quarterbackHits,
                        'TFL': state.playerStats.tacklesForLoss,
                      },
                    );
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
              _playerInjury(playerDetails!)
            ],
          ),
        ),
      ),
    );
  }
}

class NflPlayerStatsBox extends StatelessWidget {
  const NflPlayerStatsBox({
    Key? key,
    required this.statset1,
    required this.statset2,
    required this.statset3,
    required this.statset4,
  }) : super(key: key);
  final Map<String, dynamic> statset1, statset2, statset3, statset4;

  Widget _statsText(String t1, dynamic t2) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            t1,
            style: Styles.normalText.copyWith(fontSize: 11),
          ),
          Text(
            t2?.toString() ?? 'N/A',
            style: Styles.normalText.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _statsVDivider() {
    return const SizedBox(
      height: 40,
      child: VerticalDivider(
        color: Palette.cream,
        thickness: 1,
        width: 10,
      ),
    );
  }

  Widget _statsHDivider() {
    return const SizedBox(
        width: 350,
        child: Divider(
          color: Palette.cream,
          thickness: 1,
          height: 10,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 135,
      margin: const EdgeInsets.only(top: 20, bottom: 18),
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 22),
      decoration: BoxDecoration(
          color: Palette.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: Palette.cream,
          )),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...statset1.entries
                  .map((stat) => _statsText(stat.key, stat.value))
                  .toList(),
              _statsVDivider(),
              ...statset2.entries
                  .map((stat) => _statsText(stat.key, stat.value))
                  .toList(),
            ],
          ),
          _statsHDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...statset3.entries
                  .map((stat) => _statsText(stat.key, stat.value))
                  .toList(),
              _statsVDivider(),
              ...statset4.entries
                  .map((stat) => _statsText(stat.key, stat.value))
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}
