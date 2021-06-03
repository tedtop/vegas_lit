import 'package:flutter/material.dart';
import 'package:vegas_lit/data/models/nfl/nfl_game.dart';
import 'package:vegas_lit/features/games/football/nfl/widgets/matchup_card/matchup_card.dart';

class MobileNflScreen extends StatelessWidget {
  MobileNflScreen({
    @required this.gameName,
    @required this.games,
    @required this.parsedTeamData,
  });
  final List<NflGame> games;
  final String gameName;
  final dynamic parsedTeamData;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: games.length,
      itemBuilder: (context, index) {
        return MatchupCard.route(
          game: games[index],
          gameName: gameName,
          parsedTeamData: parsedTeamData,
        );
      },
    );
  }
}
