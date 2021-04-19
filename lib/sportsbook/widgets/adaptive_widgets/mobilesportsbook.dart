import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:vegas_lit/sportsbook/widgets/matchup_card/matchup_card.dart';

class MobileSportsbook extends StatelessWidget {
  MobileSportsbook({this.gameName, this.games});
  final List<Game> games;
  final String gameName;
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
        );
      },
    );
  }
}
