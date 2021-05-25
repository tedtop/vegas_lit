import 'package:flutter/material.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/games/football/nfl/widgets/matchup_card/matchup_card.dart';

class TabletNflScreen extends StatelessWidget {
  TabletNflScreen({this.gameName, this.games, this.parsedTeamData});
  final List<Game> games;
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
