import 'package:flutter/material.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/games/football/ncaaf/widgets/matchup_card/matchup_card.dart';

class MobileNcaafScreen extends StatelessWidget {
  MobileNcaafScreen({
    @required this.gameName,
    @required this.games,
    @required this.parsedTeamData,
  });
  final List<Game> games;
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
