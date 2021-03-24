import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/widgets/abstract_card.dart';

import 'bet_slip_page.dart';

class EmptyBetSlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BetSlipUpper(),
        AbstractCard(
          crossAxisAlignment: CrossAxisAlignment.start,
          widgets: [
            Text(
              'Your Bet List is\ncurrently Empty.',
              style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Palette.cream),
            ),
            const SizedBox(
              height: 20,
            ),
            textPoints(
              '1. Find a game you are interested in',
            ),
            textPoints(
              '2. Click on the link you\'d like to bet on',
            ),
            textPoints(
              // ignore: lines_longer_than_80_chars
              '3. Your bet will show up in this area where you can place your bet',
            ),
          ],
        ),
      ],
    );
  }

  Widget textPoints(String text) {
    return Column(
      children: [
        Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w200,
            color: Palette.cream,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
