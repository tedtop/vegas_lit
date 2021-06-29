import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

class DummyMatchCard extends StatelessWidget {
  const DummyMatchCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          width: 390,
          decoration: BoxDecoration(
            border: Border.all(
              color: Palette.cream,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Card(
            margin: EdgeInsets.zero,
            color: Palette.lightGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 150,
                                // height: 25,
                                child:
                                    //  Column(
                                    //   children: [
                                    //     Text(
                                    //      'New York',
                                    //       textAlign: TextAlign.center,
                                    //       style: GoogleFonts.nunito(
                                    //         fontSize: 12,
                                    //         color: Palette.cream,
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //     ),
                                    Text(
                                  'WARRIORS',
                                  textAlign: TextAlign.center,
                                  style: Styles.awayTeam,
                                ),
                                //   ],
                                // ),
                              ),
                              const SizedBox(height: 5),
                              Column(
                                children: [
                                  const DummyMatchCardButton(text: '+144'),
                                  const DummyMatchCardButton(text: '+4  -110'),
                                  const DummyMatchCardButton(
                                      text: 'o22.5  +113'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 2),
                            Text(
                              '@',
                              style: Styles.matchupSeparator,
                            ),
                            const SizedBox(height: 16),
                            const DummyMatchButtonSeperator(text: 'ML'),
                            const SizedBox(height: 2),
                            const DummyMatchButtonSeperator(text: 'PTS'),
                            const SizedBox(height: 1),
                            const DummyMatchButtonSeperator(text: 'TOT'),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 150,
                                // height: 25,
                                child:
                                    //  Column(
                                    //   children: [
                                    //     Text(
                                    //      'New York',
                                    //       textAlign: TextAlign.center,
                                    //       style: GoogleFonts.nunito(
                                    //         fontSize: 12,
                                    //         color: Palette.cream,
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //     ),
                                    Text(
                                  'LAKERS',
                                  textAlign: TextAlign.center,
                                  style: Styles.awayTeam,
                                ),
                                //   ],
                                // ),
                              ),
                              const SizedBox(height: 5),
                              Column(
                                children: [
                                  const DummyMatchCardButton(
                                    text: '-231',
                                    color: Palette.green,
                                  ),
                                  const DummyMatchCardButton(text: '-4  -110'),
                                  const DummyMatchCardButton(
                                      text: 'u22.5  +109'),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 4),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         'Sat, June, 26, 2021 @ 01:10 PM',
                    //         style: Styles.matchupTime,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Text(
                    //   'Starting in 3hr 46m 20s',
                    //   style: GoogleFonts.nunito(
                    //     fontSize: 15,
                    //     color: Palette.red,
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DummyMatchCardButton extends StatelessWidget {
  const DummyMatchCardButton(
      {Key key, this.text, this.color = Palette.darkGrey})
      : super(key: key);
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
            width: 150,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: color),
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  color: Palette.cream,
                ),
              ),
            )));
  }
}

class DummyMatchButtonSeperator extends StatelessWidget {
  const DummyMatchButtonSeperator({Key key, this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.5),
      child: Text(
        text,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(
          color: Palette.cream,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
