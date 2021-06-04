import 'package:flutter/material.dart';
import '../../../../../../data/models/nhl/nhl_game.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class MobileNhlScreen extends StatelessWidget {
  MobileNhlScreen({
    @required this.gameName,
    @required this.games,
    @required this.parsedTeamData,
  });
  final List<NhlGame> games;
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
