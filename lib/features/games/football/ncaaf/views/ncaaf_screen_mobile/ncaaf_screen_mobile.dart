

import 'package:flutter/material.dart';
import 'package:vegas_lit/features/games/football/ncaaf/models/ncaaf_team.dart';
import '../../../../../../data/models/ncaaf/ncaaf_game.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class MobileNcaafScreen extends StatelessWidget {
  const MobileNcaafScreen({
    Key? key,
    required this.gameName,
    required this.games,
    required this.parsedTeamData,
  }) : super(key: key);
  final List<NcaafGame>? games;
  final String gameName;
  final List<NcaafTeam>? parsedTeamData;
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
