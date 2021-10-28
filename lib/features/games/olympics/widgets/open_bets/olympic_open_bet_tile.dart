

import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/data/models/olympics/olympic_bet.dart';

class OlympicsOpenBetTile extends StatelessWidget {
  const OlympicsOpenBetTile({
    Key? key,
    required this.openBets,
  })  : assert(openBets != null),
        super(key: key);

  final OlympicsBetData openBets;
  @override
  Widget build(BuildContext context) {
    //final isPlayerWin = openBets.betTeam == 'player' ? true : false;
    return Center(
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            constraints: const BoxConstraints(maxWidth: 1200),
            child: const ListTile(
                tileColor: Palette.lightGrey, title: Text('OLYMPICS'))));
  }
}
