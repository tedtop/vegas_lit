import 'package:flutter/material.dart';
import 'package:vegas_lit/features/games/basketball/ncaab/models/ncaab_team.dart';
import '../../../../../../data/models/ncaab/ncaab_game.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class TabletNcaabScreen extends StatelessWidget {
  const TabletNcaabScreen({
    Key? key,
    required this.games,
    required this.gameName,
    required this.teamData,
  }) : super(key: key);

  final List<NcaabGame> games;
  final String gameName;
  final List<NcaabTeam> teamData;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 1.5,
      crossAxisCount: 2,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      children: games.map(
        (game) {
          final awayTeamData = teamData.singleWhere(
            (element) => element.key == game.awayTeam,
          );
          final homeTeamData = teamData.singleWhere(
            (element) => element.key == game.homeTeam,
          );
          return MatchupCard.route(
            game: game,
            gameName: gameName,
            awayTeamData: awayTeamData,
            homeTeamData: homeTeamData,
          );
        },
      ).toList(),
    );
  }
}
