import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/helpers/olympic_helper.dart';
import 'package:vegas_lit/data/models/olympics/olympics.dart';

class OlympicsMatchupCard extends StatelessWidget {
  const OlympicsMatchupCard._(
      {Key key, @required this.gameName, @required this.game})
      : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
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
                          '${Images.olympicsIconsPath}${game.gameName}.png',
                          height: 35,
                          width: 35,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${game.gameName}',
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
                          Text(
                            OlympicHelper.countryFlagFromCode(
                                countryCode: game.playerCountry),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${game.player}',
                            style: Styles.normalText,
                          ),
                        ],
                      ),
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
                          color: Palette.green),
                      child: Row(
                        children: [
                          Text(
                            OlympicHelper.countryFlagFromCode(
                                countryCode: game.rivalCountry),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${game.rival}',
                            style: Styles.normalText,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('E, MMMM, c, y @ hh:mm a')
                              .format(game.startTime),
                          style: Styles.matchupTime,
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //   child: CountdownTimer(
                  //     endTime: ESTDateTime.getESTmillisecondsSinceEpoch(
                  //       DateTime.parse(game.startTime),
                  //     ),
                  //     widgetBuilder: (_, CurrentRemainingTime time) {
                  //       if (time == null) {
                  //         return Container();
                  //       }

                  //       final hours =
                  //           time.hours == null ? '' : ' ${time.hours}hr';
                  //       final min = time.min == null ? '' : ' ${time.min}m';
                  //       final sec = time.sec == null ? '' : ' ${time.sec}s';

                  //       return Text(
                  //         'Starting in$hours$min$sec',
                  //         style: GoogleFonts.nunito(
                  //           fontSize: 15,
                  //           color: Palette.red,
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
