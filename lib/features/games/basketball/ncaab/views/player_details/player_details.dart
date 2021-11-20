import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/extensions.dart';
import '../../../../../../config/palette.dart';
import '../../../../../../config/styles.dart';
import '../../../../../../data/models/ncaab/ncaab_player.dart';
import '../../../../../../data/repositories/sport_repository.dart';
import '../../../../../../utils/app_bar.dart';
import '../../../../../../utils/vl_image.dart';
import 'cubit/player_details_cubit.dart';

class PlayerDetailsPage extends StatelessWidget {
  const PlayerDetailsPage({this.playerId, this.gameName, this.playerDetails});
  final String? playerId;
  final String? gameName;
  final NcaabPlayer? playerDetails;

  static Route route(
      {required String playerId,
      required String? gameName,
      required NcaabPlayer playerDetails}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'PlayerDetails'),
      builder: (context) => BlocProvider<PlayerDetailsCubit>(
        create: (_) => PlayerDetailsCubit(
            sportsRepository: context.read<SportRepository>())
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
          _playerBadge(size, playerDetails!),
          _playerDescription(playerDetails!),
          BlocBuilder<PlayerDetailsCubit, PlayerDetailsState>(
            builder: (context, state) {
              if (state is PlayerDetailsOpened) {
                return StatsBox(statMap: state.playerStats.toStatOnlyMap());
              } else {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Palette.cream,
                  )),
                );
              }
            },
          ),
          _playerInjury(playerDetails!)
          //_buildProfileWidget(size),
        ],
      ),
    );
  }

  Widget _playerBadge(Size size, NcaabPlayer playerDetails) {
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
              child: VLImage.network(playerDetails.photoUrl!),
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
                  '${playerDetails.jersey != null ? '#${playerDetails.jersey}' : ''} ${playerDetails.position ?? ''} ${playerDetails.team ?? ''}',
                  style: Styles.largeTextBold.copyWith(fontSize: 20),
                ),
                Text(
                  '${(playerDetails.birthState ?? 'NA').toUpperCase()} STATE',
                  style: Styles.normalText.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _playerDescription(NcaabPlayer playerDetails) {
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
              playerDetails.height != null
                  ? '${playerDetails.height! ~/ 12}′ ${playerDetails.height! % 12}′′'
                  : 'NA',
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

  Widget _playerInjury(NcaabPlayer playerDetails) {
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
                    playerDetails.injuryStatus?.toString().toUpperCase() ??
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
              Column(
                children: [
                  Text(
                    'BODY PART',
                    style: Styles.greenText.copyWith(fontSize: 16),
                  ),
                  Text(
                    playerDetails.injuryBodyPart?.toString().toUpperCase() ??
                        'NONE',
                    style: Styles.normalText.copyWith(
                      fontSize: 16,
                      color: playerDetails.injuryBodyPart == null
                          ? Palette.cream
                          : Palette.red,
                    ),
                  )
                ],
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
}

class StatsBox extends StatelessWidget {
  const StatsBox({Key? key, required this.statMap}) : super(key: key);
  final Map<String, dynamic> statMap;

  List<Widget> _statMapToList() {
    return statMap.keys.map(
      (key) {
        if (statMap[key] != null) {
          return StatsText(
            leftText: key,
            rightText: statMap[key],
          );
        } else {
          return const SizedBox();
        }
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final statsList = _statMapToList();
    final statsOffset = (statsList.length ~/ 2) + 8;
    return Container(
      width: 380,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
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
            width: 170,
            child: Column(
              children: statsList.sublist(0, statsOffset),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
              child: Column(
            children: statsList.sublist(statsOffset),
          ))
        ],
      ),
    );
  }
}

class StatsText extends StatelessWidget {
  const StatsText({Key? key, this.leftText, this.rightText}) : super(key: key);
  final String? leftText;
  final dynamic rightText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 110, child: Text(leftText!, style: Styles.teamStatsText)),
        Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Text('$rightText', style: Styles.teamStatsText))),
      ],
    );
  }
}
