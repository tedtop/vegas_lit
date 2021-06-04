import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../home/widgets/bottombar.dart';
import '../../interstitial/screens/interstitial_page.dart';
import '../../shared_widgets/abstract_card.dart';

import 'bet_slip_page.dart';

class RewardedBetSlip extends StatelessWidget {
  RewardedBetSlip();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonWidthHeight = size.width * .30;

    return SingleChildScrollView(
      child: Column(
        children: [
          BetSlipUpper(),
          AbstractCard(
            widgets: [
              Text(
                'Your bets are placed!',
                style: Styles.betSlipBoxLargeText,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Column(
                  children: [
                    textPoints(
                      'Need more funds to bet?',
                    ),
                    const SizedBox(
                      height: 15,
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
                          borderRadius:
                              BorderRadius.circular(buttonWidthHeight),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Watch',
                                style: GoogleFonts.nunito(
                                  color: Palette.cream,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Video',
                                style: GoogleFonts.nunito(
                                  color: Palette.cream,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
          style: Styles.betSlipBoxNormalText,
        ),
      ],
    );
  }
}
