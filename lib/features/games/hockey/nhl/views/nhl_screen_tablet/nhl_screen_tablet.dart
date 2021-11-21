import 'package:flutter/material.dart';
import 'package:vegas_lit/features/games/hockey/nhl/models/nhl_team.dart';
import '../../../../../../data/models/nhl/nhl_game.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class TabletNhlScreen extends StatelessWidget {
  const TabletNhlScreen({this.gameName, this.games, this.parsedTeamData});
  final List<NhlGame>? games;
  final String? gameName;
  final List<NhlTeam>? parsedTeamData;
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
