import 'package:flutter/material.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/features/nascar_mock/constants.dart';
import 'package:vegas_lit/features/nascar_mock/nascar_button.dart';
import 'package:vegas_lit/features/nascar_mock/pick_player.dart';

class RaceList extends StatelessWidget {
  const RaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: NascarStyles.theme,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: AppBar(
            backgroundColor: NascarPalette.darkBlack,
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              children: [
                const SizedBox(height: 60),
                Image.asset('${Images.nascarAssetsPath}NASCAR-logo.png'),
                const SizedBox(height: 8),
                Image.asset('${Images.nascarAssetsPath}draft-partner.png'),
              ],
            ),
          ),
        ),
        backgroundColor: NascarPalette.darkBlack,
        body: Center(
          child: SizedBox(
            width: 380,
            child: ListView(
              children: const [
                RaceCard(
                  raceName: 'Talladega 500 Race',
                  fee: 'FREE',
                  entries: 48,
                  estPrize: 100,
                ),
                RaceCard(
                  raceName: 'Talladega Sprint 1',
                  fee: 'FREE',
                  entries: 48,
                  estPrize: 100,
                ),
                RaceCard(
                  raceName: 'Talladega Sprint 2',
                  fee: 'FREE',
                  entries: 48,
                  estPrize: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RaceCard extends StatelessWidget {
  const RaceCard({
    Key? key,
    required this.raceName,
    required this.fee,
    required this.entries,
    required this.estPrize,
  }) : super(key: key);

  final String raceName, fee;
  final int entries, estPrize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: NascarPalette.lightBlack,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(color: NascarPalette.lightBlack, width: 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'NASCAR',
            style: NascarStyles.largeText,
          ),
          Text(
            raceName,
            style: NascarStyles.mediumText,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: NascarPalette.darkBlack,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'FEE: ',
                        style: NascarStyles.smallLightText,
                        children: <TextSpan>[
                          TextSpan(
                            text: fee,
                            style: NascarStyles.smallBoldText,
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'ENTRIES: ',
                        style: NascarStyles.smallLightText,
                        children: <TextSpan>[
                          TextSpan(
                            text: '$entries',
                            style: NascarStyles.smallBoldText,
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'est. PRIZE: ',
                        style: NascarStyles.smallLightText,
                        children: <TextSpan>[
                          TextSpan(
                            text: '\$$estPrize',
                            style: NascarStyles.smallBoldText,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                NascarButton(
                  text: 'ENTER',
                  action: () => Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                          builder: (context) => const PickPlayer())),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
