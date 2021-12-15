import 'package:flutter/material.dart';
import 'package:vegas_lit/features/games/basketball/nba/models/nba_team.dart';
import '../../../../../../data/models/nba/nba_game.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class TabletNbaScreen extends StatelessWidget {
  const TabletNbaScreen({this.gameName, this.games, this.parsedTeamData});
  final List<NbaGame>? games;
  final String? gameName;
  final List<NbaTeam>? parsedTeamData;
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
                teamData: parsedTeamData,
              ),
            )
            .toList());
  }
}
