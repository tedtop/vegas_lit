import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/data/models/mlb/mlb_team_stats.dart';

import '../../../../../../config/palette.dart';
import '../../../../../../config/styles.dart';
import '../../../../../../data/models/mlb/mlb_player.dart';
import '../../../../../../data/repositories/sport_repository.dart';
import '../../../../../../utils/app_bar.dart';
import '../../../../../../utils/vl_image.dart';
import '../../models/mlb_team.dart';
import '../player_details/player_details.dart';
import 'cubit/team_info_cubit.dart';

class TeamInfo extends StatelessWidget {
  const TeamInfo._({this.teamData, this.gameName});
  final MlbTeam? teamData;
  final String? gameName;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: adaptiveAppBar(
        width: width,
      ),
      body: TeamInfoView(teamData: teamData, gameName: gameName),
    );
  }

  static Route route({required MlbTeam teamData, required String? gameName}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'TeamInfo'),
      builder: (context) => BlocProvider<TeamInfoCubit>(
        create: (_) => TeamInfoCubit(SportRepository())
          ..getTeamDetails(teamData.key, gameName),
        child: TeamInfo._(teamData: teamData, gameName: gameName),
      ),
    );
  }
}

class TeamInfoView extends StatelessWidget {
  const TeamInfoView({
    Key? key,
    this.teamData,
    this.gameName,
  }) : super(key: key);
  final MlbTeam? teamData;
  final String? gameName;

  Widget _teamStats(MlbTeamStats stats) {
    return SizedBox(
      width: 380,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'WINS',
                    style: Styles.teamStatsMain.copyWith(color: Palette.green),
                  ),
                  Text(
                    stats.wins.toString(),
                    style: Styles.teamStatsMain.copyWith(color: Palette.green),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'LEAGUE',
                    style: Styles.teamStatsMain.copyWith(color: Palette.cream),
                  ),
                  Text(
                    teamData?.league?.toString().substring(7) ?? 'N/A',
                    style: Styles.teamStatsMain.copyWith(color: Palette.cream),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'LOSSES',
                    style: Styles.teamStatsMain.copyWith(color: Palette.red),
                  ),
                  Text(
                    stats.losses.toString(),
                    style: Styles.teamStatsMain.copyWith(color: Palette.red),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayersList(List<MlbPlayer> players) {
    final teamColor = teamData!.primaryColor != null
        ? int.parse('0xA6${teamData!.primaryColor}')
        : Palette.lightGrey.value;
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(height: 4),
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push<void>(
                  context,
                  PlayerDetailsPage.route(
                      gameName: gameName,
                      playerId: players[index].playerId.toString(),
                      playerDetails: players[index]));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    padding: const EdgeInsets.only(left: 30),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.cream),
                        borderRadius: BorderRadius.circular(8),
                        color: Palette.lightGrey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${players[index].jersey != null ? '#${players[index].jersey}' : ''} ${players[index].firstName} ${players[index].lastName}',
                            style: Styles.normalText,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Column(
                            children: [
                              Text(
                                'POSITION',
                                style: Styles.greenText.copyWith(fontSize: 10),
                              ),
                              Text(
                                players[index].position?.toString() ?? 'N/A',
                                style:
                                    Styles.greenTextBold.copyWith(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(teamColor).withOpacity(1),
                    foregroundImage: CachedNetworkImageProvider(
                      players[index].photoUrl!,
                    ), //Image for web configuration.
                  )
                ],
              ),
            ));
      },
      itemCount: players.length,
    );
  }

  Widget _teamBadge(Size size) {
    return SizedBox(
      width: size.width,
      height: 130,
      child: Row(
        children: [
          const SizedBox(width: 12),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: teamData!.wikipediaLogoUrl != null
                ? VLImage.network(teamData!.wikipediaLogoUrl!)
                : SizedBox(
                    height: 100,
                    child: CircleAvatar(
                      backgroundColor: Palette.lightGrey,
                      child: Text(
                        teamData!.name!.characters.first,
                        style: Styles.largeTextBold.copyWith(fontSize: 40),
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                teamData!.name!,
                style: Styles.largeTextBold.copyWith(fontSize: 30),
              ),
              Text(
                teamData!.city!.toUpperCase(),
                style: Styles.normalText,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Center(
          child: Text(
            'TEAM STATS',
            style: GoogleFonts.nunito(
                fontSize: 24,
                color: Palette.green,
                fontWeight: FontWeight.bold),
          ),
        ),
        _teamBadge(size),
        const SizedBox(height: 12),
        BlocBuilder<TeamInfoCubit, TeamInfoState>(
          builder: (context, state) {
            if (state is TeamInfoOpened) {
              return Column(
                children: [
                  _teamStats(state.teamStats),
                  MlbTeamStatsBox(
                    hitting1: <String, dynamic>{
                      'G': state.teamStats.games,
                      'AB': state.teamStats.atBats,
                    },
                    hitting2: <String, dynamic>{
                      'R': state.teamStats.runs,
                      'H': state.teamStats.hits,
                      '2B': state.teamStats.doubles,
                      '3B': state.teamStats.triples,
                      'HR': state.teamStats.homeRuns,
                      'RBI': state.teamStats.runsBattedIn,
                    },
                    hitting3: <String, dynamic>{
                      'BB': state.teamStats.walks,
                      'SO': state.teamStats.strikeouts,
                      'SB': state.teamStats.stolenBases,
                      'CS': state.teamStats.caughtStealing,
                    },
                    hitting4: <String, dynamic>{
                      'AVG': state.teamStats.battingAverage,
                      'OBP': state.teamStats.onBasePercentage,
                      'SLG': state.teamStats.sluggingPercentage,
                      'OPS': state.teamStats.onBasePlusSlugging,
                    },
                    pitching1: <String, dynamic>{
                      'W': state.teamStats.wins,
                      'L': state.teamStats.losses,
                      'ERA': state.teamStats.earnedRunAverage,
                      'G': 'N/A',
                      'GS': 'N/A',
                      'CG': state.teamStats.pitchingCompleteGames,
                      'SHO': state.teamStats.pitchingShutOuts,
                      'SV': 'N/A',
                      'SVO': 'N/A',
                    },
                    pitching2: <String, dynamic>{
                      'IP': state.teamStats.inningsPitchedFull,
                      'H': state.teamStats.pitchingHits,
                      'R': state.teamStats.pitchingRuns,
                      'ER': state.teamStats.pitchingEarnedRuns,
                      'HR': state.teamStats.pitchingHomeRuns,
                      'HB': 'N/A',
                      'BB': state.teamStats.pitchingWalks,
                      'SO': state.teamStats.pitchingStrikeouts,
                    },
                    pitching3: <String, dynamic>{
                      'WHIP': state.teamStats.walksHitsPerInningsPitched,
                      'AVG': state.teamStats.pitchingBattingAverageAgainst,
                    },
                  ),
                  _buildPlayersList(state.players),
                ],
              );
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
        const SizedBox(height: 20),
      ],
    );
  }
}

class MlbTeamStatsBox extends StatelessWidget {
  const MlbTeamStatsBox({
    Key? key,
    required this.hitting1,
    required this.hitting2,
    required this.hitting3,
    required this.hitting4,
    required this.pitching1,
    required this.pitching2,
    required this.pitching3,
  }) : super(key: key);
  final Map<String, dynamic> hitting1, hitting2, hitting3, hitting4;
  final Map<String, dynamic> pitching1, pitching2, pitching3;

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
        height: 180,
        margin: const EdgeInsets.only(top: 20, bottom: 18),
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 22),
        decoration: BoxDecoration(
            color: Palette.lightGrey,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: Palette.cream,
            )),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Palette.lightGrey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 0,
              backgroundColor: Palette.lightGrey,
              bottom: TabBar(
                indicatorColor: Palette.green,
                tabs: [
                  Tab(
                    child: Text(
                      'HITTING',
                      style: Styles.normalText,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'PITCHING',
                      style: Styles.normalText,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              // For Hitting
              Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...hitting1.entries
                          .map((stat) => _statsText(stat.key, stat.value))
                          .toList(),
                      _statsVDivider(),
                      ...hitting2.entries
                          .map((stat) => _statsText(stat.key, stat.value))
                          .toList(),
                    ],
                  ),
                  _statsHDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...hitting3.entries
                          .map((stat) => _statsText(stat.key, stat.value))
                          .toList(),
                      _statsVDivider(),
                      ...hitting4.entries
                          .map((stat) => _statsText(stat.key, stat.value))
                          .toList(),
                    ],
                  ),
                ],
              ),
              // For Pitching
              Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pitching1.entries
                        .map((stat) => _statsText(stat.key, stat.value))
                        .toList(),
                  ),
                  _statsHDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...pitching2.entries
                          .map((stat) => _statsText(stat.key, stat.value))
                          .toList(),
                      _statsVDivider(),
                      ...pitching3.entries
                          .map((stat) => _statsText(stat.key, stat.value))
                          .toList(),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
