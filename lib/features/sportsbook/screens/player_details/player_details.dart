import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/data/repositories/sports_repository.dart';
import 'package:vegas_lit/features/shared_widgets/app_bar.dart';

import 'cubit/player_details_cubit.dart';

class PlayerDetailsPage extends StatelessWidget {
  PlayerDetailsPage({this.playerId, this.gameName});
  final String playerId;
  final String gameName;

  static Route route({@required String playerId, @required String gameName}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'PlayerDetails'),
      builder: (context) => BlocProvider<PlayerDetailsCubit>(
        create: (_) => PlayerDetailsCubit(
            sportsRepository: SportsRepository(), gameName: gameName)
          ..fetchPlayerDetails(playerID: playerId),
        child: PlayerDetailsPage(playerId: playerId, gameName: gameName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
        children: [
          Text(
            'PLAYER PROFILE',
            style: GoogleFonts.nunito(
              fontSize: 24,
              color: Palette.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildProfileWidget(size),
        ],
      ),
    );
  }

  Container _buildProfileWidget(Size size) {
    return Container(
      width: size.width,
      height: 180,
      color: Palette.cream,
      child: BlocConsumer<PlayerDetailsCubit, PlayerDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PlayerDetailsFetched) {
            final playerDetaials = state.playerDetails;

            return Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Image.network(state.playerDetails.photoUrl),
                    minRadius: 35,
                    maxRadius: 35,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${playerDetaials.firstName} ${playerDetaials.lastName}',
                        style: GoogleFonts.nunito(
                          color: Palette.darkGrey,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '#${playerDetaials.jersey} ${playerDetaials.position} ${playerDetaials.team}',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          color: Palette.darkGrey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _showTextRow(
                        title: 'Height/Weight',
                        data:
                            '${playerDetaials.height}/${playerDetaials.weight} LBS',
                      ),
                      _showTextRow(
                        title: 'Date of Birth',
                        data: '${_getDateTime(playerDetaials.birthDate)}',
                      ),
                      _showTextRow(
                        title: 'Experience',
                        data: '${playerDetaials.experience}th Season',
                      ),
                      _showTextRow(
                        title: 'Drafted',
                        data: 'to be filled',
                      ),
                      _showTextRow(
                        title: 'College',
                        data: '${playerDetaials.college}',
                      ),
                    ],
                  )
                ],
              ),
            );
          } else
            return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  String _getDateTime(String date) {
    var dateAndTime = DateTime.parse(date).toString();
    final indexOfSpace = dateAndTime.indexOf(' ');
    dateAndTime = dateAndTime.substring(0, indexOfSpace);

    return dateAndTime;
  }

  Widget _showTextRow({String title, String data}) {
    return Row(
      children: [
        Text(
          '$title',
          textAlign: TextAlign.right,
          style: GoogleFonts.nunito(
            color: Palette.darkGrey,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$data',
          style: GoogleFonts.nunito(
            color: Palette.darkGrey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
