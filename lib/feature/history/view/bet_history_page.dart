import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

class BetHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.lightGrey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'BET HISTORY',
                  style: Styles.pageTitle,
                ),
              ),
            ],
          ),
          const TextBar(
            text: 'All Time',
          ),
          const TextBar(
            text: 'All Leagues',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const BetHistoryRow(
                      text: 'Your Rank',
                      text2: 'N/A',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const BetHistoryRow(
                      text: 'Total Bets Placed',
                      text2: '94',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const BetHistoryRow(
                      text: 'Total Risk',
                      text2: '\$5,006.00',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const BetHistoryRow(
                      text: 'Total Profit',
                      text2: '\$2,034.00',
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BetHistoryRow extends StatelessWidget {
  const BetHistoryRow({
    Key key,
    @required this.text,
    @required this.text2,
  }) : super(key: key);

  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
        Text(
          text2,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class TextBar extends StatelessWidget {
  const TextBar({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Container(
          color: Palette.darkGrey,
          padding: const EdgeInsets.all(8.0),
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: GoogleFonts.nunito(
                  color: Palette.cream,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Icon(
                LineAwesomeIcons.arrow_down,
              )
            ],
          ),
        ),
      ),
    );
  }
}
