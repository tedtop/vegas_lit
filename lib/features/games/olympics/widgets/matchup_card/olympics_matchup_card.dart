import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/olympics/olympics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/features/games/olympics/cubit/olympics_cubit.dart';
import 'package:vegas_lit/features/games/olympics/widgets/bet_button/cubit/olympics_bet_button_cubit.dart';
import 'package:vegas_lit/features/games/olympics/widgets/bet_button/screens/bet_button_widget.dart';
import 'package:vegas_lit/features/profile/profile.dart';

enum WinnerOlympics { player, rival, none }

class OlympicsMatchupCard extends StatefulWidget {
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
  _OlympicsMatchupCardState createState() => _OlympicsMatchupCardState();
}

class _OlympicsMatchupCardState extends State<OlympicsMatchupCard> {
  WinnerOlympics winner;
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.select((ProfileCubit profileCubit) =>
        profileCubit.state.userData?.isAdmin ?? false);
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
                          '${Images.olympicsIconsPath}${widget.game.gameName}.png',
                          height: 35,
                          width: 35,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${widget.game.gameName}',
                          style: Styles.normalTextBold,
                        ),
                      ],
                    ),
                  ),
                  BetButton.route(
                    game: widget.game,
                    league: widget.gameName,
                    winTeam: BetButtonWin.player,
                  ),
                  BetButton.route(
                    game: widget.game,
                    league: widget.gameName,
                    winTeam: BetButtonWin.rival,
                  ),
                  isAdmin
                      ? Visibility(
                          visible: visible,
                          replacement: Padding(
                            padding:
                                const EdgeInsets.only(top: 20, bottom: 6.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(
                                  color: Palette.cream,
                                ),
                              ],
                            ),
                          ),
                          child: widget.game.winner == null
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Radio(
                                          value: WinnerOlympics.player,
                                          fillColor: MaterialStateProperty.all(
                                              Palette.green),
                                          groupValue: winner,
                                          onChanged: (value) {
                                            setState(() {
                                              winner = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Player',
                                          style: GoogleFonts.nunito(
                                            fontSize: 15,
                                            color: Palette.cream,
                                          ),
                                        ),
                                        Radio(
                                          value: WinnerOlympics.rival,
                                          fillColor: MaterialStateProperty.all(
                                              Palette.green),
                                          groupValue: winner,
                                          onChanged: (value) {
                                            setState(() {
                                              winner = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Rival',
                                          style: GoogleFonts.nunito(
                                            fontSize: 15,
                                            color: Palette.cream,
                                          ),
                                        ),
                                        Radio(
                                          value: WinnerOlympics.none,
                                          fillColor: MaterialStateProperty.all(
                                              Palette.green),
                                          groupValue: winner,
                                          onChanged: (value) {
                                            setState(() {
                                              winner = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          'None',
                                          style: GoogleFonts.nunito(
                                            fontSize: 15,
                                            color: Palette.cream,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                              const EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 20,
                                              ),
                                            ),
                                            elevation:
                                                MaterialStateProperty.all(4.0),
                                            shape: MaterialStateProperty.all(
                                                Styles.smallRadius),
                                            textStyle:
                                                MaterialStateProperty.all(
                                              const TextStyle(
                                                  color: Palette.cream),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Palette.green),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap),
                                        child: Text(
                                          'Submit',
                                          style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (isAdmin == true) {
                                            if (winner != null) {
                                              String winnerText;
                                              switch (winner) {
                                                case WinnerOlympics.player:
                                                  winnerText = 'player';
                                                  break;
                                                case WinnerOlympics.rival:
                                                  winnerText = 'rival';
                                                  break;
                                                default:
                                                  winnerText = 'none';
                                              }
                                              setState(() {
                                                visible = false;
                                              });
                                              await context
                                                  .read<OlympicsCubit>()
                                                  .updateOlympicsGame(
                                                    game: widget.game.copyWith(
                                                      isClosed: true,
                                                      winner: winnerText,
                                                    ),
                                                  );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Are you mad? Select some value first.',
                                                      style:
                                                          GoogleFonts.nunito(),
                                                    ),
                                                  ),
                                                );
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                              ..hideCurrentSnackBar()
                                              ..showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Admin privileges required.',
                                                    style: GoogleFonts.nunito(),
                                                  ),
                                                ),
                                              );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('E, MMMM, c, y @ hh:mm a')
                              .format(widget.game.startTime),
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
                  //         'Starting in  ${TimerHelper.getRemainingTimeText(time:time)}',
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
