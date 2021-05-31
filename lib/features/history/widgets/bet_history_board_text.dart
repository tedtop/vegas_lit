import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

class BetHistoryBoardText extends StatelessWidget {
  const BetHistoryBoardText({
    Key key,
    @required this.leftText,
    @required this.rightText,
    this.color = Palette.cream,
  }) : super(key: key);

  final String leftText;
  final String rightText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              leftText,
              style: Styles.betHistoryNormal,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              rightText,
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
