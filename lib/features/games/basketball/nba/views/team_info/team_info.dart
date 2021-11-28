import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/palette.dart';
import '../../../../../../config/styles.dart';
import '../../../../../../data/models/nba/nba_player.dart';
import '../../../../../../data/models/nba/nba_team_stats.dart';
import '../../../../../../data/repositories/sport_repository.dart';
import '../../../../../../utils/app_bar.dart';
import '../../../../../../utils/vl_image.dart';
import '../../models/nba_team.dart';
import '../player_details/player_details.dart';
import 'cubit/team_info_cubit.dart';

class TeamInfo extends StatelessWidget {
  const TeamInfo._({this.teamData, this.gameName});
  final NbaTeam? teamData;
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

  static Route route({required NbaTeam teamData, required String? gameName}) {
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
  final NbaTeam? teamData;
  final String? gameName;

  Widget _teamStats(NbaTeamStats stats) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
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
                    'FG%',
                    style: Styles.teamStatsMain.copyWith(color: Palette.cream),
                  ),
                  Text(
                    stats.fieldGoalsPercentage.toString(),
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

  Widget _buildPlayersList(List<NbaPlayer> players) {
    final teamColor = teamData!.primaryColor != null
        ? int.parse('0xA6${teamData!.primaryColor}'.toString())
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
                                players[index].position.toString(),
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
        //_teamStats(),
        //const SizedBox(height: 12),
        BlocBuilder<TeamInfoCubit, TeamInfoState>(
          builder: (context, state) {
            if (state is TeamInfoOpened) {
              return Column(
                children: [
                  _teamStats(state.teamStats),
                  NbaTeamStatsBox(
                    statset1: <String, dynamic>{
                      'G': state.teamStats.games,
                      'W': state.teamStats.wins,
                      'L': state.teamStats.losses,
                      'MIN': state.teamStats.minutes,
                    },
                    statset2: <String, dynamic>{
                      'FGM': state.teamStats.fieldGoalsMade,
                      'FG%': state.teamStats.fieldGoalsPercentage,
                      '3PM': state.teamStats.threePointersMade,
                      '3P%': state.teamStats.threePointersPercentage,
                      'FTM': state.teamStats.freeThrowsMade,
                      'FT%': state.teamStats.freeThrowsPercentage,
                    },
                    statset3: <String, dynamic>{
                      'OREB': state.teamStats.offensiveRebounds,
                      'DREB': state.teamStats.defensiveRebounds,
                      'REB': state.teamStats.rebounds,
                    },
                    statset4: <String, dynamic>{
                      'AST': state.teamStats.assists,
                      'STL': state.teamStats.steals,
                      'BLK': state.teamStats.blockedShots,
                      'TO': state.teamStats.turnovers,
                      'PF': state.teamStats.personalFouls,
                      'PTS': state.teamStats.points,
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
        )
      ],
    );
  }
}

class NbaTeamStatsBox extends StatelessWidget {
  const NbaTeamStatsBox({
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
            t2.toString(),
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
