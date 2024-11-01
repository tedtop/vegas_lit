import 'package:flutter/material.dart';

import '../../../../../../data/models/nfl/nfl_game.dart';
import '../../models/nfl_team.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class TabletNflScreen extends StatelessWidget {
  const TabletNflScreen({this.gameName, this.games, this.parsedTeamData});
  final List<NflGame>? games;
  final String? gameName;
  final List<NflTeam>? parsedTeamData;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        childAspectRatio: 1.5,
        crossAxisCount: 2,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        children: games!
            .map(
              (game) => MatchupCard.route(
                game: game,
                gameName: gameName,
                parsedTeamData: parsedTeamData,
              ),
            )
            .toList());
  }
}
