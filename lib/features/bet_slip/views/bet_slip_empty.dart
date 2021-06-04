import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../config/styles.dart';
import '../../home/widgets/bottombar.dart';
import '../../shared_widgets/abstract_card.dart';
import 'bet_slip_page.dart';

class EmptyBetSlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BetSlipUpper(),
          AbstractCard(
            crossAxisAlignment: CrossAxisAlignment.start,
            widgets: [
              Text(
                'Your Bet List is\ncurrently Empty.',
                style: Styles.betSlipBoxLargeText,
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
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
