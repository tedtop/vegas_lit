import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/player.dart';
import 'package:vegas_lit/data/repositories/sports_repository.dart';
import 'package:vegas_lit/features/games/basketball/nba/models/nba_team.dart';
import 'package:vegas_lit/features/games/basketball/nba/views/player_details/player_details.dart';
import 'package:vegas_lit/features/shared_widgets/app_bar.dart';

import 'cubit/team_info_cubit.dart';

class TeamInfo extends StatelessWidget {
  TeamInfo._({this.teamData, this.gameName});
  final NbaTeam teamData;
  final String gameName;

  static Route route({@required NbaTeam teamData, @required String gameName}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'TeamInfo'),
      builder: (context) => BlocProvider<TeamInfoCubit>(
        create: (_) => TeamInfoCubit(SportsRepository())
          ..listTeamPlayers(teamData.key, gameName),
        child: TeamInfo._(teamData: teamData, gameName: gameName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: TeamInfoView(teamData: teamData, gameName: gameName),
    );
  }
}

class TeamInfoView extends StatelessWidget {
  TeamInfoView({this.teamData, this.gameName});
  final NbaTeam teamData;
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
        _teamStats(),
        const SizedBox(height: 12),
        BlocConsumer<TeamInfoCubit, TeamInfoState>(
            builder: (context, state) {
              if (state is TeamInfoOpened) {
                final players = state.player;
                return _buildPlayersList(players);
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Palette.cream,
                ));
              }
            },
            listener: (context, state) {})
      ],
    );
  }

  Widget _buildPlayersList(List<Player> players) {
    final teamColor = int.parse('0xA6${teamData.primaryColor}'.toString());
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
                      playerId: players[index].playerID.toString()));
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
                  ClipOval(
                    child: CircleAvatar(
                      child: Image.network(players[index].photoUrl),
                      backgroundColor: Color(teamColor).withOpacity(1),
                      minRadius: 30,
                      maxRadius: 30,
                    ),
                  ),
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
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: SvgPicture.network(
                teamData.wikipediaLogoUrl,
                height: 80,
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

  Widget _teamStats() {
    //CHANGE REAL DATA HERE
    final tableStats = {
      'FIELD GOALS': [2937, 6953, 52.6],
      'TWO POINTERS': [2937, 6953, 52.6],
      'THREE POINTERS': [2937, 6953, 52.6],
      'FREE THROWS': [2937, 6953, 52.6]
    };
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 80,
              child: Center(
                child: Text(
                  'WON',
                  style: Styles.normalText
                      .copyWith(color: Palette.green, fontSize: 28),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 100,
              child: Center(
                child: Text(
                  'GAMES',
                  style: Styles.normalText
                      .copyWith(color: Palette.cream, fontSize: 28),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 110,
              child: Center(
                child: Text(
                  'LOSSES',
                  style: Styles.normalText
                      .copyWith(color: Palette.red, fontSize: 28),
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              width: 80,
              child: Center(
                child: Text(
                  '45',
                  style: Styles.normalText
                      .copyWith(color: Palette.green, fontSize: 34),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              width: 100,
              child: Center(
                child: Text(
                  '65',
                  style: Styles.normalText
                      .copyWith(color: Palette.cream, fontSize: 34),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              width: 110,
              child: Center(
                child: Text(
                  '12',
                  style: Styles.normalText
                      .copyWith(color: Palette.red, fontSize: 34),
                ),
              ),
            )
          ],
        ),
        Container(
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: 60,
                      child: Text(
                        'MADE',
                        style: Styles.normalText.copyWith(fontSize: 13),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                      width: 80,
                      child: Text(
                        'ATTEMPTED',
                        style: Styles.normalText.copyWith(fontSize: 13),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                      width: 90,
                      child: Text(
                        'PERCENTAGE',
                        style: Styles.normalText.copyWith(fontSize: 13),
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
              ...tableStats.keys
                  .map(
                    (fieldName) => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          fieldName,
                          style: Styles.normalText.copyWith(fontSize: 13),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 60,
                            child: Text(
                              tableStats[fieldName][0].toString(),
                              style:
                                  Styles.greenTextBold.copyWith(fontSize: 13),
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                            width: 80,
                            child: Text(
                              tableStats[fieldName][1].toString(),
                              style: Styles.greenTextBold
                                  .copyWith(fontSize: 13, color: Palette.red),
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                            width: 90,
                            child: Text(
                              tableStats[fieldName][2].toString(),
                              style:
                                  Styles.normalTextBold.copyWith(fontSize: 13),
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: 90,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      'REBOUNDS',
                      style: Styles.normalText
                          .copyWith(color: Palette.green, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: 90,
                  margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  child: Center(
                    child: Text(
                      '45',
                      style: Styles.normalText
                          .copyWith(color: Palette.green, fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  width: 90,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      'ASSISTS',
                      style: Styles.normalText
                          .copyWith(color: Palette.green, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  width: 90,
                  child: Center(
                    child: Text(
                      '45',
                      style: Styles.normalText
                          .copyWith(color: Palette.green, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 90,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      'BLOCKED',
                      style: Styles.normalText
                          .copyWith(color: Palette.cream, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: 90,
                  margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  child: Center(
                    child: Text(
                      '65',
                      style: Styles.normalText
                          .copyWith(color: Palette.cream, fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  width: 90,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      'STEALS',
                      style: Styles.normalText
                          .copyWith(color: Palette.cream, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: 90,
                  margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  child: Center(
                    child: Text(
                      '65',
                      style: Styles.normalText
                          .copyWith(color: Palette.cream, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      'TURNOVERS',
                      style: Styles.normalText
                          .copyWith(color: Palette.red, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  child: Center(
                    child: Text(
                      '12',
                      style: Styles.normalText
                          .copyWith(color: Palette.red, fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  width: 135,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      'PERSONAL FOULS',
                      style: Styles.normalText
                          .copyWith(color: Palette.red, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: 140,
                  margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  child: Center(
                    child: Text(
                      '12',
                      style: Styles.normalText
                          .copyWith(color: Palette.red, fontSize: 20),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
