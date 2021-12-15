import 'package:flutter/material.dart';

import '../../../../../../data/models/nfl/nfl_game.dart';
import '../../models/nfl_team.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class MobileNflScreen extends StatelessWidget {
  const MobileNflScreen({
    required this.gameName,
    required this.games,
    required this.parsedTeamData,
  });
  final List<NflGame>? games;
  final String gameName;
  final List<NflTeam>? parsedTeamData;
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
