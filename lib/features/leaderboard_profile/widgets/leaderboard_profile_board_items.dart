import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';

class LeaderboardProfileHistoryBoardText extends StatelessWidget {
  const LeaderboardProfileHistoryBoardText({
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
            child: AutoSizeText(
              leftText,
              style: Styles.betHistoryNormal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: AutoSizeText(
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

class DesktopBetHistoryBoardItem extends StatelessWidget {
  const DesktopBetHistoryBoardItem(
      {Key key, this.topText, this.bottomText, this.color = Palette.cream})
      : super(key: key);
  final String topText, bottomText;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
      decoration: BoxDecoration(
          color: Palette.darkGrey,
          borderRadius: BorderRadius.circular(12),
          boxShadow: <BoxShadow>[
            BoxShadow(
                offset: const Offset(0, 4.0),
                blurRadius: 0.4,
                color: Palette.darkGrey.withAlpha(80))
          ]),
      child: Column(
        children: [
          AutoSizeText(
            topText,
            style: Styles.pageTitle.copyWith(color: color),
          ),
          AutoSizeText(
            bottomText,
            style: Styles.normalTextBold,
          )
        ],
      ),
    );
  }
}
