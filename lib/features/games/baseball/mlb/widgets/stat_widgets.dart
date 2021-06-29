import 'package:flutter/material.dart';
import 'package:vegas_lit/config/styles.dart';

class StatsText extends StatelessWidget {
  const StatsText({Key key, this.leftText, this.rightText}) : super(key: key);
  final String leftText;
  final String rightText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leftText, style: Styles.teamStatsText),
        Text(rightText, style: Styles.teamStatsText),
      ],
    );
  }
}
