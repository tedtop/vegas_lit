import 'package:flutter/material.dart';
import 'package:vegas_lit/data/models/bet.dart';

class OlympicOpenBetCard extends StatelessWidget {
  const OlympicOpenBetCard({
    Key key,
    @required this.openBets,
  })  : assert(openBets != null),
        super(key: key);

  final BetData openBets;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
