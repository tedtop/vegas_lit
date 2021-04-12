import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/open_bets/screens/open_bet_card.dart';

class BetHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            text: 'All Bet Types',
          ),
          const TextBar(
            text: 'All Leagues',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 8,
            ),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Palette.lightGrey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    const BetHistoryRow(
                      text: 'Your Rank',
                      text2: 'N/A',
                    ),
                    const BetHistoryRow(
                      text: 'Total Bets Placed',
                      text2: '94',
                    ),
                    const BetHistoryRow(
                      text: 'Total Risk',
                      text2: '\$5,006.00',
                      color: Palette.green,
                    ),
                    const BetHistoryRow(
                      text: 'Total Profit',
                      text2: '\$2,034.00',
                      color: Palette.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(
              5,
              (index) => OpenBetsSlip(
                openBets: OpenBetsData(
                  isClosed: false,
                  gameId: 35633356223,
                  amount: 50,
                  away: 'MAVERICKS',
                  home: 'WIZARDS',
                  dateTime: 'Saturday, April, 3, 2021 @ 07:00 PM',
                  id: '3uk8swPIVf1akCRZ1T4e',
                  type: 'POINT SPREAD',
                  league: 'MLB',
                  mlAmount: 100,
                  win: 58,
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
    this.color = Palette.cream,
  }) : super(key: key);

  final String text;
  final String text2;
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
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Palette.cream,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              text2,
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

class TextBar extends StatelessWidget {
  const TextBar({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Container(
          color: Palette.green,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          height: 40,
          width: double.infinity,
          child: Center(
            child: DropdownButton<String>(
              dropdownColor: Palette.green,
              isDense: true,
              value: 'All Bet Types',
              icon: const Icon(
                Icons.arrow_circle_down,
                color: Palette.cream,
              ),
              isExpanded: true,
              underline: Container(
                height: 0,
              ),
              style: GoogleFonts.nunito(
                fontSize: 18,
              ),
              onChanged: print,
              items: <String>[
                'All Bet Types',
                'List 2',
                'List 3',
                'List 4',
                'List 5',
                'List 6',
              ].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Palette.cream,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
