

import 'package:flutter/material.dart';
import '../../../../../../data/models/ncaab/ncaab_game.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class MobileNcaabScreen extends StatelessWidget {
  MobileNcaabScreen({
    required this.gameName,
    required this.games,
    required this.parsedTeamData,
  });
  final List<NcaabGame>? games;
  final String gameName;
  final List? parsedTeamData;
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
