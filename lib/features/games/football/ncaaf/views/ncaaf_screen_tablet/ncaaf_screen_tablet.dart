import 'package:flutter/material.dart';
import 'package:vegas_lit/features/games/football/ncaaf/models/ncaaf_team.dart';
import '../../../../../../data/models/ncaaf/ncaaf_game.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class TabletNcaafScreen extends StatelessWidget {
  const TabletNcaafScreen({
    Key key,
    this.gameName,
    this.games,
    this.parsedTeamData,
  }) : super(key: key);

  final List<NcaafGame> games;
  final String gameName;
  final List<NcaafTeam> parsedTeamData;

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
