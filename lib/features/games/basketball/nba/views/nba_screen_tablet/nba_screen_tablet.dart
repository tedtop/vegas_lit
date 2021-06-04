import 'package:flutter/material.dart';
import '../../../../../../data/models/nba/nba_game.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class TabletNbaScreen extends StatelessWidget {
  TabletNbaScreen({this.gameName, this.games, this.parsedTeamData});
  final List<NbaGame> games;
  final String gameName;
  final dynamic parsedTeamData;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        childAspectRatio: 1.5,
        crossAxisCount: 2,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        children: games
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
