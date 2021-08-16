import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/data/models/ncaaf/ncaaf_team_stats.dart';
import 'package:vegas_lit/utils/app_bar.dart';

import '../../../../../../config/palette.dart';
import '../../../../../../config/styles.dart';
import '../../../../../../data/models/ncaaf/ncaaf_player.dart';
import '../../../../../../data/repositories/sports_repository.dart';

import '../../models/ncaaf_team.dart';
import '../player_details/player_details.dart';
import 'cubit/team_info_cubit.dart';

class TeamInfo extends StatelessWidget {
  TeamInfo._({this.teamData, this.gameName});
  final NcaafTeam teamData;
  final String gameName;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: adaptiveAppBar(width: width),
      body: TeamInfoView(teamData: teamData, gameName: gameName),
    );
  }

  static Route route(
      {@required NcaafTeam teamData, @required String gameName}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'TeamInfo'),
      builder: (context) => BlocProvider<TeamInfoCubit>(
        create: (_) => TeamInfoCubit(SportsRepository())
          ..getTeamDetails(teamData.key, gameName),
        child: TeamInfo._(teamData: teamData, gameName: gameName),
      ),
    );
  }
}

class TeamInfoView extends StatelessWidget {
  TeamInfoView({this.teamData, this.gameName});
  final NcaafTeam teamData;
  final String gameName;
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
        BlocConsumer<TeamInfoCubit, TeamInfoState>(
            builder: (context, state) {
              if (state is TeamInfoOpened) {
                return Column(
                  children: [
                    _teamStats(state.teamStats),
                    _buildPlayersList(state.players),
                  ],
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
            listener: (context, state) {})
      ],
    );
  }

  Widget _teamStats(NcaafTeamStats stats) {
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
                    stats.fieldGoalPercentage.toString(),
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
          const SizedBox(height: 10),
          StatsBox(
            statMap: stats.toStatOnlyMap(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayersList(List<NcaafPlayer> players) {
    final teamColor = teamData.primaryColor != null
        ? int.parse('0xA6${teamData.primaryColor}'.toString())
        : Palette.lightGrey.value;
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PlayerDetailsPage.route(
                      gameName: gameName,
                      playerId: players[index].playerId.toString(),
                      playerDetails: players[index]));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
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
                        Text(
                          '${players[index].firstName} ${players[index].lastName}',
                          style: Styles.normalText,
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
                        players[index].photoUrl,
                        imageRenderMethodForWeb:
                            ImageRenderMethodForWeb.HttpGet),
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
            child: teamData.wikipediaLogoUrl != null
                ? SvgPicture.network(
                    teamData.wikipediaLogoUrl,
                    fit: BoxFit.fill,
                    height: 100,
                  )
                : SizedBox(
                    height: 100,
                    child: CircleAvatar(
                      backgroundColor: Palette.lightGrey,
                      child: Text(
                        teamData.name.characters.first,
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
                teamData.name,
                style: Styles.largeTextBold.copyWith(fontSize: 30),
              ),
              Text(
                teamData.city.toUpperCase(),
                style: Styles.normalText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
