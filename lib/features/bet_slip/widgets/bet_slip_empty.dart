import 'package:flutter/material.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';

class EmptyBetSlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //BetSlipUpper(),
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
                "2. Click on the link you'd like to bet on",
              ),
              textPoints(
                '3. Your bet will show up in this area where you can place your bet',
              ),
            ],
          ),
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

class ParlayBetSlipWarning extends StatelessWidget {
  const ParlayBetSlipWarning({Key? key, required this.isMinimum})
      : super(key: key);

  final bool isMinimum;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //BetSlipUpper(),
          AbstractCard(
            crossAxisAlignment: CrossAxisAlignment.start,
            widgets: [
              isMinimum
                  ? Text(
                      'A minimum of 2 picks are required to create a parlay',
                      style: Styles.normalTextBold,
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      'You can create a parlay between 2 and 6 picks',
                      style: Styles.normalTextBold,
                      textAlign: TextAlign.center,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class AbstractCard extends StatelessWidget {
  const AbstractCard({
    Key? key,
    required this.widgets,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12.5,
      vertical: 12.0,
    ),
  }) : super(key: key);

  final List<Widget> widgets;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
              padding: padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: crossAxisAlignment,
                children: widgets,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
