import 'package:flutter/material.dart';
import 'package:vegas_lit/features/games/baseball/mlb/models/mlb_team.dart';

import '../../../../../../data/models/mlb/mlb_game.dart';
import '../../../../../bet_slip/bet_slip.dart';
import '../../widgets/matchup_card/matchup_card.dart';

class DesktopMlbScreen extends StatelessWidget {
  const DesktopMlbScreen(
      {Key key, this.gameName, this.games, this.parsedTeamData})
      : super(key: key);
  final List<MlbGame> games;
  final String gameName;
  final List<MlbTeam> parsedTeamData;
  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    return
        // Container(
        //   constraints: BoxConstraints(maxWidth: 800, minWidth: 700),
        //   child:
        FittedBox(
      fit: BoxFit.scaleDown,
      // width: width < 1200 ? width : 1200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanded(child: Container()),
          Container(
            constraints: const BoxConstraints(maxWidth: 800, minWidth: 700),
            child: GridView.count(
                childAspectRatio: 1.5,
                crossAxisCount: 2,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: games
                    .map(
                      (game) => MatchupCard.route(
                          game: game,
                          gameName: gameName,
                          parsedTeamData: parsedTeamData),
                    )
                    .toList()),
          ),
          BetSlip()
        ],
      ),
      // ),
    );
  }
}
