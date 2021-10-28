

import 'package:flutter/material.dart';
import 'package:vegas_lit/features/games/baseball/mlb/models/mlb_team.dart';
import '../../../../../../data/models/mlb/mlb_game.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class MobileMlbScreen extends StatelessWidget {
  MobileMlbScreen({
    required this.gameName,
    required this.games,
    required this.parsedTeamData,
  });
  final List<MlbGame>? games;
  final String gameName;
  final List<MlbTeam>? parsedTeamData;
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
          parsedTeamData: parsedTeamData,
        );
      },
    );
  }
}
