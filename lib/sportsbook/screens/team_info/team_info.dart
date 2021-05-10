import 'package:api_client/api_client.dart';
import 'package:api_client/src/models/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/shared_widgets/app_bar.dart';
import 'package:vegas_lit/sportsbook/models/team.dart';
import 'package:vegas_lit/sportsbook/screens/player_details/player_details.dart';

import 'cubit/team_info_cubit.dart';

class TeamInfo extends StatelessWidget {
  TeamInfo._({this.teamData, this.gameName});
  final Team teamData;
  final String gameName;

  static Route route({@required Team teamData, @required String gameName}) {
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
  final Team teamData;
  final String gameName;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          'TEAM PROFILE',
          style: GoogleFonts.nunito(
              fontSize: 24, color: Palette.green, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _teamBadge(size),
        BlocConsumer<TeamInfoCubit, TeamInfoState>(
            builder: (context, state) {
              if (state is TeamInfoOpened) {
                final players = state.player;
                return _buildPlayersList(players);
              } else {
                return const CircularProgressIndicator();
              }
            },
            listener: (context, state) {})
      ],
    );
  }

  Widget _buildPlayersList(List<Player> players) {
    final teamColor = int.parse('0xA6${teamData.primaryColor}'.toString());
    return Expanded(
        child: ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                PlayerDetailsPage.route(
                    gameName: gameName,
                    playerId: players[index].playerID.toString()));
          },
          leading: CircleAvatar(
            child: Image.network(players[index].photoUrl),
            backgroundColor: Color(teamColor),
            minRadius: 30,
            maxRadius: 30,
          ),
          title: Text('${players[index].firstName} ${players[index].lastName}'),
          trailing: Text('Position : ${players[index].position}'),
          // subtitle: const Text('Backup:'),
        );
      },
      itemCount: players.length,
    ));
  }

  Widget _teamBadge(Size size) {
    return Container(
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
                style: GoogleFonts.nunito(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Palette.darkGrey,
                ),
              ),
              Text(
                teamData.city,
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  color: Palette.darkGrey,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ],
          ),
        ],
      ),
      color: Palette.cream,
    );
  }
}
