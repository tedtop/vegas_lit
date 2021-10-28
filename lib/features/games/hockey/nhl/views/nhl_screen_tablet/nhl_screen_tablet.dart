

import 'package:flutter/material.dart';
import '../../../../../../data/models/nhl/nhl_game.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class TabletNhlScreen extends StatelessWidget {
  TabletNhlScreen({this.gameName, this.games, this.parsedTeamData});
  final List<NhlGame>? games;
  final String? gameName;
  final List? parsedTeamData;
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
