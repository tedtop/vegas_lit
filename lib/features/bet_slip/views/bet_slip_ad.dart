import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/features/home/widgets/bottombar.dart';
import 'package:vegas_lit/features/interstitial/screens/interstitial_page.dart';
import 'package:vegas_lit/features/shared_widgets/abstract_card.dart';

import 'bet_slip_page.dart';

class RewardedBetSlip extends StatelessWidget {
  RewardedBetSlip();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonWidthHeight = size.width * .22;

    return SingleChildScrollView(
      child: Column(
        children: [
          BetSlipUpper(),
          AbstractCard(
            crossAxisAlignment: CrossAxisAlignment.start,
            widgets: [
              Text(
                'Your bets are placed!',
                style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Palette.cream),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textPoints(
                        'Need more funds to bet?',
                      ),
                      textPoints(
                        '1. Click the button',
                      ),
                      textPoints(
                        '2. Watch a video',
                      ),
                      textPoints(
                        '3. Earn \$100 of Vegas Bucks!',
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        Interstitial.route(),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Palette.green,
                        borderRadius: BorderRadius.circular(buttonWidthHeight),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      width: buttonWidthHeight,
                      height: buttonWidthHeight,
                      child: Center(
                          child: Text(
                        'Watch Video',
                        style: GoogleFonts.nunito(
                          color: Palette.cream,
                        ),
                      )),
                    ),
                  )
                ],
              ),
            ],
          ),
          kIsWeb ? const BottomBar() : const SizedBox(),
        ],
      ),
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
