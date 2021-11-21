import 'package:flutter/material.dart';
import 'package:vegas_lit/features/games/basketball/ncaab/models/ncaab_team.dart';
import '../../../../../../data/models/ncaab/ncaab_game.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class MobileNcaabScreen extends StatelessWidget {
  const MobileNcaabScreen({
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
    return ListView.builder(
      key: Key('${games.length}'),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: games.length,
      itemBuilder: (context, index) {
        final awayTeamData = teamData.singleWhere(
          (element) => element.key == games[index].awayTeam,
        );
        final homeTeamData = teamData.singleWhere(
          (element) => element.key == games[index].homeTeam,
        );
        return MatchupCard.route(
          game: games[index],
          gameName: gameName,
          awayTeamData: awayTeamData,
          homeTeamData: homeTeamData,
        );
      },
    );
  }
}
