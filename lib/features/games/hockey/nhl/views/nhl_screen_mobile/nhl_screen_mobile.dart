import 'package:flutter/material.dart';
import 'package:vegas_lit/features/games/hockey/nhl/models/nhl_team.dart';
import '../../../../../../data/models/nhl/nhl_game.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class MobileNhlScreen extends StatelessWidget {
  const MobileNhlScreen({
    required this.gameName,
    required this.games,
    required this.parsedTeamData,
  });
  final List<NhlGame>? games;
  final String gameName;
  final List<NhlTeam>? parsedTeamData;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: games!.length,
      itemBuilder: (context, index) {
        return MatchupCard.route(
          game: games![index],
          gameName: gameName,
          parsedTeamData: parsedTeamData,
        );
      },
    );
  }
}
