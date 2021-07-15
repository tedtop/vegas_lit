import 'package:flutter/material.dart';
import 'package:vegas_lit/data/models/bet.dart';

class OlympicBetHistoryCard extends StatelessWidget {
  const OlympicBetHistoryCard({
    Key key,
    @required this.betHistoryData,
  })  : assert(betHistoryData != null),
        super(key: key);

  final BetData betHistoryData;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
