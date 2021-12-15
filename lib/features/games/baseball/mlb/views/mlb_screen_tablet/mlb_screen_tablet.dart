import 'package:flutter/material.dart';

import '../../../../../../data/models/mlb/mlb_game.dart';
import '../../models/mlb_team.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class TabletMlbScreen extends StatelessWidget {
  const TabletMlbScreen({this.gameName, this.games, this.parsedTeamData});
  final List<MlbGame>? games;
  final String? gameName;
  final List<MlbTeam>? parsedTeamData;
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
