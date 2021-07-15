import 'package:flutter/material.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/olympics/olympics.dart';

class OlympicsMatchupCard extends StatelessWidget {
  const OlympicsMatchupCard._({
    Key key,
    @required this.gameName,
    @required this.game,
  }) : super(key: key);

  final String gameName;
  final OlympicsGame game;

  static Builder route({
    @required OlympicsGame game,
    @required String gameName,
  }) {
    return Builder(
      builder: (_) {
        return OlympicsMatchupCard._(gameName: gameName, game: game);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
          decoration: BoxDecoration(
            border: Border.all(
              color: Palette.cream,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 12,
          ),
          child: Card(
            margin: EdgeInsets.zero,
            color: Palette.lightGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          '${Images.olympicsIconsPath}Shooting.png',
                          height: 35,
                          width: 35,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${game.sport}',
                          style: Styles.normalTextBold,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                          width: 330,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Palette.darkGrey),
                          child: Row(
                            children: [
                              Image.asset(
                                '${Images.countryIconsPath}GB.png',
                                height: 25,
                                width: 25,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${game.player1}',
                                style: Styles.normalText,
                              ),
                            ],
                          ))),
                  Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                          width: 330,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Palette.green),
                          child: Row(
                            children: [
                              Image.asset(
                                '${Images.countryIconsPath}RU.png',
                                height: 25,
                                width: 25,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${game.player2}',
                                style: Styles.normalText,
                              ),
                            ],
                          ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${game.date}',
                          style: Styles.matchupTime,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
