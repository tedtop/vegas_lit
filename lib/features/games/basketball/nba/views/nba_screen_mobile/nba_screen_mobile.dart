import 'package:flutter/material.dart';
import 'package:vegas_lit/features/games/basketball/nba/models/nba_team.dart';
import '../../../../../../data/models/nba/nba_game.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class MobileNbaScreen extends StatelessWidget {
  const MobileNbaScreen({
    required this.gameName,
    required this.games,
    required this.parsedTeamData,
  });
  final List<NbaGame>? games;
  final String gameName;
  final List<NbaTeam>? parsedTeamData;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: games!.length,
      itemBuilder: (context, index) {
        return MatchupCard.route(
          game: games![index],
          gameName: gameName,
          teamData: parsedTeamData,
        );
      },
    );
  }
}
