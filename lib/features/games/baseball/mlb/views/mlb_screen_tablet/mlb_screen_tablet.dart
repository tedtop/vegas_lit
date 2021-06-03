import 'package:flutter/material.dart';
import 'package:vegas_lit/data/models/mlb/mlb_game.dart';
import 'package:vegas_lit/features/games/baseball/mlb/widgets/matchup_card/matchup_card.dart';

class TabletMlbScreen extends StatelessWidget {
  TabletMlbScreen({this.gameName, this.games, this.parsedTeamData});
  final List<MlbGame> games;
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
