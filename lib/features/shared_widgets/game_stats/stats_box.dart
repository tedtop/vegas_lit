import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

class StatsBox extends StatelessWidget {
  const StatsBox({Key key, @required this.statMap}) : super(key: key);
  final Map<String, dynamic> statMap;

  List<Widget> _statMapToList() {
    return statMap.keys.map(
      (key) {
        if (statMap[key] != null)
          return StatsText(
            leftText: key,
            rightText: statMap[key],
          );
        else
          return const SizedBox();
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final statsList = _statMapToList();
    final statsOffset = (statsList.length ~/ 2) + 8;
    return Container(
      width: 380,
      margin: const EdgeInsets.only(top: 20, bottom: 40),
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 22),
      decoration: BoxDecoration(
          color: Palette.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: Palette.cream,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Column(
              children: statsList.sublist(0, statsOffset),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
              child: Column(
            children: statsList.sublist(statsOffset),
          ))
        ],
      ),
    );
  }
}

class StatsText extends StatelessWidget {
  const StatsText({Key key, this.leftText, this.rightText}) : super(key: key);
  final String leftText;
  final dynamic rightText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 110, child: Text(leftText, style: Styles.teamStatsText)),
        Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Text('$rightText', style: Styles.teamStatsText))),
      ],
    );
  }
}
